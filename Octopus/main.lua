local entity = require('player')
local scene = require('scene')

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	player = entity.create('/assets/octo.png')
end

function love.update(dt)
	if love.keyboard.isDown('escape') then love.event.quit() end

	player:handleInput()
	player:update(dt)
end

function love.draw()
	scene:draw()
	player:draw()
end
