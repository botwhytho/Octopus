local swim = {}

function swim.update(enemy, dt)
   -- Horizontal movement
   enemy.x = enemy.x + (swim.direction * (swim.speed * dt))
   if enemy.x + enemy.w < -10 then swim.direction = 1
   elseif enemy.x > (love.graphics.getWidth()+30) then swim.direction = -1
   end

   -- Vertical movement
   local jiggle =  swim.ySpeed * dt
   enemy.y = enemy.y + (swim.yDirection * jiggle)
   swim.currJiggle = swim.currJiggle + jiggle
   if swim.currJiggle > swim.maxJiggle then
      swim.yDirection = -1 * swim.yDirection
      swim.currJiggle = 0
   end
end

swim.speed = 300
swim.direction = -1

swim.yDirection = 1
swim.ySpeed = 50
swim.maxJiggle = 20
swim.currJiggle = 0


return swim
