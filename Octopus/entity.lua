local entity = {}

local function handleInput(player)
	if love.keyboard.isDown('w') then
		player.isJumping = true
	end

	if love.keyboard.isDown('d') then player.direction = 1
	elseif love.keyboard.isDown('a') then player.direction = -1
	else player.direction = 0
	end
end

local function update(player, dt)
	player.x = player.x + player.direction * (player.speed * dt)
	if player.isJumping then player:jump(dt) end
end

local function jump(player, dt)
	player.yVel = player.yVel or -400
	local gravity = 1200

	player.y = player.y + player.yVel * dt
	player.yVel = player.yVel + gravity * dt

	if player.y >= love.graphics.getHeight()/1.2 - player.h then -- y-position of the ground
		player.y = love.graphics.getHeight()/1.2 - player.h
		player.isJumping = false
		player.yVel = false
	end
end

local function draw(player)
	love.graphics.setColor(100, 100, 100)
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

-- Feed in sprites and stuff here as well eventually
function entity.create()
	local player = {}
	player.w = 20
	player.h = 20
	player.x = 10
	player.y = love.graphics.getHeight()/1.2 - player.h

	player.direction = 1
	player.speed = 200

	player.isJumping = false
	player.yVel = false

	player.update = update
	player.handleInput = handleInput
	player.jump = jump
	player.draw = draw

	return player
end

return entity
