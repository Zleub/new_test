--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Drawable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:21:33
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 01:41:44
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Drawable = Class:expand()

function Drawable:create(img)
	if img and img:type() ~= 'Image' then
		print('I got some error')
	end

	local d = Class.create(self)
	if img then
		d.image = img
		d.image:setFilter('nearest')
	end

	d.x = 0
	d.y = 0
	d.scale = 1

	return d
end

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
