--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-03 14:07:51
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Loader = require 'libs.Loader'

local State = {}
setmetatable(State, {
	__call = function (self, state)
		if self.current and self[self.current].after then
			self[self.current]:after() end
		self.current = state
		if self[self.current].before then
			self[self.current]:before() end
	end
})

function State:update(dt)
	State[self.current]:update(dt)
end

function State:draw()
	State[self.current]:draw()
end

State.Loading = {
	update = function (self, dt)
		local elem = Loader:load()

		if elem then self.text = elem
		else State('Test') end
	end,
	draw = function (self)
		love.graphics.print(State.current)
		love.graphics.print(self.text, 0, 15)
	end
}

State.Test = {
	before = function (self)
		self.text = 'toto'
		self.time = 0
		self.test =  UI.Scrollarea(200, 200, 2000, 2000, {
			extensions = {Theme.Scrollarea},
			area_width = 400,
			area_height = 400,
			-- show_scrollbars = true,
			dynamic_scroll_set = true
		})
		self.test:addElement(UI.Button(0, 0, 50, 50, {extensions = {Theme.Button}}))
		self.test:addElement(UI.Button(600, 0, 50, 50, {extensions = {Theme.Button}}))
		self.test:addElement(UI.Button(1200, 0, 50, 50, {extensions = {Theme.Button}}))
		self.test:addElement(UI.Button(1800, 0, 50, 50, {extensions = {Theme.Button}}))
	end,
	update = function (self, dt)
		self.time = self.time + dt
		self.test:update(dt)
	end,
	draw = function (self)
		self.test:draw()
		love.graphics.setColor(Color:extract('white'))
		love.graphics.print(State.current)
		-- love.graphics.print(inspect(self), 0, 15)
	end
}

return State
