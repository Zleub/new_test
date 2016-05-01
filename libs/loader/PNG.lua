--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Loader.PNG
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-03 18:21:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 23:55:03
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

QuadList = require 'libs.QuadList'

----
-- name: PNG
-- namespace:
-- description: The PNG loading mod.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Loader", "PNG"
-- examples:

local PNG = {}

----
-- name: mandatoryAPI
-- namespace: PNG
-- description: The mandatoryAPI of a PNG
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "PNG"
-- examples: "{\n screen = {\n  name = 'screen',\n  model = {\n   width = 'number',\n   height = 'number'\n  },\n }\n}"

PNG.mandatoryAPI = {
	screen = {
		name = "screen",
		model = {
			width = 'number',
			height = 'number'
		},
	}
}

----
-- name: optionalAPI
-- namespace: PNG
-- description: The optionalAPI of a PNG
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "PNG"
-- examples: "{\n grid = {\n  name = 'grid',\n  model = {\n   width = 'number',\n   height = 'number'\n  }\n },\n spacing = {\n  name = 'spacing',\n  model = {\n   width = {\n    type = 'number',\n    value = 0\n   },\n   height = {\n    type = 'number',\n    value = 0\n   }\n  }\n }\n}"

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

----
-- name: files
-- namespace: PNG
-- description: This function opens a .png file and optionnaly an adjacent .lua file
-- extendedDescription:
-- arguments: "path", "filename", "configname"
-- returns:
-- tags: "PNG"
-- examples:

function PNG.files(path, filename, configname)
	local fileimg = path..filename..'.png'
	local fileconfig = path..(configname or filename)..'.lua'

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

----
-- name: load
-- namespace: PNG
-- description: This function applies a config upon a Image and load the result into the Dictionnary
-- extendedDescription:
-- arguments: "path", "filename", "configname"
-- returns:
-- tags: "PNG"
-- examples:

function PNG:load(path, filename, configname)
	config, img = PNG.files(path, filename, configname)
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
