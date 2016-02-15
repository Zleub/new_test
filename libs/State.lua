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

local State = {}
State.once_t = {}
setmetatable(State, {
	__call = function (self, state)

		if self.current and self[self.current].after then
			self[self.current]:after()
		end

		self.previous = self.current or self.previous

		print(self.previous..' -> '..state)
		self.current = state

		if not self.once_t[self.current] and self[self.current].once then
			self.once_t[self.current] = true
			self[self.current]:once()
		end

		if self[self.current].before then
			self[self.current]:before()
		end
	end
})

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

function State:keypressed(x, y)
	if State[self.current].keypressed then
		State[self.current]:keypressed(x, y)
	end
end

function State:mousepressed(x, y, button)
	if State[self.current].mousepressed then
		State[self.current]:mousepressed(x, y, button)
	end
end

State.Loading = require('libs.state.loading')

State.Test = require('libs.state.test')

State.Other = require('libs.state.other')

State.Map = require('libs.state.map')



return State
