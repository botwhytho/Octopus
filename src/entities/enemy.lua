local enemy = {}

local function draw(enemy)
      local xscale = ((enemy.movement and enemy.movement.direction) == 1) and -0.5 or 0.5

      love.graphics.draw(enemy.sprite, enemy.x, enemy.y, 0, xscale, 0.5)
end

local function update(enemy, dt)
   if enemy.movement then
      enemy.movement.update(enemy, dt) -- kind of ugly..
   end
end

function enemy.create(filepath, x, y, mov)
   local instance = {}
   instance.sprite = love.graphics.newImage(filepath)
   instance.w = instance.sprite:getWidth()/2
   instance.h = instance.sprite:getHeight()/2
   instance.x = x
   instance.y = y

   instance.movement = mov

   instance.update = update
   instance.draw = draw
   return instance
end

return enemy
