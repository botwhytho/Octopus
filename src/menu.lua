local mainGame = require('src.game')

menu = {}

function menu.init(menu, device, changeState)
   menu.mic = device
   menu.change = changeState
   menu.one_player_selected = true
   menu.octo = love.graphics.newImage('assets/octopus_intro.png')

   local font = love.graphics.newFont('assets/LadyRadical.ttf', 50)
   love.graphics.setFont(font)
end

function menu.update(state)
   love.keyboard.setKeyRepeat(false) --This doesnt fully fix the issue of key repeats

   if love.keyboard.isDown('escape') then
      love.event.quit()
   end

   if love.keyboard.isDown('down') or love.keyboard.isDown('s')
      or love.keyboard.isDown('up') or love.keyboard.isDown('w') then
      menu.one_player_selected = not menu.one_player_selected
   end

   if love.keyboard.isDown('return') or love.keyboard.isDown('space') then
      menu:change(menu.one_player_selected and mainGame or mainGame)
   end
end

function menu.draw(state)
   love.graphics.setColor(100, 130, 255)
   love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

   love.graphics.draw(menu.octo,love.graphics.getWidth()/2-menu.octo:getWidth()/4,love.graphics.getHeight()/2-menu.octo:getHeight()/4,0,0.5,0.5)

   local amplitude_to_alpha = math.floor((menu.mic:poll() or 1)/100*255-0.5)+75 --Turning amplitude to alpha
   love.graphics.setColor(255, 255,255, amplitude_to_alpha)
   love.graphics.printf('Octo-Octo', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')

   local mode_selected = menu.one_player_selected and {219, 78, 78} or {255, 255, 255}
   love.graphics.setColor(mode_selected)
   love.graphics.printf('1 Player', 0, love.graphics.getHeight()*0.55, love.graphics.getWidth(), 'center')
   local mode_selected = not menu.one_player_selected and {219, 78, 78} or {255, 255, 255}
   love.graphics.setColor(mode_selected)
   love.graphics.printf('Two Team Battle!', 0, love.graphics.getHeight()*0.65, love.graphics.getWidth(), 'center')
end



return menu
