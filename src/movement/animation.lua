local animation = {}

local function update(anim, dt)
   anim.currDur = anim.currDur + dt
   if anim.currDur > anim.duration then
      anim.currFrame = (anim.currFrame % anim.nFrames) + 1
      anim.currDur = 0
   end

   if anim.blinking then
      anim.blinkTimer = anim.blinkTimer + dt
      if anim.blinkTimer > anim.blinkMax then
         anim.blinkTimer = 0
         anim.blinkStep = 0.1
         anim.blinking = false
         anim.blinkOn = true
      elseif
         anim.blinkTimer >= anim.blinkStep then
         anim.blinkOn = not anim.blinkOn
         anim.blinkStep = anim.blinkStep + 0.1
      end
   end
end

-- Assumes horizontally organised spritesheet
function animation.create(filepath, frames, duration, width, height)
   local inst = {}

   inst.spritesheet = love.graphics.newImage(filepath)
   inst.quads = {}
   local x, y = 0, 0
   for i=1, frames do
      table.insert(inst.quads, love.graphics.newQuad(x, y, width, height, inst.spritesheet:getWidth(), inst.spritesheet:getHeight()))
      x = x + width
   end

   inst.nFrames = frames
   inst.currFrame = 1
   inst.currDur = 0
   inst.duration = duration

   inst.blinking = false
   inst.blinkOn = true
   inst.blinkTimer = 0
   inst.blinkStep = 0.1
   inst.blinkMax = 0.8

   inst.update = update

   return inst
end

return animation
