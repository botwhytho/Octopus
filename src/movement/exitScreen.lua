local exitscreen = {}

local function update(enemy, dt)
   if enemy.hasObject or enemy.x > enemy.movement.originX then

      enemy.x = enemy.x + enemy.movement.direction * (enemy.movement.speed * dt)

      if enemy.x <= enemy.movement.originX then
         enemy.x = enemy.movement.originX
         enemy.movement.direction = 1
      end

      if enemy.x > love.graphics.getWidth()+enemy.w then
         enemy.movement.direction = -1
         enemy.hasObject = false
      end
   end
end

function exitscreen.create(xPos)
   local exit = {}
   exit.update = update
   exit.speed = 300
   exit.direction = 1
   exit.originX = xPos
   return exit
end

return exitscreen
