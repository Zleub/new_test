--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Compound
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 00:55:46
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 01:26:22
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Compound = Drawable:expand()

function Compound:create(screen_size, filename, desc)
	local canvas = love.graphics.newCanvas(desc.width * screen_size.width, desc.height * screen_size.height)

	love.graphics.setCanvas(canvas)
	for i = 0, desc.height - 1 do
		for j = 0, desc.width - 1 do
			Dictionnary[filename][desc[i + 1][j + 1]]:draw(j * screen_size.width, i * screen_size.height, 1)
		end
	end
	love.graphics.setCanvas()

	local c = Drawable.create(self, love.graphics.newImage(canvas:newImageData()))
	c.scale = screen_size.width * desc.width / c.image:getWidth()

	return c
end

return Compound
