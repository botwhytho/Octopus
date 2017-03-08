local hud = {}

local function update(hud, player)
   hud.lives = player.health

end

local function draw(hb,player)
   local x, y = hb.x, hb.y
   love.graphics.setColor(219, 78, 78)
   for i=1, hb.lives do
      love.graphics.rectangle('fill', x, y, 15, 15)
      x = x + 20
   end

   if player.health < 1 then --Seems to draw before updating so first time around hud.lives (line 4) would be nil
      love.graphics.setColor(0, 0, 0)
      love.graphics.print('Dead', 400, 400)
   end
end

function hud.create(health, x, y)
   local inst = {}
   inst.x = x
   inst.y = y
   inst.lives = health

   inst.draw = draw
   inst.update = update
   return inst
end

return hud
