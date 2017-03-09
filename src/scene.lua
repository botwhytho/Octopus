local c = require('src.constants')
local level = {}

level.groundY = c.GROUND_Y
level.goalX = c.GOAL_X

local function draw(level)
  -- Draw ground
  love.graphics.setColor(200, 200, 200)
  love.graphics.rectangle('fill', 0, level.groundY, love.graphics.getWidth(), love.graphics.getHeight())
  love.graphics.setColor(255, 255, 255) -- this is needed so the colours don't get muddled, there's prob. a better way
end

level.draw = draw

return level
