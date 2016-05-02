--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:container
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 17:15:43
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 00:28:19
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Container
-- namespace:
-- description: The UI Container module.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Container", "Drawable"
-- examples:

local Container = Drawable:expand()

Container.name = 'Container'

----
-- name: create_from_nothing
-- namespace: Container
-- description: Create a Container from nothing.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Container"
-- examples:

function Container:create_from_nothing()
	local c = Drawable.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = 0, 0
	c.queue = {}

	return c
end

----
-- name: create_from_Image
-- namespace: Container
-- description: Create a Container from an Image
-- extendedDescription:
-- arguments: "Image"
-- returns:
-- tags: "Container"
-- examples:

function Container:create_from_Image(image)
	return Drawable.create(self, image)
end

----
-- name: create_from_dimensions
-- namespace: Container
-- description: Create a Container from a sizing.
-- extendedDescription:
-- arguments: "width", "height"
-- returns:
-- tags: "Container"
-- examples:

function Container:create_from_dimensions(width, height)
	local c = Drawable.create(self)

	c.x, c.y = 0, 0
	c.width, c.height = width, height
	c.queue = EventDispatcher:create()

	return c
end

----
-- name: create_from_description
-- namespace: Container
-- description: Create a Container from a Description
-- extendedDescription:
-- arguments: "description", "width", "height"
-- returns:
-- tags: "Container", "Description"
-- examples:

function Container:create_from_description(desc, width, height)
	local c = Compound.create(self, desc, width, height)
	c.queue = EventDispatcher:create()

	return c
end

----
-- name: push
-- namespace: Container
-- description: Adds an item to a Container and calculate his position relative to the inner queue.
-- extendedDescription:
-- arguments: "item"
-- returns:
-- tags: "Container"
-- examples:

function Container:push(item)
	if item.x < self.x then item.x = self.x end
	if item.y < self.y then item.y = self.y end

	local last_elem = self.last_elem
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
	self.last_elem = item
	return item
end

----
-- name: update
-- namespace: Container
-- description: The update event for EventDispatcher
-- extendedDescription:
-- arguments: "dt"
-- returns:
-- tags: "Container", "EventDispatcher"
-- examples:

function Container:update(dt)
	self.queue.update:dispatch(dt)
end

----
-- name: mousepressed
-- namespace: Container
-- description: The mousepressed event for EventDispatcher
-- extendedDescription:
-- arguments: "x", "y", "button"
-- returns:
-- tags: "Container", "EventDispatcher"
-- examples:

function Container:mousepressed(x, y, button)
	self.queue.mousepressed:dispatch(x, y, button)
end

----
-- name: draw
-- namespace: Container
-- description: The draw event for EventDispatcher
-- extendedDescription:
-- arguments: "x", "y", "scale"
-- returns:
-- tags: "Container", "EventDispatcher"
-- examples:

function Container:draw(x, y, scale)
	if self.image then
		Drawable.draw(self, x, y, scale)
	end

	self.queue.draw:dispatch(x, y, scale)
end

----
-- name: create
-- namespace: Container
-- description: Standard Selector Constructor
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Container"
-- examples: "Container:create()", "Container:create({}, 100, 100)", "Container:create(100, 100)", "Container:create(image)"

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
