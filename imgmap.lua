--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:imgmap
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-31 18:08:31
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-31 19:06:25
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local A = {      0,       1}
local B = { 1 / 16, 15 / 16}
local C = { 4 / 16, 12 / 16}
local D = { 8 / 16,  8 / 16}
local E = {10 / 16,  6 / 16}
local F = {      1,       0}

-- local nbr = nbr
-- local nbr2 = nbr2

return function ()
	if nbr2 * (1 / 16) > nbr * (15 / 16) then return  Color:extract('white', 1 - nbr * nbr2) end
	if nbr2 * (4 / 16) > nbr * (12 / 16) then return  Color:extract('brown', 1 - (nbr * nbr2)) end
	if nbr2 * (8 / 16) > nbr * (8 / 16) then return  Color:extract('green', 1 - (nbr * nbr2)) end
	if nbr2 * (10 / 16) > nbr * (6 / 16) then return  Color:extract('yellow', 1 - (nbr * nbr2)) end

	return Color:extract('blue', (nbr * nbr2))
end
