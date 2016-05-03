--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Color
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-31 13:16:27
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 20:49:11
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Color
-- namespace:
-- description: The Color module is meant to shorter ascii and love2d color management.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Color"
-- examples

local Color = {}

----
-- name: apply
-- namespace: Color
-- description: The apply function returns a quartet of (number * factor) given a string for color purposes.
-- extendedDescription:
-- arguments: "colorName", "factor"
-- returns:
-- tags: "v0.0", "Color", "Graphics"
-- examples: "Color:apply('white', 0.2)"

function Color:apply(colorname, factor)
	return self[colorname][1] * factor,
	self[colorname][2] * factor,
	self[colorname][3] * factor,
	self[colorname][4]
end

----
-- name: extract
-- namespace: Color
-- description: The extract function returns a quartet of number given a string for color purposes.
-- extendedDescription:
-- arguments: "colorName"
-- returns:
-- tags: "v0.0", "Color", "Graphics"
-- examples: "Color:extract('white')"

function Color:extract(colorname)
	return self[colorname][1], self[colorname][2], self[colorname][3], self[colorname][4]
end

----
-- name: white
-- namespace: Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.white = { 255, 255 , 255, 255 }

----
-- name: black
-- namespace: Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.black = { 0, 0 , 0, 255 }

----
-- name: brown
-- namespace: Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.brown = { 85, 39 , 0, 255 }

----
-- name: green
-- namespace: Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.green = { 45, 136 , 45, 255 }

----
-- name: yellow
-- namespace: Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.yellow = { 217, 196 , 21, 255 }

----
-- name: blue
-- namespace:Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.blue = { 34, 102 , 102, 255 }

----
-- name: grey
-- namespace:Color
-- tags: "v0.0", "Color", "ColorList", "Graphics"
Color.grey = { 127, 127 , 127, 255 }

----
-- name: shell
-- namespace: Color
-- description: A function for shell's color rendering
-- extendedDescription:
-- arguments: "string", "asciiColor"
-- returns: "string"
-- tags: "v0.0", "Color"
-- examples: "str = Color.shell('HelloWorld', 'red')"
function Color.shell(str, color)
	local colors = {
		black = 0,
		red = 1,
		green = 2,
		yellow = 3,
		blue = 4,
		magenta = 5,
		cyan = 6,
		white = 7,

		orange = 202
	}

	if colors[color] then
		return('\27[38;5;'..colors[color]..'m'..str..'\27[38;5;7m')
	else
		return('\27[38;5;'..color..'m'..str..'\27[38;5;7m')
	end

end

return Color
