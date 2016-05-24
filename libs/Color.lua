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
-- name: ColorList
-- namespace: Color
-- description: The color's name list.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Color"
-- examples: "white", "black", "brown", "green", "yellow", "blue", "grey",

Color.white = { 255, 255 , 255, 255 }
Color.black = { 0, 0 , 0, 255 }
Color.brown = { 85, 39 , 0, 255 }
Color.green = { 45, 136 , 45, 255 }
Color.yellow = { 217, 196 , 21, 255 }
Color.blue = { 34, 102 , 102, 255 }
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
		return('\27[38;5;'..colors[color]..'m'..str..'\27[39m')
	else
		return('\27[38;5;'..color..'m'..str..'\27[39m')
	end
end

Color.harmonies = {
	complementary = {0,180},
	splitComplementary = {0,150,320},
	splitComplementaryCW = {0,150,300},
	splitComplementaryCCW = {0,60,210},
	triadic = {0,120,240},
	clash = {0,90,270},
	tetradic = {0,90,180,270},
	fourToneCW = {0,60,180,240},
	fourToneCCW = {0,120,180,300},
	fiveToneA = {0,115,155,205,245},
	fiveToneB = {0,40,90,130,245},
	fiveToneC = {0,50,90,205,320},
	fiveToneD = {0,40,155,270,310},
	fiveToneE = {0,115,230,270,320},
	sixToneCW = {0,30,120,150,240,270},
	sixToneCCW = {0,90,120,210,240,330},
	neutral = {0,15,30,45,60,75},
	analogous = {0,30,60,90,120,150}
}

-----------------------------------------------------------------------------
-- Provides support for color manipulation in HSL color space.
--
-- http://sputnik.freewisdom.org/lib/colors/
--
-- License: MIT/X
--
-- (c) 2008 Yuri Takhteyev (yuri@freewisdom.org) *
--
-- * rgb_to_hsl() implementation was contributed by Markus Fleck-Graffe.
-----------------------------------------------------------------------------

function Color.HSLA(r, g, b, a)
   --r, g, b = r/255, g/255, b/255
   local min = math.min(r, g, b)
   local max = math.max(r, g, b)
   local delta = max - min

   local h, s, l = 0, 0, ((min+max)/2)

   if l > 0 and l < 0.5 then s = delta/(max+min) end
   if l >= 0.5 and l < 1 then s = delta/(2-max-min) end

   if delta > 0 then
      if max == r and max ~= g then h = h + (g-b)/delta end
      if max == g and max ~= b then h = h + 2 + (b-r)/delta end
      if max == b and max ~= r then h = h + 4 + (r-g)/delta end
      h = h / 6;
   end

   if h < 0 then h = h + 1 end
   if h > 1 then h = h - 1 end

   return h, s, l, a
end

function Color.RGBA(h, s, L, a)
   h = h/360
   local m1, m2
   if L<=0.5 then
      m2 = L*(s+1)
   else
      m2 = L+s-L*s
   end
   m1 = L*2-m2

   local function _h2rgb(m1, m2, h)
      if h<0 then h = h+1 end
      if h>1 then h = h-1 end
      if h*6<1 then
         return m1+(m2-m1)*h*6
      elseif h*2<1 then
         return m2
      elseif h*3<2 then
         return m1+(m2-m1)*(2/3-h)*6
      else
         return m1
      end
   end

   return _h2rgb(m1, m2, h+1/3), _h2rgb(m1, m2, h), _h2rgb(m1, m2, h-1/3), a
end

function Color.harmonize(harmony, color)
	if Color.harmonies[harmony] then harmony = Color.harmonies[harmony] end
	if type(harmony) == 'table' then
		local hsla = { Color.HSLA(
			(color.red or color[1]) / 255,
			(color.green or color[2]) / 255,
			(color.blue or color[3]) / 255,
			(color.alpha or color[4]) / 255
		)}

		local ret = {}
		for i,v in ipairs(harmony) do
			local rgba = { Color.RGBA((hsla[1] + (1 / 360 * v)) % 1 * 360, hsla[2], hsla[3], hsla[4]) }

			table.insert(ret, {rgba[1] * 255, rgba[2] * 255, rgba[3] * 255, rgba[4] * 255})
		end

		return ret
	end
end

return Color
