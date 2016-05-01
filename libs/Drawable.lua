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

----
-- name: Drawable
-- namespace:
-- description: The standard Drawable type.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Drawable", "EventDispatcher"
-- examples:

local Drawable = Class:expand()

----
-- name: create
-- namespace: Drawable
-- description: The standard way to construct a Drawable from an Love2d Image.
-- extendedDescription:
-- arguments: "Image"
-- returns:
-- tags: "Drawable"
-- examples: "Drawable:create(image)"

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

----
-- name: moveBy
-- namespace: Drawable
-- description: This method allow to move a Drawable.
-- extendedDescription:
-- arguments: "x", "y"
-- returns:
-- tags: "Drawable"
-- examples: "d:moveBy(10, 10)"

function Drawable:moveBy(x, y)
	self.x, self.y = self.x + x, self.y + y
end

----
-- name: moveAt
-- namespace: Drawable
-- description: This method allow to position a Drawable
-- extendedDescription:
-- arguments: "x", "y"
-- returns:
-- tags: "Drawable"
-- examples: "d:moveAt(10, 10)"

function Drawable:moveAt(x, y)
	self.x, self.y = x, y
end

----
-- name: getSize
-- namespace: Drawable
-- description: This method returns the actual (scaled) size of a Drawable.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Drawable"
-- examples: "d:getSize()"

function Drawable:getSize()
	return self.image:getWidth() * self.scale, self.image:getHeight() * self.scale
end

----
-- name: draw
-- namespace: Drawable
-- description: The draw event for an EventDispatcher
-- extendedDescription:
-- arguments: "padding_x", "padding_y", "scale"
-- returns:
-- tags: "Drawable"
-- examples: "d:draw()"

function Drawable:draw(x, y, scale)
	x = x or 0
	y = y or 0
	scale = scale or 1

	love.graphics.draw(self.image, self.x + x, self.y + y, 0, self.scale * scale, self.scale * scale)
end

return Drawable
