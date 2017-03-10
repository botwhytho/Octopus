local hud = {}

local function draw(hb, player, levelDuration, paused, lvl)
   -- Print instantaneous FPS
   love.graphics.print({{0,0,0},love.timer.getFPS()}, 0, 0)
   -- Print state of dropped object
   love.graphics.printf({{0,0,0},player.hasObject and "Move those Computers!" or "Go grab another server" }, 0, 0, love.graphics.getWidth(), "center")
   -- Print current score
   love.graphics.printf({{0,0,0},"Score: " .. player.score}, 0, c.SCORE_Y, love.graphics.getWidth(), "center")
   -- Print current level
   love.graphics.print({{0,0,0},"Level: " .. lvl}, love.graphics.getWidth()*0.65, 0)
   -- Print countdown timer
   love.graphics.printf({{0,0,0},"Time Left: " .. levelDuration}, 0, 0, love.graphics.getWidth(), "right")

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

   if paused and levelDuration > 0 then
      -- Dark overlay
      love.graphics.setColor(0, 0, 0, 170)
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      -- Paused text
      love.graphics.setColor(0, 0, 0)
      love.graphics.setFont(love.graphics.newFont('assets/GreenFlame.ttf', c.HEADER_SIZE))
      love.graphics.printf('Paused', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
      love.graphics.setFont(love.graphics.newFont('assets/GreenFlame.ttf', c.BODY_SIZE))
   elseif levelDuration == 0 then
     -- Dark overlay
     love.graphics.setColor(0, 0, 0, 170)
     love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

     -- Paused text
     love.graphics.setColor(0, 0, 0)
     love.graphics.setFont(love.graphics.newFont('assets/GreenFlame.ttf', c.HEADER_SIZE))
     love.graphics.printf('Your current score is:' .. player.score, 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
     love.graphics.printf('Press Enter to continue', 0, love.graphics.getHeight()*0.45, love.graphics.getWidth(), 'center')
     love.graphics.setFont(love.graphics.newFont('assets/GreenFlame.ttf', c.BODY_SIZE))
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
