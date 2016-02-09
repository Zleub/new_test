--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Drawable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:21:33
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-09 20:10:38
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Drawable = Class:expand()

Drawable.x = 0
Drawable.y = 0
Drawable.time = 1
Drawable.scale = 1

function Drawable:getSize()
	return self.image:getWidth() * self.scale, self.image:getHeight() * self.scale
end

function Drawable:draw(x, y, scale)
	x = x or 0
	y = y or 0
	scale = scale or 1

	love.graphics.draw(self.image, self.x + x, self.y + y, 0, self.scale * scale, self.scale * scale)
end

return Drawable
