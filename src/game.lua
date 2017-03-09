local game = {}

local entity = require('src.entities.player')
local enemy = require('src.entities.enemy')
local scene = require('src.scene')
local hud = require('src.hud')
local swim = require('src.movement.swim')
local object = require('src.entities.object')
--local menu = require('src.menu')


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
   local font = love.graphics.newFont('assets/GreenFlame.ttf', 12)
   love.graphics.setFont(font)
   
   state.oldTime = love.timer.getTime()
   state.microphone = microphone

   state.level = scene
   state.levelDuration = 45
   state.player = entity.create('assets/shitsprites.png', 200, state.level.groundY)
   state.hud = hud.create(state.player.health, 100, 100)

   state.enemies = {}
   table.insert(state.enemies, enemy.create('assets/fish.png', love.graphics.getWidth(), 200, swim.create()))
   table.insert(state.enemies, enemy.create('assets/fish.png', love.graphics.getWidth()*1.25, 300, swim.create()))
   table.insert(state.enemies, enemy.create('assets/turtle.png', 400, state.level.groundY))

   state.computer = object.create(30, state.player.y-50, 50, 50)
   state.goal = enemy.create('assets/octo.png', state.level.goalX, state.level.groundY)
end

function game.update(state, dt)
   if love.keyboard.isDown('escape') then
      love.event.quit()
   end

   -- 'Pause' game if time runs out
   if state.levelDuration > 0 then

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

      -- Handle collision
      if collision(state.player, state.enemies) then
         if state.player.hasObject then state.computer:reset(30, state.level.groundY-state.player.h-50) end
         state.player:handleCollision()
      else
         state.player.collided = false
      end

      if collision(state.computer, state.enemies) then
         state.player.hasObject = false
         state.computer:reset(30, state.level.groundY-state.player.h-50)
      end

      -- Needs to be updated after collision logic and before pick-up logic for accurate 'dropped' values
      state.computer:update(state.player)

      -- Pick up object if player is 'near enough'
      if collision(state.player, {state.computer}, -10, 10)
      and not state.player.hasObject and not state.computer.dropped then
         state.player.hasObject = true
      end

      -- Drop off object
      if collision(state.player, {state.goal}, -(state.goal.w/2), -(state.goal.w/2)) then
         if state.player.hasObject then
            state.player.score = state.player.score + 1
            state.player.hasObject = false
            state.computer:reset(30, state.level.groundY-state.player.h-50)
         end
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

   state.hud:draw(state.player, state.levelDuration)
end

return game
