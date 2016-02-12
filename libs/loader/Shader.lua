--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Shader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 19:34:03
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-12 17:11:37
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Shader = {}

Shader.mandatoryAPI = {}
Shader.optionalAPI = {}

function Shader.files(filename)
	local fileshader = 'shaders/'..filename..'.glsl'
	local fileconfig = 'shaders/'..filename..'.lua'

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

function Shader:load(filename)
	config, shader = Shader.files(filename)
	config = Loader.check(self, config)

	Dictionnary:set(filename, shader)

	return filename
end

return Shader
