--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:loading
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:18:29
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-12 16:08:30
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {

	before = function (self)
		self.nbr = Loader:getSize()
	end,

	update = function (self, dt)
		local elem = Loader:load()

		if elem then self.text = elem
		else State(State.previous) end
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
