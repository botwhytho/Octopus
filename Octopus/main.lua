local entity = require('entity')

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	player = entity.create()
end

function love.update(dt)
	if love.keyboard.isDown('escape') then love.event.quit() end
	
	player:handleInput()
	player:update(dt)
end

function love.draw()
	love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle('fill', 0, (love.graphics.getHeight()/1.2), love.graphics.getWidth(), love.graphics.getHeight())
	love.graphics.setColor(100, 100, 100)
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end
