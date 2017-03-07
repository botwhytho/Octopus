local hud = {}

local function update(hud, player)
   hud.lives = player.health

   if hud.lives < 1 then
      love.graphics.setColor(1, 1, 1)
      love.graphics.print('Dead', 400, 400) -- not working!
   end
end

local function draw(hb)
   local x, y = hb.x, hb.y
   love.graphics.setColor(219, 78, 78)
   for i=1, hb.lives do
      love.graphics.rectangle('fill', x, y, 15, 15)
      x = x + 20
   end
end

function hud.create(player, x, y)
   local inst = {}
   inst.x = x
   inst.y = y
   inst.lives = player.health

   inst.draw = draw
   inst.update = update
   return inst
end

return hud
