local object = {}

local function update(object, player)
   if player.hasObject == true and object.held == false then
      object.held = true
   elseif player.hasObject == false and object.held == true then
      object.held = false
      object.dropped = true
   end

   if object.held then
      object.x = player.x
      object.y = player.y - object.h
   end
end

local function draw(object)
   love.graphics.setColor(120, 80, 12)
   love.graphics.rectangle('fill', object.x, object.y, object.w, object.h)
   love.graphics.setColor(255, 255, 255)
end

local function reset(object, x, y)
   object.x = x
   object.y = y
   object.held = false
   object.dropped = false
end

function object.create(x, y, w, h)
   local inst = {}

   inst.x = x
   inst.y = y
   inst.w = w
   inst.h = h
   inst.held = false
   inst.dropped = false

   inst.draw = draw
   inst.update = update
   inst.reset = reset

   return inst
end

return object
