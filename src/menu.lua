local mainGame = require('src.game')

menu = {}

function menu.init(menu, device, changeState)
   menu.mic = device
   menu.change = changeState

   local font = love.graphics.newFont('assets/LadyRadical.ttf', 50)
   love.graphics.setFont(font)
end

function menu.update(state)
   if love.keyboard.isDown('escape') then
      love.event.quit()
   end

   if ((state.mic:poll() or 0) >= 100) then
      menu:change(mainGame)
   end
end

function menu.draw(state)
   love.graphics.setColor(100, 130, 255)
   love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth(), love.graphics.getHeight())

   love.graphics.setColor(255, 255, 255)
   love.graphics.printf('Scream to Start', 0, love.graphics.getHeight()*0.4, love.graphics.getWidth(), 'center')
end



return menu
