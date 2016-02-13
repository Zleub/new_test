--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Loader.PNG
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-03 18:21:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 19:01:48
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

function PNG.files(path, filename)
	local fileimg = path..filename..'.png'
	local fileconfig = path..filename..'.lua'

	local config, img

	if love.filesystem.exists(fileconfig) then
		config = dofile(fileconfig)
		config.file = fileconfig
	else
		print('No such file '..fileconfig)
		config = {}
		config.file = fileconfig
	end

	if (love.filesystem.exists(fileimg)) then
		img = love.graphics.newImage(fileimg)
		img:setFilter( 'nearest', 'nearest')
	else return print('No such file '..fileimg) end

	return config, img
end

function PNG:load(path, filename)
	config, img = PNG.files(path, filename)
	config = Loader.check(self, config)

	if config and config.grid then

		local quadlist = QuadList.create(config, img)
		Dictionnary:set(filename, QuadList.toCanvasList(config, quadlist))


		if config.exports then
			for k,v in pairs(config.exports) do
				Dictionnary:set(k, Compound:create(filename, v))
			end
		end

	else
		local d = Drawable:create(img)

		Dictionnary:set(filename, d)
	end

	return filename
end

return PNG
