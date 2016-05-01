--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Draggable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:25:49
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 16:26:01
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Draggable
-- namespace:
-- description: The Draggable base
-- extendedDescription: The Draggable prototype expand the Drawable type with the mousepressed event. It should be placed into a EventDispatcher to get it triggered.
-- arguments:
-- returns:
-- tags: "Draggable", "EventDispatcher", "Drawable"
-- examples:

local Draggable = Drawable:expand()

Draggable.name = 'Draggable'

----
-- name: update
-- namespace: Draggable
-- description: The update event for an EventDispatcher
-- extendedDescription:
-- arguments: "dt"
-- returns:
-- tags: "Draggable"
-- examples:

function Draggable:update(dt)
	local x, y = love.mouse.getPosition()

	if self.drag then
		self:moveBy(x - self.drag.x, y - self.drag.y)
		self.drag = nil
	end
	if self.x < x and x < self.x + self.width * self.scale
		and self.y < y and y < self.y + self.height * self.scale then

		if love.mouse.isDown(1) then
			self.drag = {x = x, y = y}
		end
	end
end

----
-- name: draw
-- namespace: Draggable
-- description: The draw event for an EventDispatcher
-- extendedDescription:
-- arguments: "x", "y", "scale"
-- returns:
-- tags: "Draggable"
-- examples:


function Draggable:draw(x, y, scale)
	Drawable.draw(self, x, y, scale)
end

return Draggable
