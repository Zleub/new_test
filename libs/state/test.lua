--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:test
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:18:37
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 03:00:12
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

		local img = Dictionnary['hyptosis_tile-art-batch-1'].banner:expand()
		img.scale = 4
		self.s1 = Shader:create(img, 'shaders/test_shader2.glsl')

		local img = Dictionnary['Untitled_master'][2]:expand()
		img.scale = 12
		self.s2 = Shader:create(img, 'shaders/test_shader2.glsl')

	end,
	update = function (self, dt)
		self.time = self.time + dt / 2.5
		self.test = math.cos(self.time) * 4

		self.s1:update(dt, self.cmp, self.test)
		self.s2:update(dt, self.cmp, self.test)

	end,
	draw = function (self)

		love.graphics.setColor(Color:extract('grey'))
		love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
		love.graphics.setColor(Color:extract('white'))

		love.graphics.print('self.time: '..self.time, 0, love.graphics.getHeight() - 15)
		love.graphics.print('self.cmp: '..self.cmp, 0, love.graphics.getHeight() - 30)
		love.graphics.print('self.test: '..self.test, 0, love.graphics.getHeight() - 54)

		self.s1:draw(10, 0)
		self.s2:draw()

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
