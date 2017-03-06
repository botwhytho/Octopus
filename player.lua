local player = {}

local function handleInput(player)
	if love.keyboard.isDown('w') then
		player.isJumping = true
	end

	if love.keyboard.isDown('d') or love.keyboard.isDown('right') then player.direction = 1
	elseif love.keyboard.isDown('a') or love.keyboard.isDown('left') then player.direction = -1
	else player.direction = 0
	end
end

local function update(player, dt, peakamp)
	if (peakamp or 0) > 30 and player.isJumping == false then
		player.yVel = peakamp*-5
		print(player.yVel)
		player.isJumping = true
	end

	if player.isJumping then player:jump(dt) end

	player.x = player.x + player.direction * (player.speed * dt)

end

local function jump(player, dt)
	--player.yVel = player.yVel or -400
	local gravity = 900

	player.y = player.y + player.yVel * dt
	player.yVel = player.yVel + gravity * dt

	if player.y >= love.graphics.getHeight()/1.2 - player.h then -- y-position of the ground
		player.y = love.graphics.getHeight()/1.2 - player.h
		player.isJumping = false
		--player.yVel = 0
	end
end

local function draw(player)
	--love.graphics.setColor(100, 100, 100)
	--love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
	love.graphics.draw(player.sprite, player.x, player.y, 0, 0.35, 0.35)
end

function player.create(filepath)
	local player = {}
	player.sprite = love.graphics.newImage(filepath)
	player.w = 35
	player.h = 35
	player.x = 10
	player.y = love.graphics.getHeight()/1.2 - player.h

	player.direction = 1
	player.speed = 200

	player.isJumping = false
	player.yVel = 0

	player.update = update
	player.handleInput = handleInput
	player.jump = jump
	player.draw = draw

	return player
end

return player
