--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:UI
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 18:29:51
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-09 19:15:28
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local config = {}

config.screen = {
	width = 64,
	height = 64
}

config.grid = {
	width = 32,
	height = 32
}

config.spacing = {
	width = 2,
	height = 2
}

config.exports = {}
config.exports.test = {
	width = 3,
	height = 6,
	{ 1 + 25 * 1, 2 + 25 * 1, 3 + 25 * 1 },
	{ 1 + 25 * 2, 2 + 25 * 2, 3 + 25 * 2 },
	{ 1 + 25 * 2, 2 + 25 * 2, 3 + 25 * 2 },
	{ 1 + 25 * 2, 2 + 25 * 2, 3 + 25 * 2 },
	{ 1 + 25 * 2, 2 + 25 * 2, 3 + 25 * 2 },
	{ 1 + 25 * 3, 2 + 25 * 3, 3 + 25 * 3 },
}

return config
