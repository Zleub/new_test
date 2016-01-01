--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-01 12:54:10
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'libs.inspect'

function clamp(num, min, max)
	if num < min then return min
	elseif num > max then return max
	else return num end
end

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		print(inspect(v))
	end
end

Class = require 'libs.Class'
Drawable = require 'libs.Drawable'
Asset = require 'libs.Asset'
Color = require 'libs.Color'

local img1, ext1 = 'hyptosis_tile-art-batch-1', '.png'

local img = Drawable.create( Asset.load(img1, ext1) )
local img2 = Drawable.create( Asset.load(img1, ext1) )

local scale = 1
local x, y = 0, 0


local map
local size = 100
local complx = 500
local mult = 100
local div = 1

imgdt = love.image.newImageData(size, size)
function render(f)
	local img = render_noise(imgdt, f)

	return img
end

function draw(nbr)
	if nbr > 0.9 then return 255 * nbr, 255 * nbr , 255 * nbr, 255 end
	if nbr > 0.75 then return 85 * nbr,  39 * nbr ,   0 * nbr, 255 end
	if nbr > 0.5 then return  45 * nbr, 136 * nbr ,  45 * nbr, 255 end
	if nbr > 0.4 then return  217 * nbr, 196 * nbr ,  21 * nbr, 255 end
	if nbr < 0.4 then return  34 * nbr, 102 * nbr , 102 * nbr, 255 end
end

function render_noise(imgdt, f)

	local s = 100

	function draw_pixel(i, j, r, g, b, a)

		-- I = love.math.noise(
		-- 	((i - size / 2) * complx + x) / size,
		-- 	((j - size / 2) * complx + y) / size
		-- )

		-- II = love.math.noise(
		-- 	((i - size / 2) * complx + x) / 2 / size,
		-- 	((j - size / 2) * complx + y) / 2 / size
		-- )

		-- IV = love.math.noise(
		-- 	((i - size / 2) * complx + x) / 4 / size,
		-- 	((j - size / 2) * complx + y) / 4 / size
		-- )

		-- X = love.math.noise(
		-- 	((i - size / 2) * complx + x) / 10 / size,
		-- 	((j - size / 2) * complx + y) / 10 / size
		-- )

		C = love.math.noise(
			((i - size / 2) * complx + x) / 10 / size,
			((j - size / 2) * complx + y) / 10 / size
		)

		CC = love.math.noise(
			((i - size / 2) * complx + x) / 100 / size,
			((j - size / 2) * complx + y) / 100 / size
		)

		M = love.math.noise(
			((i - size / 2) * complx + x) / 1000 / size,
			((j - size / 2) * complx + y) / 1000 / size
		)

		return f()
	end

	imgdt:mapPixel(draw_pixel)
	local img = love.graphics.newImage(imgdt)
	img:setFilter('nearest', 'nearest')
	return img
end


local map_screen = 800
local map_scale = map_screen / size

function love.wheelmoved(x, y)
	if y > 0 then complx = complx + 1
	elseif complx > 0 then complx = complx - 1 end
end

function love.keypressed(key)
	if key == 'home' then div = div + 1 end
	if key == 'end' then
		if div > 1 then div = div - 1 end
	end
end

function love.load()
end

function love.update(dt)
	if love.keyboard.isDown('up') then y = y - complx end
	if love.keyboard.isDown('down') then y = y + complx end
	if love.keyboard.isDown('left') then x = x - complx end
	if love.keyboard.isDown('right') then x = x + complx end

	if love.keyboard.isDown('pageup') then
		complx = complx + 10
		-- div = div + 1
		 end
	if love.keyboard.isDown('pagedown') then
		if complx > 1 then
		complx = complx - 10
		-- div = div - 1
		end
	end
	if love.keyboard.isDown('a') then mult = mult + 1 end
	if love.keyboard.isDown('z') then
		if mult > 1 then mult = mult - 1 end
	end
	-- if love.keyboard.isDown('home') then div = div + 1 end
	-- if love.keyboard.isDown('end') then
	-- 	if div > 1 then div = div - 1 end
	-- end
	-- img:update(dt)
	imgmap = render(function ()
		if M * ( 1 / 16) > CC * (15 / 16) then return  Color:extract('white') end
		if M * ( 2 / 16) > CC * (14 / 16) then return  Color:extract('brown') end
		if M * ( 9 / 16) > C * ( 7 / 16) then return  Color:extract('green') end
		if M * ( 10 / 16) > C * ( 6 / 16) then return  Color:extract('yellow') end

		return Color:extract('blue')
		end)
	-- imgmap2 = render(function ()
	-- 	if M * ( 1 / 16) > C * (15 / 16) then return  Color:extract('white') end
	-- 	if M * ( 4 / 16) > C * (12 / 16) then return  Color:extract('brown') end
	-- 	if M * ( 8 / 16) > C * ( 8 / 16) then return  Color:extract('green') end
	-- 	if M * (10 / 16) > C * ( 6 / 16) and M * (10 / 16) > X * ( 6 / 16) then return  Color:extract('yellow') end

	-- 	return Color:extract('blue')
	-- 	end)
	-- imgmap3 = render( dofile('imgmap3.lua') )
	-- imgmap4 = render( dofile('imgmap4.lua') )
end

function love.draw()
	love.graphics.draw(imgmap, 0, 0, 0, map_scale, map_scale)
	-- love.graphics.draw(imgmap2, map_screen, 0, 0, map_scale, map_scale)

	if complx < 100 then

	local w = love.graphics.getWidth() / 2 / complx
	local h = love.graphics.getHeight() / complx
	for i=0,complx do
		for j=0,complx do
			-- love.graphics.rectangle('line', i * w + math.min(love.graphics.getDimensions()), j * h, w, h)
			-- love.graphics.setColor(255, 255, 255, 255)
		end
	end
	-- img:draw(scale, x, y)
	-- img2:draw(scale, x, y)

end

	love.graphics.print(complx)
	love.graphics.print(mult, 0, 15)
	love.graphics.print(div, 0, 30)
end
