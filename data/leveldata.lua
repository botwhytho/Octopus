local enemy = require('src.entities.enemy')
local xyMove = require('src.movement.xyMovement')

local levelData = {
   -- Level 1
   {minScore = 0,
   duration = 2,
   enemies = {
      enemy.create('assets/fish.png', love.graphics.getWidth(), 200, xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED)),
      enemy.create('assets/fish2.png', -50, 300, xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED)),
      enemy.create('assets/scorpion.png', 400, c.GROUND_Y),
      enemy.create('assets/hook.png', 200, 150, xyMove.create(0, c.HOOK_YSPEED)),
      enemy.create('assets/hook.png', 620, 250, xyMove.create(0, c.HOOK_YSPEED, nil, -1)),
   }
   },

   -- Level 2
   {minScore = 0,
   duration = 2,
   enemies = {
      enemy.create('assets/fish.png', love.graphics.getWidth(), 70, xyMove.create(c.FISH_XSPEED, c.FISH_YSPEED))
   }
   },

   -- Level 3
   {minScore = 0,
   duration = 2,
   enemies = {
      enemy.create('assets/turtle.png', love.graphics.getWidth(), c.GROUND_Y, xyMove.create(10, 0))
   }
   },

   -- Level 4
   {minScore = 500, -- make it impossible to go any further :)
   duration = 45,
   enemies = {
      enemy.create('assets/hook.png', 300, 300, xyMove.create(0, c.HOOK_YSPEED, nil, -1)),
   }
   }
}

return levelData
