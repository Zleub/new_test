--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-12 23:32:54
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {
	once = function (self)
		self.time = 0
		self.cmp = 0

		self.test = Draggable:create()
		self.test.image = Dictionnary.test.image
		self.test.width, self.test.height = Dictionnary.test.image:getDimensions()

		self.test2 = Compound:create({width = 64, height = 64}, 'UI', {
			width = 3,
			height = 2,
			{ 1, 2, 3 },
			{ 1, 2, 3 }
		})
		self.test2.y = 64

		self.default_font = love.graphics.getFont()
		self.font = love.graphics.newFont('Minimal3x5.ttf', 16 )

		Loader:push( Loader.Shader, 'test_shader' )
		State('Loading')

		local drawable = Dictionnary.test:expand()

		self.test_shader = Shader:create(
			drawable,
			'shaders/test_ui_shader.glsl'
		)
		self.test_shader.x = 300
		self.test_shader.y = 0
		self.test_shader.width, self.test_shader.height = drawable.image:getDimensions()

		local step = 16
		local canvas = love.graphics.newCanvas(drawable.image:getDimensions())
		love.graphics.setCanvas(canvas)
		love.graphics.setFont(self.font)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 1)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 2)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 3)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 4)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 5)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 6)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 7)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 8)
		love.graphics.print('Hello Workl', self.test.x + 16, self.test.y + step * 9)
		love.graphics.setFont(self.default_font)
		love.graphics.setCanvas()


		self.test_shader.update = function (self, dt, time)
			Draggable.update(self, dt)

			self.shader = love.graphics.newShader(self.filename)
			self.drawable.x, self.drawable.y = self.x, self.y

			self.shader:send('entity', {self.x, self.y, self.width, self.height})
			self.shader:send('time', time)
			self.shader:send('img', canvas)
		end

		debug(self.test_shader)

	end,

	before = function (self) end,

	update = function (self, dt)
		self.time = self.time + dt
		if self.cmp < math.floor(self.time) then
			self.cmp = math.floor(self.time)
			print(self.cmp)
		end

		self.test:update(dt)

		self.test_shader:update(dt, self.time)
	end,

	draw = function (self)
		-- Dictionnary.pict:draw()
		love.graphics.print(self.time)

		love.graphics.rectangle('fill', self.test.x - 1, self.test.y - 1, self.test.width + 2, self.test.height + 2)

		self.test:draw()
		self.test2:draw()

		self.test_shader:draw()

		-- love.graphics.setFont(self.font)
		-- love.graphics.setColor(Color:extract('black'))
		-- love.graphics.print('Hello Workl', self.test.x + 10, self.test.y + 10)
		-- love.graphics.setColor(Color:extract('white'))
		-- love.graphics.setFont(self.default_font)
	end,

	keypressed = function (self, key)
		if key == 'space' then State('Map') end
		if key == 'a' then self.time = 1 end
	end

}
