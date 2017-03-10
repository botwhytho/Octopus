local hud = {}

local function draw(hud, player, levelDuration, paused, lvl)
   -- Print instantaneous FPS
   love.graphics.print({{0,0,0},love.timer.getFPS()}, 5, love.graphics.getHeight()-15)
   -- Print state of dropped object
   love.graphics.printf({{0,0,0},player.hasObject and "Move those Computers!" or "Go grab another server" }, 0, 0, love.graphics.getWidth(), "center")
   -- Print current score
   love.graphics.printf({{0,0,0},"Score: " .. player.score}, c.SCORE_Y, c.HEALTH_Y, love.graphics.getWidth(), "center")
   -- Print current level
   love.graphics.printf({{0,0,0},"Level: " .. lvl}, c.LEVEL_X, c.HEALTH_Y, love.graphics.getWidth(), "center")
   -- Print countdown timer
   love.graphics.printf({{0,0,0}, levelDuration}, 0, c.TIMER_Y, love.graphics.getWidth(), "center")

   -- Print player's lives
   local x, y = hud.x, hud.y
   for i=1, player.health do
      love.graphics.draw(hud.livesSprite, x, y, 0, 0.2, 0.2)
      x = x + 22
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
   inst.livesSprite = love.graphics.newImage('assets/octo.png')

   inst.draw = draw
   inst.update = update
   return inst
end

return hud
