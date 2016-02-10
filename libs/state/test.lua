--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:test
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:18:37
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-10 20:03:04
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {
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
		self.test = math.cos(self.time) * 4

		self.shader1 = love.graphics.newShader('shaders/test_shader.glsl')
		self.shader1:send("width", 16 * 12)
		self.shader1:send("height", 18 * 12)

		self.shader2 = love.graphics.newShader('shaders/test_shader2.glsl')
		self.shader2:send("width", 16 * 6)
		self.shader2:send("height", 18 * 6)

		self.shader1:send("resolution", self.cmp)
		self.shader2:send("resolution", self.cmp)
		self.shader2:send("test", self.test)
	end,
	draw = function (self)

		love.graphics.setColor(Color:extract('grey'))
		love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
		love.graphics.setColor(Color:extract('white'))


		love.graphics.print('self.time: '..self.time, 0, love.graphics.getHeight() - 15)
		love.graphics.print('self.cmp: '..self.cmp, 0, love.graphics.getHeight() - 30)
		love.graphics.print('self.test: '..self.test, 0, love.graphics.getHeight() - 54)
		Dictionnary['hyptosis_tile-art-batch-1'][1]:draw(0, 0, 2)

		self.shader1:send("x", 100)
		self.shader1:send("y", 0)
		love.graphics.setShader(self.shader1)
		love.graphics.rectangle('fill', 100, 0, 16 * 12, 18 * 12)
		love.graphics.setShader()

		self.shader2:send("x", 100)
		self.shader2:send("y", 250)
		self.shader2:send("width", 58)
		self.shader2:send("height", 64 + 64)
		love.graphics.setShader(self.shader2)
		Dictionnary['hyptosis_tile-art-batch-1'].banner:draw(100, 250, 2)
		love.graphics.setShader()

		self.shader2:send("x", 300)
		self.shader2:send("y", 0)
		self.shader2:send("width", 16 * 12)
		self.shader2:send("height", 18 * 12)
		love.graphics.setShader(self.shader2)
		love.graphics.rectangle('fill', 300, 0, 16 * 12, 18 * 12)
		love.graphics.setShader()

		self.shader2:send("x", 300)
		self.shader2:send("y", 250)
		self.shader2:send("width", 16 * 6)
		self.shader2:send("height", 18 * 6)
		love.graphics.setShader(self.shader2)
		Dictionnary['Untitled_master'][2]:draw(300, 250, 6)
		love.graphics.setShader()

		self.shader2:send("x", 500)
		self.shader2:send("y", 0)
		self.shader2:send("width", 500)
		self.shader2:send("height", 500)
		love.graphics.setShader(self.shader2)
		love.graphics.rectangle('fill', 500, 0, 500, 500)
		love.graphics.setShader()

		Dictionnary['hyptosis_tile-art-batch-1'].banner:draw(100, 400, 2)
		Dictionnary['Untitled_master'][2]:draw(300, 300, 12)
	end,
	wheelmoved = function (self, x, y)
		self.cmp  = self.cmp + y
	end,
	keypressed = function (self, key)
		if key == 'space' then State('Other') end

		if key == 'a' then
			self.test = self.test + 1
		elseif key == 'z' then
			self.test = self.test - 1
		end

		if key == 'w' then
			self.cmp = self.cmp + 1
		elseif key == 'x' then
			self.cmp = self.cmp - 1
		end


	end
}
