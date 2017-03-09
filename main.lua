package.path =  arg[1] .. '/love-microphone/?/init.lua;' .. arg[1] .. '/love-microphone/?.lua;' .. package.path
--local gamestate = require('src.game')
local gameState = require('src.menu')
local microphone = require('love-microphone')
local device, source

local function changeState(oldState, newState)
	newState:init(device, changeState)
	gameState = newState
	oldState = nil
end

function love.load()
	love.graphics.setBackgroundColor(255, 255, 255, 255)

	-- Open the default microphone device with default quality and 100ms of latency.
	device = microphone.openDevice(nil, nil, 0.1)
	device:start()

	gameState:init(device, changeState)
end

function love.update(dt)
	gameState:update(dt)
end

function love.draw()
	gameState:draw()
end
