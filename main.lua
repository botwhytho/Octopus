package.path =  arg[1] .. '/love-microphone/?/init.lua;' .. arg[1] .. '/love-microphone/?.lua;' .. package.path
local gameState = require('src.menu')
local microphone = require('love-microphone')
local device, source
c = require('src.constants')

local function changeState(oldState, newState)
	newState:init(device, changeState)
	gameState = newState
	oldState = nil
end

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)

	-- Open the default microphone device with default quality and 10ms of latency.
	device = microphone.openDevice(nil, nil, c.MIC_LATENCY)
	device:start()

	gameState:init(device, changeState)
end

function love.update(dt)
	gameState:update(dt)
end

function love.draw()
	gameState:draw()
end
