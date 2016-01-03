--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-03 14:28:55
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

		self.test =  UI.Scrollarea(0, 0, 400, 20000, {
			extensions = {Theme.Scrollarea},
			area_width = 400,
			area_height = love.graphics.getHeight(),
			show_scrollbars = true,
			dynamic_scroll_set = true
		})

		local i, j = 0, 0
		for index,v in ipairs(Dictionnary['hyptosis_tile-art-batch-1']) do
			self.test:addElement(UI.Frame(0 + i, 0 + j, 64, 64, {extensions = {Theme.Frame,
				{
					draw = function (self) love.graphics.setColor(255, 255, 255, 255)
						v:draw(self.x, self.y, 1.5)
					end
				}
			}}))
			i = i + 64
			if i + 64 > 400 then
				i = 0
				j = j + 64
			end
		end
		-- local i, j = 0, 0
		for index,v in ipairs(Dictionnary['hyptosis_til-art-batch-2']) do
			self.test:addElement(UI.Frame(0 + i, 0 + j, 64, 64, {extensions = {Theme.Frame,
				{
					draw = function (self) love.graphics.setColor(255, 255, 255, 255)
						v:draw(self.x, self.y, 1.5)
					end
				}
			}}))
			i = i + 64
			if i + 64 > 400 then
				i = 0
				j = j + 64
			end
		end
	end,
	update = function (self, dt)
		self.time = self.time + dt
		self.test:update(dt)
	end,
	draw = function (self)
		self.test:draw()
		-- love.graphics.setColor(Color:extract('white'))
		-- love.graphics.print(State.current)
		-- love.graphics.print(inspect(self), 0, 15)
	end
}

return State
