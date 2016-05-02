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

----
-- name: Dictionnary
-- namespace:
-- description: The Love2D Image Dictionnary
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Dictionnary"
-- examples: "Dictionnary('image', image)", "Dictionnary.image ..."

local Dictionnary = setmetatable({}, {
	__call = function (t, k, v)
		if t[k] then
			print(Color.shell('Erasing', 'orange')..' Dictionnary['..k..']')
		else
			print('Dictionnary '..':\t'..Color.shell(k, 'green'))
		end

		t[k] = v
	end
})

return Dictionnary
