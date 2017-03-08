local game = {}

local entity = require('src.entities.player')
local enemy = require('src.entities.enemy')
local scene = require('src.scene')
local hud = require('src.hud')
local swim = require('src.movement.swim')

function game.init(state, microphone)
   state.microphone = microphone

   state.level = scene
   state.player = entity.create('assets/shitsprites.png', 200, state.level.groundY)
   state.hud = hud.create(state.player.health, 100, 100)

   state.enemies = {}
   table.insert(state.enemies, enemy.create('assets/fish.png', 200, 400, swim))
   table.insert(state.enemies, enemy.create('assets/turtle.png', 400, state.level.groundY))
end

local function collision(player, others)
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

   if collision(state.player, state.enemies) then
      if not state.player.collided then
         state.player.collided = true
         state.player.hasObject = false
         state.player.health = state.player.health - 1
         state.player.anim.blinking = true
         state.hud:update(state.player.health)
      end
   else
      state.player.collided = false
   end

   if state.player.x + state.player.w < love.graphics.getWidth()/10*1.5 then --Change state when player gets a computer
     state.player.hasObject = true
   end

   if state.player.x > love.graphics.getWidth()/10*8.5 then --Change state when player scores
     if state.player.hasObject then
       state.player.score = state.player.score + 1
       state.player.hasObject = false
     end
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
