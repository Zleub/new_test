--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Shader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 19:34:03
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 18:59:55
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Shader
-- namespace:
-- description: The Shader loading mod.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Loader", "Shader"
-- examples:

local Shader = {}

Shader.mandatoryAPI = {}
Shader.optionalAPI = {}

----
-- name: files
-- namespace: Shader
-- description: This function takes a .glsl path and optionnaly a .lua file
-- extendedDescription:
-- arguments: "path", "filename"
-- returns:
-- tags: "v0.0", "Shader"
-- examples:

function Shader.files(path, filename)
	local fileshader = path..filename..'.glsl'
	local fileconfig = path..filename..'.lua'

	local config, shader

	if love.filesystem.exists(fileconfig) then
		config = dofile(fileconfig)
		config.file = fileconfig
	else
		print('No such file '..fileconfig)
		config = {}
		config.file = fileconfig
	end

	if (love.filesystem.exists(fileshader)) then
		shader = love.graphics.newShader(fileshader)
	else return print('No such file '..fileshader) end

	return config, shader
end

----
-- name: load
-- namespace: Shader
-- description: This function load a Shader type into the Dictionnary.
-- extendedDescription:
-- arguments: "filename"
-- returns:
-- tags: "v0.0", "Shader"
-- examples:

function Shader:load(filename)
	config, shader = Shader.files(filename)
	config = Loader.check(self, config)

	Dictionnary:set(filename, shader)

	return filename
end

return Shader
