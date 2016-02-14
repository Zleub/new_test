--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Draggable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:25:49
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 22:27:30
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Draggable = Drawable:expand()

Draggable.name = 'Draggable'

function Draggable:update(dt)
	local x, y = love.mouse.getPosition()

	if self.drag then
		self:moveBy(x - self.drag.x, y - self.drag.y)
		self.drag = nil
	end
	if self.x < x and x < self.x + self.width
		and self.y < y and y < self.y + self.height then

		if love.mouse.isDown(1) then
			self.drag = {x = x, y = y}
		end
	end

end

return Draggable
