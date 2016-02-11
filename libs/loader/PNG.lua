--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Loader.PNG
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-03 18:21:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 01:26:04
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
			height = 'number'
		},
	}
}
PNG.optionalAPI = {
	grid = {
		name = "grid",
		model = {
			width = 'number',
			height = 'number'
		}
	},
	spacing = {
		name = "spacing",
		model = {
			width = {
				type = 'number',
				value = 0
			},
			height = {
				type = 'number',
				value = 0
			}
		}
	}
}

function PNG:load(filename, config, img)
	config = Loader.check(self, config)

	print('Loading '..Color.shell('PNG', 'green')..':\t'..filename)
	Dictionnary[filename] = {}

	if config and config.grid then

		local quadlist = QuadList.create(config, img)
		Dictionnary[filename] = QuadList.toCanvasList(config, quadlist)

		if config.exports then
			for k,v in pairs(config.exports) do

				Dictionnary[filename][k] = Compound:create(config.screen, filename, v)

			end
		end

	else
		local d = Drawable:create()
		d.image = img

		Dictionnary[filename][1] = d
	end

end

return PNG
