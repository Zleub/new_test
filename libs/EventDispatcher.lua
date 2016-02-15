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

function Event:dispatch(...)
	for i,v in ipairs(self) do
		if type(v[self.name]) ~= 'function' then
			print('EventDispatcher '..Color.shell(self.name, 'orange')..'is no function')
		else
			v[self.name](v, ...)
		end
	end
end

function EventDispatcher:add(elem)
	for k,v in pairs(elem) do
		if self[k] and type(self[k]) == 'table' then
			table.insert(self[k], elem)
		end
	end
end

function EventDispatcher:create()
	local e = Class.create(self)

	for i,v in ipairs(events) do
		e[v] = Class.create(Event)
		e[v].name = v
	end

	return e
end

return EventDispatcher
