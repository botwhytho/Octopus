package.path = '/Users/Louise/Desktop/Octopus/microphone/?.lua;'..package.path

local entity = require('player')
local scene = require('scene')

local microphone = require("microphone")
local device, source

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)
	player = entity.create('/assets/octo.png')

	-- Report the name of the microphone we're going to use
	print("Opening microphone:", microphone.getDefaultDeviceName())

	-- Open the default microphone device with default quality and 100ms of latency.
	device = microphone.openDevice(nil, nil, 0.1)

	-- Create a new QueueableSource to echo our audio
	source = microphone.newQueueableSource()

	-- Register our local callback
	device:setDataCallback(function(device, data)
		source:queue(data)
		source:play()
	end)
	-- Start recording
	device:start()
end

function love.update(dt)
	if love.keyboard.isDown('escape') then love.event.quit() end


	player:handleInput()

	player:update(dt, device:poll())

end

function love.draw()
	scene:draw()
	player:draw()
end
