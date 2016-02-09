--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-09 20:11:04
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

		debug(self.test)
	end,

	update = function (self, dt)
		self.time = self.time + dt

		self.test:update(dt)
	end,

	draw = function (self)
		love.graphics.print(self.time)

		self.test:draw()
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
	end

}
