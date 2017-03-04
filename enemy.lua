local enemy = {}

local function draw()
   love.graphics.setColor(100, 100, 70)
	love.graphics.rectangle('fill', player.x, player.y, player.w, player.h)
end

function enemy.create(filepath)
   local instance = {}
   instance.sprite = love.graphics.newImage(filepath)
   instance.w = 20
   instance.h = 20
   instance.x = 120
   instance.y = love.graphics.getHeight()/1.2 - instance.h
   return instance
end

return enemy
