--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Drawable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:21:33
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 22:27:44
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
		d.width, d.height = img:getDimensions()
	end

	d.x, d.y = 0, 0
	d.scale = 1

	return d
end

Drawable.name =  'Drawable'

function Drawable:moveBy(x, y)
	self.x, self.y = self.x + x, self.y + y
end

function Drawable:moveAt(x, y)
	self.x, self.y = x, y
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
