--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Clickable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-15 23:51:15
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 00:27:14
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Clickable
-- namespace:
-- description: The Clickable base
-- extendedDescription: The Clickable prototype expand the Drawable type with the mousepressed event. It should be placed into a EventDispatch to get it triggered.
-- arguments:
-- returns:
-- tags: "Clickable"
-- examples:

local Clickable = Drawable:expand()

function Clickable:mousepressed(x, y, button)
	if self.x < x and x < self.x + self.width and
		self.y < y and y < self.y + self.height then

		print(x, y, button)

	end
end

function Clickable:draw(x, y, scale)
	Drawable.draw(self, x, y, scale)
end

return Clickable
