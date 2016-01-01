--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Color
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-31 13:16:27
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-31 17:45:24
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Color = {}

function Color:apply(colorname, factor)
	return self[colorname][1] * factor,
	self[colorname][2] * factor,
	self[colorname][3] * factor,
	self[colorname][4]
end

function Color:extract(colorname)
	return self[colorname][1], self[colorname][2], self[colorname][3], self[colorname][4]
end

Color.white = { 255, 255 , 255, 255 }
Color.black = { 0, 0 , 0, 255 }
Color.brown = { 85, 39 , 0, 255 }
Color.green = { 45, 136 , 45, 255 }
Color.yellow = { 217, 196 , 21, 255 }
Color.blue = { 34, 102 , 102, 255 }

return Color
