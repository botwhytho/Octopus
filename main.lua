package.path =  arg[1] .. '/love-microphone/?/init.lua;' .. arg[1] .. '/love-microphone/?.lua;' .. package.path
local gamestate = require('src.game')
local microphone = require('love-microphone')
local device, source

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)

	-- Open the default microphone device with default quality and 100ms of latency.
	device = microphone.openDevice(nil, nil, 0.1)
	device:start()

	gamestate:init(device)
end

function love.update(dt)
	gamestate:update(dt)
end

function love.draw()
	gamestate:draw()
end
