 c = {}
   -- Mic Manipulation
   c.MIC_LATENCY = 0.01
   c.MIC_THRESHOLD = 30
   c.MIC_AMP_MULTIPLIER = -5

   -- Level data
   c.LVL_DURATION = 45
   c.GRAVITY = 900
   c.GROUND_Y = love.graphics.getHeight()/1.2
   c.GOAL_X = love.graphics.getWidth()*.85 + 25

   -- Entity Data
   c.PLAYER_X = 200
   c.PLAYER_Y = c.GROUND_Y
   c.PLAYER_W = 100/2
   c.PLAYER_H = 84/2
   c.PLAYER_SPEED = 500
   c.PLAYER_HEALTH = 5
   c.OBJECT_X = 30

   -- Enemy Data
   c.FISH_XSPEED = 300
   c.FISH_YSPEED = 90
   c.HOOK_YSPEED = 30

   -- Fonts
   c.BODY_SIZE = 12
   c.HEADER_SIZE = 20

return c
