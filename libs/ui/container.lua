--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:container
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 17:15:43
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 20:46:42
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Container = Class:expand()

function Container.type()
	return 'Container'
end

function Container:create_from_nothing()
	local c = Class.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = 0, 0
	c.queue = {}

	return c
end

function Container:create_from_Image(image)
	return Drawable.create(self, image)
end

function Container:create_from_dimensions(width, height)
	local c = Class.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = width, height
	c.queue = {}

	return c
end

function Container:create_from_description(desc, width, height)
	local d = Dictionnary[desc.image]

	local _w = width / d.screen.width
	local _h = height / d.screen.height
	local c = love.graphics.newCanvas(width, height)

	love.graphics.setCanvas(c)
	for i=1, _w - 1 do
		for j=1, _h - 1 do
			d[desc.body]:draw(i * d.screen.width, j * d.screen.height)
		end
	end
	for i=1, _w - 1 do
		d[desc.bu]:draw(i * d.screen.width, 0)
		d[desc.bd]:draw(i * d.screen.width, height - d.screen.height)
	end
	for i=1, _h - 1 do
		d[desc.bl]:draw(0, i * d.screen.height)
		d[desc.br]:draw(width - d.screen.width, i * d.screen.height)

	end
	d[desc.ul]:draw()
	d[desc.ur]:draw(width - d.screen.width)
	d[desc.dl]:draw(0, height - d.screen.height)
	d[desc.dr]:draw(width - d.screen.width, height - d.screen.height)
	love.graphics.setCanvas()

	local c = Drawable.create(self, love.graphics.newImage(c:newImageData()))
	c.width, c.height = width, height
	c.queue = {}

	return c
end

function Container:push(item)
	-- table.insert(self.queue, item)
	if item.x < self.x then item.x = self.x end
	if item.y < self.y then item.y = self.y end

	local last_elem = self.queue[#self.queue]
	if last_elem then
		if last_elem.x + last_elem.width + item.width < self.x + self.width then
			item.x = last_elem.x + last_elem.width
			if last_elem.y > item.y then
				item.y = last_elem.y
			end
		else
			item.y = last_elem.y + last_elem.height
		end
	end
	table.insert(self.queue, item)
end

function Container:update(dt)
	for i,v in ipairs(self.queue) do
		if v.update then v:update(dt) end
		if v.type() == 'Draggable' then
			if v.x < self.x then v.x = self.x end
			if v.y < self.y then v.y = self.y end
			if v.x + v.width > self.x + self.width then v.x = self.x + self.width - v.width end
			if v.y + v.height > self.y + self.height then v.y = self.y + self.height - v.height end
		end
	end
end

function Container:draw(x, y, scale)
	if self.image then
		Drawable.draw(self, x, y, scale)
	end

	for i,v in ipairs(self.queue) do
		if v.draw then v:draw(x, y, scale) end
	end
end

-- function definitions_solver(def_table, ...)
-- 	local s = ''

-- 	for i,v in ipairs({...}) do
-- 		s = s..(v:type() or type(v))
-- 		if ({...})[i + 1] then s = s..', ' end
-- 	end

-- 	if def_table[s] then def_table[s]()
-- 	else def_table['_']() end

-- 	print(s)
-- end

function Container:create(...)
	definitions_solver({ _ = print }, ...)
	local args = ({...})

	if args[1] == nil then
		return self:create_from_nothing()
	elseif type(args[1]) == 'table' and type(args[2]) == 'number' and type(args[3]) == 'number' then
		return self:create_from_description(args[1], args[2], args[3])
	elseif type(args[1]) == 'number' and type(args[2]) == 'number' then
		return self:create_from_dimensions(args[1], args[2], args[3])
	elseif args[1]:type() == 'Image' then
		return self:create_from_Image(args[1])
	end
end


return Container
