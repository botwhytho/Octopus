local swim = {}

function swim.update(enemy, dt)
   enemy.x = enemy.x + (swim.direction * (swim.speed * dt))
   if enemy.x + enemy.w < -10 then swim.direction = 1
   elseif enemy.x > (love.graphics.getWidth()+30) then swim.direction = -1
   end
end

swim.speed = 300
swim.direction = -1

return swim
