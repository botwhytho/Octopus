local game = {}

local entity = require('src.entities.player')
local enemy = require('src.entities.enemy')
local scene = require('src.scene')
local hud = require('src.hud')
local xyMove = require('src.movement.xyMovement')
local exit = require('src.movement.exitScreen')
local object = require('src.entities.object')

local function collision(player, others, xTol, yTol)
   -- Negative tolerance value causes bounding box to shrink (less lenient)
   xTol = xTol or 0
   yTol = yTol or 0

   -- if player's coordinates are outside of enemy's bounding box then we can't have collision
   for i, v in pairs(others) do
      if not ((player.x + player.w) < v.x-xTol  or player.x-xTol > (v.x + v.w) or
               player.y-yTol > (v.y + v.h) or (player.y + player.h) < v.y-yTol)
               then return true end
   end
   return false
end

function game.init(state, microphone, changeState)
   love.graphics.setBackgroundColor(255, 255, 255)
   local font = love.graphics.newFont('assets/GreenFlame.ttf', c.BODY_SIZE)
   love.graphics.setFont(font)

   state.oldTime = love.timer.getTime()
   state.microphone = microphone

   state.pause = false
   state.level = scene
   state.level.level = 1
   state.levelDuration = c.LVL_DURATION
   state.player = entity.create('assets/shitsprites.png', c.PLAYER_X, c.PLAYER_Y)
   state.hud = hud.create(state.player.health, c.HEALTH_X, c.HEALTH_Y)

   state.enemies = {}
   table.insert(state.enemies, enemy.create('assets/fish.png', love.graphics.getWidth(), 200, xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED)))
   table.insert(state.enemies, enemy.create('assets/fish2.png', -50, 300, xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED)))
   table.insert(state.enemies, enemy.create('assets/turtle.png', 400, state.level.groundY))
   table.insert(state.enemies, enemy.create('assets/hook.png', 200, 150, xyMove.create(0, c.HOOK_YSPEED)))
   table.insert(state.enemies, enemy.create('assets/hook.png', 620, 250, xyMove.create(0, c.HOOK_YSPEED, nil, -1)))

   state.clock = object.create('assets/clock.png', love.graphics.getWidth(), 0) -- spawn off-screen
   state.computer = object.create('assets/recurseLogo.png', c.OBJECT_X, c.PLAYER_Y - state.player.h)
   state.goal = enemy.create('assets/crab.png', state.level.goalX, state.level.groundY, exit.create(state.level.goalX))
end

function game.update(state, dt)
   function love.keypressed(key)
      if key == "space" then
         state.pause = not state.pause
      elseif key == "escape" then
         love.event.quit()
      end
   end

   -- 'Pause' game if time runs out
   if not state.pause and state.levelDuration > 0 then

      --Level Duration logic
      local new = love.timer.getTime()
      if new - state.oldTime > 1 then
         state.oldTime = new
         state.levelDuration = state.levelDuration - 1
      end

      state.player:update(dt, state.microphone:poll())

      for i, v in pairs(state.enemies) do
         v:update(dt)
      end

      -- Player collision with enemies
      if collision(state.player, state.enemies) then
         if state.player.hasObject then state.computer:reset() end
         state.player:handleCollision()
      else
         state.player.collided = false
      end

      -- Computer collision with enemies
      if collision(state.computer, state.enemies) then
         state.player.hasObject = false
         state.computer:reset()
      end

      -- Object logic: Clock
      -- Clock not in play
      if state.clock.x == love.graphics.getWidth() then
         if math.random(c.CLOCK_SPAWN_P) == 2 then
         state.clock:reset(math.random(love.graphics.getWidth() - state.clock.w),
                           math.random(love.graphics.getHeight() - (love.graphics.getHeight() - c.GROUND_Y) - state.clock.h))
         end
      -- Clock in play
      else
         state.clock.timer = (state.clock.timer or 0) + dt
         if state.clock.timer > c.CLOCK_LIFETIME then
            state.clock:reset(love.graphics.getWidth(), 0)
            state.clock.timer = 0
         end

         if collision(state.player, {state.clock}, -5, -5) then
            state.levelDuration = state.levelDuration + 5
            state.clock:reset(love.graphics.getWidth(), 0)
         end
      end


      -- Object logic: Computer, pick up if player is 'near enough'
      if collision(state.player, {state.computer}, -10, 10)
      and not state.player.hasObject and not state.goal.hasObject then
         state.player.hasObject = true
      end

      -- If computer was picked up: stick to player
      state.computer:update(state.player, dt)
      state.computer:update(state.goal, dt)

      -- Drop off object
      if collision(state.player, {state.goal}, -(state.goal.w/2), -(state.goal.w/2)) then
         if state.player.hasObject then
            state.player.score = state.player.score + 1
            state.player.hasObject = false
            state.goal.hasObject = true
         end
      end

      -- Handle object drop-off
      state.goal:update(dt)

   elseif state.levelDuration == 0 then
      if love.keyboard.isDown('return') then
         state.level.level = state.level.level + 1
         state.player.x = c.PLAYER_X
         state.player.y = c.PLAYER_Y - state.player.h
         state.player.hasObject = false
         state.computer:reset()
         state.levelDuration = c.LVL_DURATION

         table.insert(state.enemies, enemy.create('assets/hook.png', love.math.random(5,love.graphics.getWidth()), 150, xyMove.create(0, c.HOOK_YSPEED)))
         table.insert(state.enemies, enemy.create('assets/fish.png', love.graphics.getWidth(), love.math.random(love.graphics.getHeight()*0.25,love.graphics.getHeight()*0.75), xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED)))
      end
   end

end

function game.draw(state)
   state.level:draw()

   for i, v in pairs(state.enemies) do
      v:draw()
   end

   state.player:draw()
   state.computer:draw()
   state.goal:draw()
   state.clock:draw()

   state.hud:draw(state.player, state.levelDuration, state.pause, state.level.level)
end

return game
