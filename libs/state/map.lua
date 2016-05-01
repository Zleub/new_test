--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:map
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:52:52
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 15:45:05
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Map = {}

----
-- name: Map
-- namespace:
-- description: The Map State, where magic is done.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Map", "State"
-- examples:

function Map:once()
	self.scale = 1
	self.x, self.y = 0, 0

	-- self.map
	self.size = 100
	self.complx = 500
	self.mult = 100
	self.div = 1

	self.imgdt = love.image.newImageData(self.size, self.size)

	self.map_screen = 800
	self.map_scale = self.map_screen / self.size
end

function Map:update(dt)
	if love.keyboard.isDown('up') then self.y = self.y - self.complx end
	if love.keyboard.isDown('down') then self.y = self.y + self.complx end
	if love.keyboard.isDown('left') then self.x = self.x - self.complx end
	if love.keyboard.isDown('right') then self.x = self.x + self.complx end

	if love.keyboard.isDown('pageup') then
		self.complx = self.complx + 10
		 end
	if love.keyboard.isDown('pagedown') then
		if self.complx > 1 then
			self.complx = self.complx - 10
		end
	end

	if love.keyboard.isDown('a') then
		self.mult = self.mult + 1
	end
	if love.keyboard.isDown('z') then
		if self.mult > 1 then
			self.mult = self.mult - 1
		end
	end

	self.img = self:render_noise(function ()
		if C * ( 1 / 16) > M * (15 / 16) then return  Color:extract('white') end
		if C * ( 2 / 16) > M * (14 / 16) then return  Color:extract('brown') end
		if C * ( 6 / 16) > M * (10 / 16) then return  Color:extract('green') end
		if C * ( 6.5 / 16) > M * (9.5 / 16) then return  Color:extract('yellow') end
		-- if C * ( 4 / 16) > M * (12 / 16) then return  Color:extract('yellow') end

		return Color:extract('blue')
		end)
end

function Map:draw()
	love.graphics.draw(self.img, 0, 0, 0, self.map_scale, self.map_scale)
	-- love.graphics.draw(imgmap2, map_screen, 0, 0, map_scale, map_scale)
end

function Map:keypressed(key)
	if key == 'home' then self.div = self.div + 1 end
	if key == 'end' then
		if self.div > 1 then self.div = self.div - 1 end
	end
	if key == 'space' then State('Test') end
end

function Map:wheelmoved(x, y)
	if y > 0 then self.complx = self.complx + 1
	elseif self.complx > 0 then self.complx = self.complx - 1 end
end

function Map:render_noise(f)

	local s = 100

	function draw_pixel(i, j, r, g, b, a)

		C = love.math.noise(
			((i - self.size / 2) * self.complx + self.x) / self.mult / self.size,
			((j - self.size / 2) * self.complx + self.y) / self.mult / self.size
		)

		CC = love.math.noise(
			((i - self.size / 2) * self.complx + self.x) / 100 / self.size,
			((j - self.size / 2) * self.complx + self.y) / 100 / self.size
		)

		M = love.math.noise(
			((i - self.size / 2) * self.complx + self.x) / 1000 / self.size,
			((j - self.size / 2) * self.complx + self.y) / 1000 / self.size
		)

		return f()
	end

	self.imgdt:mapPixel(draw_pixel)
	local img = love.graphics.newImage(self.imgdt)
	img:setFilter('nearest', 'nearest')
	return img
end

function draw(nbr)
	if nbr > 0.9 then return 255 * nbr, 255 * nbr , 255 * nbr, 255 end
	if nbr > 0.75 then return 85 * nbr,  39 * nbr ,   0 * nbr, 255 end
	if nbr > 0.5 then return  45 * nbr, 136 * nbr ,  45 * nbr, 255 end
	if nbr > 0.4 then return  217 * nbr, 196 * nbr ,  21 * nbr, 255 end
	if nbr < 0.4 then return  34 * nbr, 102 * nbr , 102 * nbr, 255 end
end

return Map
