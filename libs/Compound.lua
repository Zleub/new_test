--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Compound
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 00:55:46
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 14:51:53
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Compound = Drawable:expand()

function Compound.type()
	return 'Compound'
end

function Compound:create(filename, desc)
	local _w, _h = Dictionnary[filename].screen.width, Dictionnary[filename].screen.height
	local canvas = love.graphics.newCanvas(desc.width * _w, desc.height * _h)

	love.graphics.setCanvas(canvas)
	for i = 0, desc.height - 1 do
		for j = 0, desc.width - 1 do
			Dictionnary[filename][desc[i + 1][j + 1]]:draw(j * _w, i * _h, 1)
		end
	end
	love.graphics.setCanvas()

	local c = Drawable.create(self, love.graphics.newImage(canvas:newImageData()))
	c.scale = _w * desc.width / c.image:getWidth()

	return c
end

return Compound
