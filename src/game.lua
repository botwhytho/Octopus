local game = {}

local entity = require('src.entities.player')
local enemy = require('src.entities.enemy')
local scene = require('src.scene')
local hud = require('src.hud')
local swim = require('src.movement.swim')

function game.init(state, microphone)
   state.microphone = microphone

   state.player = entity.create('assets/shitsprites.png')
   state.hud = hud.create(state.player.health, 100, 100)
   state.level = scene

   state.enemies = {}
   table.insert(state.enemies, enemy.create('assets/fish.png', 200, 400, swim))
   table.insert(state.enemies, enemy.create('assets/turtle.png', 400, state.player.y))
end

local function checkCollision(player, others)
   -- if player's coordinates are outside of enemy's bounding box then we can't have collision
   for i, v in pairs(others) do
      if not ((player.x + player.w) < v.x  or player.x > (v.x + v.w) or
               player.y > (v.y + v.h) or (player.y + player.h) < v.y)
               then return true end
   end

   return false
end

function game.update(state, dt, micAmp)
   if love.keyboard.isDown('escape') then
      love.event.quit()
   end

	state.player:update(dt, state.microphone:poll())
   for i, v in pairs(state.enemies) do
      v:update(dt)
   end

   if checkCollision(state.player, state.enemies) then
     if state.player.notColliding then
        state.player.notColliding = false
        state.player.isCarryingSomething = false
        state.player.health = state.player.health - 1
        -- if state.player.health == 0 then love.event.quit("restart") end --Placeholder for losing game
        state.hud:update(state.player)
        -- state.player.x = state.player.x - 20 --Maybe blink player
      end
    else
      state.player.notColliding = true
   end

   if state.player.x + state.player.w < love.graphics.getWidth()/10*1.5 then --Change state when player gets a computer
     state.player.isCarryingSomething = true and state.player.isCarryingSomething or true
   end

   if state.player.x > love.graphics.getWidth()/10*8.5 then --Change state when player scores
     if state.player.isCarryingSomething then
       state.player.score = state.player.score + 1
     end
     --[[If the player reaches the goal without losing health, immediately
        set isCarryingSomething to false to score doesn't increase on each frame
     ]]
     state.player.isCarryingSomething = state.player.isCarryingSomething and false
   end

end

function game.draw(state)
   state.level:draw()

   state.player:draw()
   for i, v in pairs(state.enemies) do
      v:draw()
   end

   state.hud:draw(state.player)
end

return game
