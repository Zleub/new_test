--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-02 01:54:53
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Loader = require 'libs.Loader'
local UI = require 'libs.UI'

local State = {}
State.once_t = {}
setmetatable(State, {
	__call = function (self, state)
		if self.current and self[self.current].after then
			self[self.current]:after() end
		self.current = state

		if not self.once_t[self.current] and self[self.current].once then
			self.once_t[self.current] = true
			self[self.current]:once()
		end

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

function State:wheelmoved(x, y)
	if State[self.current].wheelmoved then
		State[self.current]:wheelmoved(x, y)
	end
end

State.Loading = {
	once = function (self)
		self.nbr = Loader:getSize()
	end,
	update = function (self, dt)
		local elem = Loader:load()

		if elem then self.text = elem
		else State('Test') end
	end,
	draw = function (self)
		local p = (love.graphics.getWidth() - love.graphics.getWidth() / 2) / self.nbr
		local w = (love.graphics.getWidth() - love.graphics.getWidth() / 2)
		local h = love.graphics.getHeight() / 20

		love.graphics.print(self.text, love.graphics.getWidth() / 2 - (#self.text), love.graphics.getHeight() / 2 - h)
		love.graphics.rectangle('fill', (love.graphics.getWidth() / 2 - w / 2), love.graphics.getHeight() / 2 - h / 2, p * (self.nbr - Loader:getSize()), h)
		love.graphics.rectangle('line', love.graphics.getWidth() / 2 - w / 2, love.graphics.getHeight() / 2 - h / 2, w, h)

	end
}

State.Test = {
	once = function (self)
		self.text = 'toto'
		self.time = 0
		Dictionnary['pict'][1].scale = 1
	end,
	update = function (self, dt)
		self.time = self.time + dt
	end,
	draw = function (self)
		love.graphics.print(self.time, 0, love.graphics.getHeight() - 15)
		Dictionnary['hyptosis_tile-art-batch-1'][1]:draw(0, 0, 2)
		Dictionnary['Untitled_master'][1]:draw(100, 100, 12)
	end,
	wheelmoved = function (self, x, y)
	end
}

State.Other = {
	once = function (self)
		self.time = 0
		self.button = UI.Button(600, 0, 200, 100, {
			extensions = {Theme.Button},
		})
	end,
	update = function (self, dt)
		self.time = self.time + dt
		self.button:update(dt)
		if self.button.pressed == true then
			State('Test')
		end
	end,
	draw = function (self)
		self.button:draw()
		love.graphics.print(self.time)
	end
}

return State
