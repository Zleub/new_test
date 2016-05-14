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

----
-- name: PNG
-- namespace:
-- description: The PNG loading mod.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Loader", "PNG"
-- examples:

local PNG = {}

----
-- name: mandatoryAPI
-- namespace: PNG
-- description: The mandatoryAPI of a PNG
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.1", "PNG"
-- examples: "{\n screen = {\n  name = 'screen',\n  model = {\n   width = 'number',\n   height = 'number'\n  },\n }\n}"

PNG.mandatoryAPI = Description.mandatoryAPI {
	screen = {
		width = 'number',
		height = 'number'
	}
}

----
-- name: optionalAPI
-- namespace: PNG
-- description: The optionalAPI of a PNG
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.1", "PNG"
-- examples: "{\n grid = {\n  name = 'grid',\n  model = {\n   width = 'number',\n   height = 'number'\n  }\n },\n spacing = {\n  name = 'spacing',\n  model = {\n   width = {\n    type = 'number',\n    value = 0\n   },\n   height = {\n    type = 'number',\n    value = 0\n   }\n  }\n }\n}"

PNG.optionalAPI = Description.optionalAPI {
	grid = {
		width = 'number',
		height = 'number'
	},
	spacing = {
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

----
-- name: files
-- namespace: PNG
-- description: This function opens a .png file and optionnaly an adjacent .lua file
-- extendedDescription:
-- arguments: "path", "filename", "configname"
-- returns:
-- tags: "v0.0", "PNG"
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
-- name: load_from_path
-- namespace: PNG
-- description: This function applies a config upon a Image and load the result into the Dictionnary
-- extendedDescription:
-- arguments: "path", "filename", "configname"
-- returns:
-- tags: "v0.1", "PNG"
-- examples:

function PNG:load_from_path(path, filename, configname)
	-- print('PNG.load '..filename)

	config, img = PNG.files(path, filename, configname)

	err, msg = self.mandatoryAPI(config)
	if not err then return print(msg..'\nin '..Color.shell(filename..'.lua', 'red')) end

	err, msg = self.optionalAPI(config)
	if not err then return print(msg..'\nin '..Color.shell(filename..'.lua', 'red')) end

	if config and config.grid.width and config.grid.height then

		-- local quadlist = QuadList.create(config, img)
		-- Dictionnary(filename, QuadList.toCanvasList(config, quadlist))

		-- if config.exports then
		-- 	for k,v in pairs(config.exports) do
		-- 		if type(v) == 'table' then
		-- 			Dictionnary(k, Compound:create(filename, v))
		-- 		elseif type(v) == 'number' then
		-- 			Dictionnary(k, quadlist[v])
		-- 		else
		-- 			print('PNG loading error')
		-- 		end
		-- 	end
		-- end

	end
	-- Dictionnary(filename, img)

	Loader.Image:load(filename, img)

	return filename
end

function PNG:load(...)
	return definitions_solver(self, {
		-- ['_'] = function (...) debug('PNG.anything', {...}) end,
		['string, string'] = PNG.load_from_path,
		['string, string, string'] = PNG.load_from_path
	}, ...)
end

return PNG
