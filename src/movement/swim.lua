local swim = {}

local function update(enemy, dt)
   -- Horizontal movement
   enemy.x = enemy.x + (enemy.movement.direction * (enemy.movement.speed * dt))
   if enemy.x + enemy.w < -10 then enemy.movement.direction = 1
   elseif enemy.x > (love.graphics.getWidth()+30) then enemy.movement.direction = -1
   end

   -- Vertical movement
   local jiggle =  enemy.movement.ySpeed * dt
   enemy.y = enemy.y + (enemy.movement.yDirection * jiggle)
   enemy.movement.currJiggle = enemy.movement.currJiggle + jiggle
   if enemy.movement.currJiggle > enemy.movement.maxJiggle then
      enemy.movement.yDirection = -1 * enemy.movement.yDirection
      enemy.movement.currJiggle = 0
   end
end

function swim.create()
   swim = {}
   swim.speed = 300
   swim.direction = -1

   swim.yDirection = 1
   swim.ySpeed = 90
   swim.maxJiggle = 40
   swim.currJiggle = 0
   swim.update = update
   return swim
end

return swim
