--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Loader.PNG
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-03 18:21:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-10 12:49:52
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
			width = 'number',
			height = 'number',
		},
	}
}
PNG.optionalAPI = {
	grid = {
		name = "grid",
		model = {
			width = {
				type = 'number',
				value = 0
			},
			height = {
				type = 'number',
				value = 0
			},
		}
	},
	spacing = {
		name = "spacing",
		model = {
			width = 'number',
			height = 'number'
		}
	}
}

function PNG:load(filename, config, img)
	config = Loader.check(self, config)

	print('Loading\t'..filename)
	Dictionnary[filename] = {}

	if config and config.grid then

		if not config.spacing then
			config.spacing = {
				width = 0,
				height = 0
			}
		end

		local quadlist = QuadList.create(config, img)
		Dictionnary[filename] = QuadList.toCanvasList(config, quadlist)

		if config.exports then
			for k,v in pairs(config.exports) do
				local canvas = love.graphics.newCanvas(v.width * config.screen.width, v.height * config.screen.height)

				love.graphics.setCanvas(canvas)
				for i = 0, v.height - 1 do
					for j = 0, v.width - 1 do
						Dictionnary[filename][v[i + 1][j + 1]]:draw(j * config.screen.width, i * config.screen.height, 1)
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
