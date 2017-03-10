 c = {}
   -- Mic Manipulation
   c.MIC_LATENCY = 0.01
   c.MIC_THRESHOLD = 30
   c.MIC_AMP_MULTIPLIER = -5

   -- Level data
   c.BACKGROUND_COLOUR = {184, 229, 240 }
   c.GROUND_COLOUR = {250, 236, 199}
   c.LVL_DURATION = 2
   c.GRAVITY = 1200
   c.GROUND_Y = love.graphics.getHeight()/1.2
   c.GOAL_X = love.graphics.getWidth()*.85 + 25

   -- Entity Data
   c.PLAYER_X = 30
   c.PLAYER_Y = c.GROUND_Y
   c.PLAYER_W = 100/2
   c.PLAYER_H = 84/2
   c.PLAYER_SPEED = 400
   c.PLAYER_HEALTH = 10
   c.OBJECT_X = 30
   c.CLOCK_SPAWN_P = 1000
   c.CLOCK_LIFETIME = 7

   -- Enemy Data
   c.FISH_XSPEED = 300
   c.FISH_YSPEED = 90
   c.HOOK_YSPEED = 20
   c.TURTLE_XSPEED = 10

   -- Fonts
   c.BODY_SIZE = 17
   c.HEADER_SIZE = 20

   -- HUD Data
   c.HEALTH_X = 20
   c.HEALTH_Y = 20
   c.SCORE_Y = 40
   c.LEVEL_X = -40
   c.TIMER_Y = 50
   c.YELLOW = {255, 199, 49, 170}
   c.BLUE = {88, 184, 207, 170}
   c.RED = {224, 26, 79, 170}

return c
