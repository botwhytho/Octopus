local level = {}

local function draw(level)
   love.graphics.setColor(200, 200, 200)
	love.graphics.rectangle('fill', 0, (love.graphics.getHeight()/1.2), love.graphics.getWidth(), love.graphics.getHeight())
   love.graphics.setColor(255, 255, 255) --rgb values from 0-255. This makes the background white
end

level.draw = draw

return level
