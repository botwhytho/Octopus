anim = require('src.movement.animation')

local player = {}

local function handleInput(player, peakAmp)
	-- Set jump height to peakAmp even if already jumping
	if (peakAmp or 0) > 30 then
		player.yVel = peakAmp*-5
		player.isJumping = true
	end

	-- Handle keyboard movement
	if love.keyboard.isDown('d') or love.keyboard.isDown('right') then player.direction = 1
	elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then player.direction = -1
	else player.direction = 0
	end
end

local function update(player, dt, peakamp)
	player.anim:update(dt)
	player:handleInput(peakamp)

	player.x = player.x + player.direction * (player.speed * dt)
	if player.isJumping then player:jump(dt) end
end

local function handleCollision(player)
	if not player.collided then
		player.collided = true
		if player.hasObject then
			player.hasObject = false
		end
		player.health = player.health - 1
		player.anim.blinking = true
	end
end

local function jump(player, dt)
	local gravity = 900

	player.y = player.y + player.yVel * dt
	player.yVel = player.yVel + gravity * dt

	if player.y >= love.graphics.getHeight()/1.2 - player.h then -- y-position of the ground
		player.y = love.graphics.getHeight()/1.2 - player.h
		player.isJumping = false
	end
end

local function draw(player)
	-- Blink if player is hurt
	if player.anim.blinking and player.anim.blinkOn then
		love.graphics.setColor(255, 255, 255, 50)
	end

	-- negative scale mirrors the sprite
	local xscale = player.direction >= 0 and -0.5 or 0.5
	love.graphics.draw(player.anim.spritesheet, player.anim.quads[player.anim.currFrame], player.x, player.y, 0, xscale, 1/2, player.w)
	--love.graphics.setColor(1, 1, 1)
	--love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)

	-- Reset colour modulation
	love.graphics.setColor(255, 255, 255)
end

function player.create(filepath, x, y)
	local player = {}
	player.anim = anim.create(filepath, 4, 0.2, 100, 84)
	player.w = 100/2
	player.h = 84/2
	player.x = x
	player.y = y - player.h

	player.direction = 0
	player.speed = 300
	player.health = 5
	player.score = 0

	player.isJumping = false
	player.yVel = 0
	player.hasObject = false
	player.collided = false

	player.update = update
	player.handleInput = handleInput
	player.handleCollision = handleCollision
	player.shrinkOrGrow = shrinkOrGrow
	player.jump = jump
	player.draw = draw
	return player
end

return player
