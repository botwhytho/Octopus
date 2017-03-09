local hud = {}

local function draw(hb, player, levelDuration, paused)
   -- Print instantaneous FPS
   love.graphics.print({{0,0,0},love.timer.getFPS()}, 0, 0)
   -- Print state of dropped object
   love.graphics.print({{0,0,0},player.hasObject and "Move those Computers!" or "Go grab another server" }, love.graphics.getWidth()/2, 0)
   -- Print current score
   love.graphics.print({{0,0,0},"Score: " .. player.score}, love.graphics.getWidth()/2, love.graphics.getHeight()*.15)
   -- Print countdown timer
   love.graphics.print({{0,0,0},"Time Left: " .. levelDuration}, love.graphics.getWidth()/2, love.graphics.getHeight()*.20)

   -- Print player's lives
   local x, y = hb.x, hb.y
   love.graphics.setColor(219, 78, 78)
   for i=1, player.health do
      love.graphics.rectangle('fill', x, y, 15, 15)
      x = x + 20
   end

   if player.health < 1 then
      love.graphics.print({{0,0,0},'Dead'}, love.graphics.getWidth()/2, love.graphics.getHeight()/3)
   end

   if paused then
      -- Dark overlay
      love.graphics.setColor(1, 1, 1, 170)
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      -- Paused text
      love.graphics.setColor(1, 1, 1)
      love.graphics.setFont(love.graphics.newFont('assets/GreenFlame.ttf', 20))
      love.graphics.printf('Paused', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
      love.graphics.setFont(love.graphics.newFont('assets/Greenflame.ttf', 12))
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
