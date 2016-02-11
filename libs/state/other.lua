--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 17:40:44
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {
	once = function (self)
		self.time = 0

		self.test = Draggable:create()
		self.test.image = Dictionnary['UI'].test.image
		self.test.width, self.test.height = Dictionnary['UI'].test.image:getDimensions()

		self.test2 = Compound:create({width = 64, height = 64}, 'UI', {
			width = 3,
			height = 2,
			{ 1, 2, 3 },
			{ 1, 2, 3 }
		})
		self.test2.y = 64

		self.default_font = love.graphics.getFont()
		self.font = love.graphics.newFont('Minimal3x5.ttf', 32 )
	end,

	update = function (self, dt)
		self.time = self.time + dt

		self.test:update(dt)
		-- self.test2:update(dt)
	end,

	draw = function (self)
		love.graphics.print(self.time)

		love.graphics.rectangle('fill', self.test.x - 1, self.test.y - 1, self.test.width + 2, self.test.height + 2)
		self.test:draw()

		self.test2:draw()

		love.graphics.setFont(self.font)
		love.graphics.print('Hello Workl', self.test.x, self.test.y)
		love.graphics.setFont(self.default_font)
	end,

	keypressed = function (self, key)
		if key == 'space' then State('Map') end
		if key == 'a' then debug(self.test) end
	end

}
