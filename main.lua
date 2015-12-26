--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-26 15:13:41
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

local img1, ext1 = 'hyptosis_tile-art-batch-1', '.png'

local img = Drawable.create( Asset.load(img1, ext1) )
local img2 = Drawable.create( Asset.load(img1, ext1) )

local scale = 1
local x, y = 0, 0


local map
local size = 300
local complx = 1
local mult = 1
local div = 4

function render(f)
	local imgdt = love.image.newImageData(size, size)
	local img = render_noise(imgdt, f)

	return img
end

function draw(imgdt, nbr, x, y)
	if nbr < 0.4 then imgdt:setPixel(x, y, 34, 102, 102, nbr * 255) end
	if nbr > 0.4 then imgdt:setPixel(x, y, 45, 136, 45, nbr * 255) end
	if nbr > 0.75 then imgdt:setPixel(x, y, 85, 39, 0, nbr * 255) end
	if nbr > 0.9 then imgdt:setPixel(x, y, 255, 255, 255, nbr * 255) end
end

function render_noise(imgdt, f)
	for i = 0, size - 1 do
		for j = 0, size - 1 do
			local nbr = love.math.noise(
				(((i - size / 2) * complx / mult) + x / mult) / size,
				(((j - size / 2) * complx / mult) + y / mult) / size
			)

			local nbr2 = love.math.noise(
				(((i - size / 2) * complx / 255) + x / 255) / size,
				(((j - size / 2) * complx / 255) + y / 255) / size
			)

			draw(imgdt, f(nbr, nbr2), i, j)
		end
	end

	local img = love.graphics.newImage(imgdt)
	img:setFilter('nearest', 'nearest')
	return img
end


local map_screen = math.min(love.graphics.getDimensions())
local map_scale = map_screen / size

function love.wheelmoved(x, y)
	if y > 0 then complx = complx + 1
	elseif complx > 0 then complx = complx - 1 end
end

function love.keypressed(key)

end

function love.load()
end

function love.update(dt)
	if love.keyboard.isDown('up') then y = y - complx end
	if love.keyboard.isDown('down') then y = y + complx end
	if love.keyboard.isDown('left') then x = x - complx end
	if love.keyboard.isDown('right') then x = x + complx end

	if love.keyboard.isDown('pageup') then complx = complx + 10 end
	if love.keyboard.isDown('pagedown') then
		if complx > 0 then complx = complx - 10 end
	end
	if love.keyboard.isDown('kp1') then mult = mult + 1 end
	if love.keyboard.isDown('kp2') then
		if mult > 0 then mult = mult - 1 end
	end
	if love.keyboard.isDown('kp4') then div = div + 1 end
	if love.keyboard.isDown('kp5') then
		if div > 0 then div = div - 1 end
	end
	-- img:update(dt)
	imgmap = render( function (little, big)
		return big
	end)
	imgmap2 = render( function (little, big)
		-- print((little * 0.1) * (big * 0.9))
		-- if (little < big ) then
			return little * (1/div) + big * ((div - 1)/div)
		-- else
			-- return little * big
		-- end
	end)
end

function love.draw()
	-- img:draw(scale, x, y)
	-- img2:draw(scale, x, y)
	love.graphics.draw(imgmap, 0, 0, 0, map_scale, map_scale)
	love.graphics.draw(imgmap2, math.min(love.graphics.getDimensions()), 0, 0, map_scale, map_scale)
	love.graphics.print(complx)
	love.graphics.print(mult, 0, 15)
end
