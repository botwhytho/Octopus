 c = {}
   c.MIC_LATENCY = 0.01
   c.MIC_THRESHOLD = 10 --30
   c.MIC_AMP_MULTIPLIER = -10 -- -5
   c.LVL_DURATION = 45
   c.GRAVITY = 900

   -- Entity Locations
   c.GROUND_Y = love.graphics.getHeight()/1.2
   c.GOAL_X = love.graphics.getWidth()*.85 + 25
   c.PLAYER_X = 200
   c.PLAYER_Y = c.GROUND_Y
   c.PLAYER_W = 100/2
   c.PLAYER_H = 84/2
   c.PLAYER_SPEED = 500
   c.PLAYER_HEALTH = 5


   c.OBJECT_X = 30

   -- Fonts
   c.BODY_PATH = nil
   c.MENU_PATH = nil
   c.BODY_SIZE = 12
   c.HEADER_SIZE = 20


return c
