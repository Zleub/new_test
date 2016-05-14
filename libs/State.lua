--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-15 23:57:09
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: State
-- namespace:
-- description: The state module.
-- extendedDescription: It handle state's change with the metamethod __call.
-- arguments:
-- returns:
-- tags: "v0.0", "State", "Static"
-- examples: "State('Loading')"

local State = {}
State.once_t = {}

----
-- name: StateEvent
-- namespace: State
-- description: The events supported by the State module.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "State"
-- examples: "once", "before", "after"

setmetatable(State, {
	__call = function (self, state)

		if self.current and self[self.current].after then
			self[self.current]:after()
		end

		self.previous = self.current or self.previous

		-- print(self.previous..' -> '..state)
		self.current = state
		debug(self.current)
		if not self.once_t[self.current] and self[self.current].once then
			self.once_t[self.current] = true
			self[self.current]:once()
		end

		if self[self.current].before then
			self[self.current]:before()
		end
	end
})

----
-- name: StateCallback
-- namespace: State
-- description: The callbacks supported by the State module
-- extendedDescription: -- Callback dispatch should be handle by an EventDispatcher or such
-- arguments:
-- returns:
-- tags: "v0.0", "State", "needCare"
-- examples: "update", "draw", "wheelmoved", "keypressed", "mousepressed"

function State:update(dt)
	State[self.current]:update(dt)
end

function State:draw()
	State[self.current]:draw()
end

function State:wheelmoved(x, y)
	if State[self.current].wheelmoved then
		State[self.current]:wheelmoved(x, y)
	end
end

function State:keypressed(key)
	if key == 'space' then
		State(State.next())
	elseif State[self.current].keypressed then
		State[self.current]:keypressed(key)
	end
end

function State:mousepressed(x, y, button)
	if State[self.current].mousepressed then
		State[self.current]:mousepressed(x, y, button)
	end
end

----
-- name: StateList
-- namespace: State
-- description: The list of the differents states availables.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "State", "Loading", "Test", "Other", "Map", "Menu"
-- examples:
State.index = 1
State.list = { "Loading", "Test" } --, "Other", "Map", "Menu" }
function State.next()
	if State.index + 1 > #State.list then State.index = 0 end
	State.index = State.index + 1
	return State.list[State.index]
end

State.Loading = require('libs.state.loading')
State.Test = require('libs.state.test')
-- State.Other = require('libs.state.other')
-- State.Map = require('libs.state.map')
-- State.Menu = require('libs.state.menu')

return State
