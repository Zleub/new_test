--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Dictionnary
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-12 17:03:06
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-12 17:32:13
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Dictionnary = {}

function Dictionnary:set(k, v)
	if Dictionnary[k] then
		print(Color.shell('Erasing', 'orange')..' Dictionnary['..k..']')
	else
		print('Dictionnary '..':\t'..Color.shell(k, 'green'))
	end

	self[k] = v
end

return Dictionnary
