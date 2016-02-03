--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Loader.PNG
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-03 18:21:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-03 19:39:06
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

QuadList = require 'libs.QuadList'

local PNG = {}

PNG.mandatoryAPI = {
	screen = {
		name = "screen",
		model = {
			width = 42,
			height = 42,
		},
	}
}
PNG.optionalAPI = {
	grid = {
		name = "grid",
		model = {
			width = 42,
			height = 42,
		},
	}
}

function PNG:load(filename, config, img)
	config = Loader.check(self, config)

	print('Loading\t'..filename)
	Dictionnary[filename] = {}

	if config and config.grid then

		local quadlist = QuadList.create(config.grid, img)
		local canvas = love.graphics.newCanvas(config.grid.width, config.grid.height)

		love.graphics.setCanvas(canvas)
		for i,v in ipairs(quadlist) do
			love.graphics.clear()
			love.graphics.draw(quadlist[0], quadlist[i])

			local d = Drawable:create()
			local new_img = love.graphics.newImage(canvas:newImageData())
			new_img:setFilter('nearest')

			d.scale = config.screen.width / new_img:getWidth()
			d.image = new_img

			table.insert(Dictionnary[filename], d)
		end
		love.graphics.setCanvas()

		if config.exports then
			for k,v in pairs(config.exports) do
				local canvas = love.graphics.newCanvas(v.width * config.grid.width, v.height * config.grid.height)

				love.graphics.setCanvas(canvas)
				for i = 0, v.height - 1 do
					for j = 0, v.width - 1 do
						Dictionnary[filename][v[i + 1][j + 1]]:draw(j * config.grid.width, i * config.grid.height, 1)
					end
				end

				local d = Drawable:create()
				local new_img = love.graphics.newImage(canvas:newImageData())
				new_img:setFilter('nearest')

				d.scale = config.screen.width * v.width / new_img:getWidth()
				d.image = new_img

				Dictionnary[filename][k] = d

				love.graphics.setCanvas()


			end
		end
	else
		local d = Drawable:create()
		d.image = img

		Dictionnary[filename][1] = d
	end

end

return PNG
