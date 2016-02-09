--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-09 19:19:30
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {
	once = function (self)
		self.time = 0
	end,
	update = function (self, dt)
		self.time = self.time + dt
	end,
	draw = function (self)
		love.graphics.print(self.time)

		Dictionnary['UI'].test:draw(0, 0, 1)
		-- local j = 0
		-- for i,v in ipairs(Dictionnary['UI']) do
		-- 	v:draw(0 + 40 * ((i - 1) % 25), 0 + 40 * j, 1)
		-- 	if (i % 25) == 0 then
		-- 		j = j + 1
		-- 	end
		-- end
	end,
	keypressed = function (self, key)
		if key == 'space' then State('Test') end
	end

}
