local level = {}

local function draw(level)
  love.graphics.setColor(256, 256, 0,125)
  love.graphics.rectangle('fill', 0, 0, love.graphics.getWidth()/10*1.5, love.graphics.getHeight()*5/6)
  love.graphics.rectangle('fill', love.graphics.getWidth()/10*8.5, 0, love.graphics.getWidth()/10*1.5, love.graphics.getHeight()*5/6)
  love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle('fill', 0, (love.graphics.getHeight()/1.2), love.graphics.getWidth(), love.graphics.getHeight())
end

level.draw = draw

return level
