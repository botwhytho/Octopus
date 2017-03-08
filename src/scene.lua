local level = {}

level.groundY = love.graphics.getHeight()/1.2

local function draw(level)
   -- Draw yellow side bars
  love.graphics.setColor(256, 256, 0,125)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth()/10*1.5, love.graphics.getHeight()*5/6)
  love.graphics.rectangle('fill', love.graphics.getWidth()/10*8.5, 0, love.graphics.getWidth()/10*1.5, love.graphics.getHeight()*5/6)

  -- Draw ground
  love.graphics.setColor(200, 200, 200)
  love.graphics.rectangle('fill', 0, level.groundY, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(255, 255, 255) -- this is needed so the colours don't get muddled, there's prob. a better way
end

level.draw = draw

return level
