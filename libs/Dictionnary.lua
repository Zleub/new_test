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
-- examples: "Dictionnary[image]..."

local Dictionnary = {}

----
-- name: set
-- namespace: Dictionnary
-- description: The standard Dictionnary setter
-- extendedDescription:
-- arguments: "key", "value"
-- returns:
-- tags: "Dictionnary"
-- examples: "Dictionnary.set('image', Image)"

function Dictionnary:set(k, v)
	if Dictionnary[k] then
		print(Color.shell('Erasing', 'orange')..' Dictionnary['..k..']')
	else
		print('Dictionnary '..':\t'..Color.shell(k, 'green'))
	end

	self[k] = v
end

return Dictionnary
