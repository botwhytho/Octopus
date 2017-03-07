package.path =  arg[1] .. '/love-microphone/?/init.lua;' .. arg[1] .. '/love-microphone/?.lua;' .. package.path
print(package.path)
local entity = require('player')
local enemy = require('enemy')
local scene = require('scene')
local microphone = require('love-microphone')
local device, source

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	player = entity.create('/assets/octo.png')
	turtle = enemy.create('/assets/turtle.png')

	-- Open the default microphone device with default quality and 10ms of latency.
	device = microphone.openDevice(nil, nil, 0.01)
	device:start()
end

function love.update(dt)
	if love.keyboard.isDown('escape') then love.event.quit() end

	--player:handleInput(device:poll())
	player:update(dt, device:poll())
end

function love.draw()
  love.graphics.print({{0,0,0},love.timer.getFPS()}, 0,0)
	scene:draw()
	player:draw()
end
