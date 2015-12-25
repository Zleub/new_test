--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Asset
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-20 01:44:25
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-24 04:05:51
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local QuadList = require 'libs.QuadList'
local Class = require 'libs.Class'
local Asset = Class:expand()

function Asset.load(filename, format)
	local file_img = 'assets/'..filename..format
	local file_config = 'assets/'..filename..'.lua'

	local config, img
	if love.filesystem.exists(file_config) then
		config = dofile(file_config)
		config.file = file_config
	else print('No such file '..file_config) end

	if (love.filesystem.exists(file_img)) then
		img = love.graphics.newImage(file_img)
		img:setFilter( 'nearest', 'nearest')
	else print('No such file '..file_img) end

	return config, img
end

return Asset
