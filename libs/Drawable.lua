--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Drawable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:21:33
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-31 15:25:42
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Class = require 'libs.Class'

local Drawable = Class:expand()

Drawable.x = 0
Drawable.y = 0
Drawable.time = 1

function Drawable:update(dt)
	self.time = self.time + dt * 10
	self.index = math.floor(self.time)
end

function Drawable:draw(x, y, scale)
	love.graphics.draw(self.image, self.x + x, self.y + y, 0, self.scale * scale, self.scale * scale)
end

return Drawable
