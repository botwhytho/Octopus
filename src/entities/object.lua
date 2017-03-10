local animation = require('src.movement.animation')

local object = {}

local function update(object, player)
   if player.hasObject == true and object.held == false then
      object.held = true
   end

   if player.hasObject then
      object.x = player.x + ((player.w-object.w)/2)
      object.y = player.y - object.h

      if object.x > love.graphics.getWidth() then
         object:reset()
      end
   end
end

local function draw(object)
   love.graphics.draw(object.sprite, object.x, object.y, 0, 0.45, 0.45)
end

local function reset(object, x, y)
   object.x = x or object.originX
   object.y = y or object.originY
   object.held = false
end

function object.create(filepath, x, y)
   local inst = {}

   inst.sprite = love.graphics.newImage(filepath)
   inst.w = inst.sprite:getWidth()*0.45
   inst.h = inst.sprite:getHeight()*0.45
   inst.x = x
   inst.y = y - inst.h

   inst.originX = inst.x
   inst.originY = inst.y
   inst.held = false

   inst.draw = draw
   inst.update = update
   inst.reset = reset

   return inst
end

return object
