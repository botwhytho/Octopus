local hud = {}

local function draw(hud, player, levelDuration, paused, lvl, highScore)
   love.graphics.setFont(hud.small)
   -- Print instantaneous FPS
   love.graphics.printf({{0,0,0},player.hasObject and "Move those Computers!" or "Go grab another server" }, 0, 0, love.graphics.getWidth(), "center")
   -- Print current score
   love.graphics.printf({{0,0,0},"Score: " .. player.score}, c.SCORE_Y, c.HEALTH_Y, love.graphics.getWidth(), "center")
   -- Print current level
   love.graphics.printf({{0,0,0},"Level: " .. lvl}, c.LEVEL_X, c.HEALTH_Y, love.graphics.getWidth(), "center")
   -- Print highScore
   love.graphics.printf({{0,0,0},"High Score: " .. highScore}, c.LEVEL_X, c.HEALTH_Y, love.graphics.getWidth(), "right")
   -- Print countdown timer
   love.graphics.setFont(hud.countdown)
   love.graphics.printf({{0,0,0}, levelDuration}, 0, c.TIMER_Y, love.graphics.getWidth(), "center")


   -- Print player's lives
   local x, y = hud.x, hud.y
   for i=1, player.health do
      love.graphics.draw(hud.livesSprite, x, y, 0, 0.2, 0.2)
      x = x + 22
   end

   if paused then
      -- Screen Overlay
      love.graphics.setColor(unpack(c.YELLOW))
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      -- Paused text
      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(hud.header)
      love.graphics.printf({{0, 0, 0},'Paused'}, 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')

   elseif levelDuration == 0 and (not player.dead) then
      -- Screen Overlay
      love.graphics.setColor(unpack(c.BLUE))
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      -- Paused text
      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(hud.header)
      love.graphics.printf('Well Done!', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
      love.graphics.setFont(hud.subHeader)
      love.graphics.printf('Press Enter to Proceed', 0, love.graphics.getHeight()*0.53, love.graphics.getWidth(), 'center')

   elseif levelDuration == 0 and player.dead then
      love.graphics.setColor(unpack(c.RED))
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(hud.header)
      love.graphics.printf('Game Over', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
      love.graphics.setFont(hud.subHeader)
      love.graphics.printf('Your score was too low', 0, love.graphics.getHeight()*0.51, love.graphics.getWidth(), 'center')
      love.graphics.printf('press space to restart', 0, love.graphics.getHeight()*0.54, love.graphics.getWidth(), 'center')

   elseif player.dead then
      love.graphics.setColor(unpack(c.RED))
      love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

      love.graphics.setColor(255, 255, 255)
      love.graphics.setFont(hud.header)
      love.graphics.printf('Game Over', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
      love.graphics.setFont(hud.subHeader)
      love.graphics.printf('Final Score: '..player.score, 0, love.graphics.getHeight()*0.51, love.graphics.getWidth(), 'center')
      love.graphics.printf('press space to restart', 0, love.graphics.getHeight()*0.54, love.graphics.getWidth(), 'center')
   end
end

function hud.create(health, x, y)
   local inst = {}
   inst.x = x
   inst.y = y
   inst.lives = health
   inst.livesSprite = love.graphics.newImage('assets/octo.png')

   inst.header = love.graphics.newFont('assets/font.otf', 70)
   inst.subHeader = love.graphics.newFont('assets/Roboto-Regular.ttf', 20)
   inst.small = love.graphics.newFont('assets/Roboto-Regular.ttf', c.BODY_SIZE)
   inst.default = love.graphics.newFont('assets/GreenFlame.ttf', c.BODY_SIZE)
   inst.countdown = love.graphics.newFont('assets/font2.ttf', 70)

   inst.draw = draw
   inst.update = update
   return inst
end

return hud
