--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-02 19:23:39
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

function State:keypressed(x, y)
	if State[self.current].keypressed then
		State[self.current]:keypressed(x, y)
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
		self.cmp = 1
		self.test = 1
		Dictionnary['pict'][1].scale = 1


		self.shader1 = love.graphics.newShader('shaders/test_shader.glsl')
		self.shader1:send("width", 16 * 12)
		self.shader1:send("height", 18 * 12)

		self.shader2 = love.graphics.newShader('shaders/test_shader2.glsl')
		self.shader2:send("width", 16 * 12)
		self.shader2:send("height", 18 * 12)

	end,
	update = function (self, dt)
		self.time = self.time + dt / 2.5
		self.test = math.cos(self.time) * 2

		self.shader1 = love.graphics.newShader('shaders/test_shader.glsl')
		self.shader1:send("width", 16 * 12)
		self.shader1:send("height", 18 * 12)

		self.shader2 = love.graphics.newShader('shaders/test_shader2.glsl')
		self.shader2:send("width", 16 * 12)
		self.shader2:send("height", 18 * 12)

		self.shader1:send("resolution", self.cmp)
		self.shader2:send("resolution", self.cmp)
		self.shader2:send("test", self.test)
	end,
	draw = function (self)

		love.graphics.setColor(Color:extract('blue'))
		love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
		love.graphics.setColor(Color:extract('white'))


		love.graphics.print('self.time: '..self.time, 0, love.graphics.getHeight() - 15)
		love.graphics.print('self.cmp: '..self.cmp, 0, love.graphics.getHeight() - 30)
		love.graphics.print('self.test: '..self.test, 0, love.graphics.getHeight() - 54)
		-- Dictionnary['hyptosis_tile-art-batch-1'][1]:draw(0, 0, 2)

		self.shader1:send("x", 100)
		self.shader1:send("y", 0)
		love.graphics.setShader(self.shader1)
		love.graphics.rectangle('fill', 100, 0, 16 * 12, 18 * 12)
		love.graphics.setShader()

		self.shader1:send("x", 100)
		self.shader1:send("y", 150)
		love.graphics.setShader(self.shader1)
		Dictionnary['Untitled_master'][1]:draw(100, 150, 12)
		love.graphics.setShader()

		self.shader2:send("x", 300)
		self.shader2:send("y", 0)
		love.graphics.setShader(self.shader2)
		love.graphics.rectangle('fill', 300, 0, 16 * 12, 18 * 12)
		love.graphics.setShader()

		self.shader2:send("x", 300)
		self.shader2:send("y", 150)
		love.graphics.setShader(self.shader2)
		Dictionnary['Untitled_master'][2]:draw(300, 150, 12)
		love.graphics.setShader()

		self.shader2:send("x", 500)
		self.shader2:send("y", 0)
		self.shader2:send("width", 500)
		self.shader2:send("height", 500)
		love.graphics.setShader(self.shader2)
		love.graphics.rectangle('fill', 500, 0, 500, 500)
		love.graphics.setShader()




		Dictionnary['Untitled_master'][1]:draw(100, 300, 12)
		Dictionnary['Untitled_master'][2]:draw(300, 300, 12)
	end,
	wheelmoved = function (self, x, y)
		self.cmp  = self.cmp + y
	end,
	keypressed = function (self, key)
		if key == 'kp+' then
			self.test = self.test + 1
		elseif key == 'kp-' then
			self.test = self.test - 1
		end
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
