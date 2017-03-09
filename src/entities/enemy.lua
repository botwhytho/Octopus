local enemy = {}

local function draw(enemy)
   -- negative scale mirrors the sprite
   local xscale, xoffset = 0.5, 0
   if enemy.movement then
      xscale = (enemy.movement.direction or 0) >= 0 and -0.5 or 0.5
      xoffset = (enemy.movement.direction or 0) <= 0 and 0 or enemy.w
   end
   love.graphics.draw(enemy.anim.spritesheet, enemy.anim.quads[enemy.anim.currFrame], enemy.x + xoffset, enemy.y, 0, xscale, 1/2)
   --love.graphics.draw(enemy.sprite, enemy.x, enemy.y, 0, xscale, 0.5)
end

local function update(enemy, dt)
   enemy.anim:update(dt)
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
   instance.y = y - instance.h
   instance.anim = anim.create(filepath, 1, 1, instance.sprite:getWidth(), instance.sprite:getHeight())

   instance.movement = mov

   instance.update = update
   instance.draw = draw
   return instance
end

return enemy
