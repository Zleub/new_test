--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 01:46:19
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

		self.test2 = Compound:create({width = 64, height = 64 }, 'UI', {
			width = 3,
			height = 1,
			{ 1, 2, 3 }
		})

	end,

	update = function (self, dt)
		self.time = self.time + dt

		self.test:update(dt)
		-- self.test2:update(dt)
	end,

	draw = function (self)
		love.graphics.print(self.time)

		self.test:draw()
		self.test2:draw()
		-- Dictionnary['UI'].test:draw(0, 0, 1)
		-- local j = 0
		-- for i,v in ipairs(Dictionnary['UI']) do
		-- 	v:draw(0 + 40 * ((i - 1) % 25), 0 + 40 * j, 1)
		-- 	if (i % 25) == 0 then
		-- 		j = j + 1
		-- 	end
		-- end
	end,

	keypressed = function (self, key)
		if key == 'space' then State('Map') end
		if key == 'a' then debug(self.test) end
	end

}
