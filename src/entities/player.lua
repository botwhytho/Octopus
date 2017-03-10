anim = require('src.movement.animation')

local player = {}

local function handleInput(player, peakAmp)
	-- Set jump height to peakAmp even if already jumping
	if (peakAmp or 0) > c.MIC_THRESHOLD then
		player.yVel = peakAmp*c.MIC_AMP_MULTIPLIER
		player.isJumping = true
	end

	-- Handle keyboard movement & Prevent player from moving outside of the screen
	if love.keyboard.isDown('d') or love.keyboard.isDown('right') then player.direction = 1
	elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then player.direction = -1
	else player.direction = 0
	end
end

local function update(player, dt, peakamp)
	player.anim:update(dt)
	player:handleInput(peakamp)

	local newPos = player.x + player.direction * (player.speed * dt)
	player.x = (newPos > 0 and newPos+player.w < love.graphics.getWidth()) and newPos or player.x
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
	local gravity = c.GRAVITY

	local newY = player.y + player.yVel * dt
	player.y = newY < 0 and player.y or newY
	player.yVel = player.yVel + gravity * dt

	if player.y >= c.PLAYER_Y - c.PLAYER_H then -- player landed
		player.y = c.PLAYER_Y - c.PLAYER_H
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
  	local xoffset = player.direction >= 0 and 0 or player.w
	love.graphics.draw(player.anim.spritesheet, player.anim.quads[player.anim.currFrame], player.x + xoffset, player.y, 0, xscale, 1/2,player.w*2)

	-- Reset colour modulation
	love.graphics.setColor(255, 255, 255)
end

function player.create(filepath, x, y)
	local player = {}
	player.anim = anim.create(filepath, 4, 0.2, 100, 84)
	player.w = c.PLAYER_W
	player.h = c.PLAYER_H
	player.x = x
	player.y = y - player.h

	player.direction = 0
	player.speed = c.PLAYER_SPEED
	player.health = c.PLAYER_HEALTH
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
