--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Asset
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-20 01:44:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-03 13:31:57
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Loader = require 'libs.Loader'
local Class = require 'libs.Class'
local Asset = Class:expand()

function Asset.load(filename, format)
	local fileimg = 'assets/'..filename..'.'..format
	local fileconfig = 'assets/'..filename..'.lua'

	local config, img

	if love.filesystem.exists(fileconfig) then
		config = dofile(fileconfig)
		config.file = fileconfig
	else return print('No such file '..fileconfig) end

	if (love.filesystem.exists(fileimg)) then
		img = love.graphics.newImage(fileimg)
		img:setFilter( 'nearest', 'nearest')
	else return print('No such file '..fileimg) end

	Loader[ format:upper() ]:load(filename, config, img)

	print(filename)
	return filename
end

return Asset
