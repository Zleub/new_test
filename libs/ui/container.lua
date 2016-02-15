--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:container
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 17:15:43
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-15 00:15:46
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Container = Drawable:expand()

Container.name = 'Container'

function Container:create_from_nothing()
	local c = Drawable.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = 0, 0
	c.queue = {}

	return c
end

function Container:create_from_Image(image)
	return Drawable.create(self, image)
end

function Container:create_from_dimensions(width, height)
	local c = Drawable.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = width, height
	c.queue = Collection:create('Drawable')

	return c
end

function Container:create_from_description(desc, width, height)
	local c = Compound.create(self, desc, width, height)
	c.queue = Collection:create('Drawable')

	return c
end

function Container:push(item)
	if item.x < self.x then item.x = self.x end
	if item.y < self.y then item.y = self.y end

	local last_elem = self.queue[#self.queue]
	if last_elem then
		if last_elem.y + last_elem.height + item.height < self.y + self.height then
			item.y = last_elem.y + last_elem.height - self.padd / 2
			if last_elem.x > item.x then
				item.x = last_elem.x - self.padd / 2
			end
		else
			item.x = last_elem.x + last_elem.width
		end
	end

	local padd = self.height - item.height
	if not self.padd then self.padd = padd
	elseif padd < self.padd then self.padd = padd end

	item.x = item.x + self.padd / 2
	item.y = item.y + self.padd / 2

	self.queue:add(item)
	return item
end

function Container:update(dt)
	self.queue:iter( function (i, v)
		if v.update then v:update(dt) end
		if v:type() == 'Draggable' then
			if v.x < self.x then v.x = self.x end
			if v.y < self.y then v.y = self.y end
			if v.x + v.width > self.x + self.width then v.x = self.x + self.width - v.width end
			if v.y + v.height > self.y + self.height then v.y = self.y + self.height - v.height end
		end
	end )
end

function Container:draw(x, y, scale)
	if self.image then
		Drawable.draw(self, x, y, scale)
	end

	self.queue:iter( function (i, v)
		if v.draw then v:draw(x, y, scale) end
	end )
end

function Container:create(...)
	return definitions_solver(self, {
		['_'] = function (...) print('Container.anything', {...}) end,
		['nil'] = Container.create_from_nothing,
		['table, number, number'] = Container.create_from_description,
		['number, number'] = Container.create_from_dimensions,
		['Image'] = Container.create_from_Image
	}, ...)
end


return Container
