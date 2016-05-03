--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:EventDispatcher
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-15 22:52:59
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 00:53:31
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: EventDispatcher
-- namespace:
-- description: The standard EventDispatcher type.
-- extendedDescription: It allow you to pack a set of object which need callback propagation for a minimal iteration.
-- arguments:
-- returns:
-- tags: "v0.0", "EventDispatcher"
-- examples: "ED = EventDispatcher:create()", "ED:add( drawable )"

local EventDispatcher = Class:expand()
local Event = Class:expand()
local events = {
	'load',
	'update',
	'draw',

	'keypressed',
	'mousepressed',
	'wheelmoved'
}

----
-- name: EventList
-- namespace: EventDispatcher
-- description: The event list handled by an EventDispatcher's instance.
-- extendedDescription:
-- arguments: "..."
-- returns:
-- tags: "v0.0", "EventDispatcher"
-- examples: "load", "update", "draw", "keypressed", "mousepressed", "wheelmoved"

function Event:dispatch(...)
	for i,v in ipairs(self) do
		if type(v[self.name]) ~= 'function' then
			print('EventDispatcher '..Color.shell(self.name, 'orange')..'is no function')
		else
			v[self.name](v, ...)
		end
	end
end

----
-- name: add
-- namespace: EventDispatcher
-- description: The standard way to add an object to an EventDispatcher.
-- extendedDescription:
-- arguments: "objet"
-- returns:
-- tags: "v0.0", "EventDispatcher"
-- examples: "ED:add( drawable )"

function EventDispatcher:add(elem)
	for k,v in pairs(elem) do
		if self[k] and type(self[k]) == 'table' then
			table.insert(self[k], elem)
		end
	end
end

----
-- name: create
-- namespace: EventDispatcher
-- description: The standard way to create a new instance of the EventDispatcher type.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "EventDispatcher"
-- examples: "ED = EventDispatcher:create()"

function EventDispatcher:create()
	local e = Class.create(self)

	for i,v in ipairs(events) do
		e[v] = Class.create(Event)
		e[v].name = v
	end

	return e
end

return EventDispatcher
