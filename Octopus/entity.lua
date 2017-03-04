local entity = {}

local function handleInput(player)
	if love.keyboard.isDown('w') then player.isJumping = true end

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
	local gravity = 1200

	player.y = player.y + player.yVel * dt
    player.yVel = player.yVel + gravity * dt

    if player.y >= love.graphics.getHeight()/1.2 - player.h then
    	player.y = love.graphics.getHeight()/1.2 - player.h
    	player.isJumping = false
    end
end

local function draw()
	-- stuff
end

-- Feed in sprites and stuff here as well eventually
function entity.create()
	local player = {}
	player.w = 20
	player.h = 20
	player.x = 10
	player.y = love.graphics.getHeight()/1.2 - player.h

	player.direction = 1
	player.isJumping = false
	player.speed = 200
	player.yVel = -400

	player.update = update
	player.handleInput = handleInput
	player.jump = jump
	
	return player
end

return entity