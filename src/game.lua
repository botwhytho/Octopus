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

   if (checkCollision(state.player, state.enemies)) then
      state.player.health = state.player.health - 1
      state.hud:update(state.player)
      state.player.x = state.player.x - 100
   end
end

function game.draw(state)
   state.level:draw()

   state.player:draw()
   for i, v in pairs(state.enemies) do
      v:draw()
   end

   state.hud:draw()
end

return game
