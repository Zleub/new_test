-- @Author: adebray
-- @Date:   2016-05-14 16:38:54
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-24 20:21:20

return {

	once = function (self)

		local function mergeDescription(src)
			return function (ext)
				if not ext then return src end
				for k,v in pairs(ext) do src[k] = v end
				return mergeDescription(src)
			end
		end


		local green_block = {
			image = 'UI.imagelist',
			screen = {
				width = 32,
				height = 32
			},
			ul = 26, ur = 28, dl = 76, dr = 78,
			bl = 51, br = 53, bu = 27, bd = 77,
			body = 52
		}
		local red_block = {
			image = 'UI.imagelist',
			screen = {
				width = 32,
				height = 32
			},
			ul = 26 + 4, ur = 28 + 4, dl = 76 + 4, dr = 78 + 4,
			bl = 51 + 4, br = 53 + 4, bu = 27 + 4, bd = 77 + 4,
			body = 52 + 4
		}
		local white_block = {
			image = 'UI.imagelist',
			screen = {
				width = 32,
				height = 32
			},
			ul = 26 + 4 * 25, ur = 28 + 4 * 25, dl = 76 + 4 * 25, dr = 78 + 4 * 25,
			bl = 51 + 4 * 25, br = 53 + 4 * 25, bu = 27 + 4 * 25, bd = 77 + 4 * 25,
			body = 52 + 4 * 25
		}

		Loader.Image:load('compound_green1', mergeDescription(red_block)({
			width = love.graphics.getWidth() / 2,
			height = love.graphics.getWidth() / 4,
		})())

		Loader.Image:load('compound_green2', mergeDescription(green_block)({
			width = love.graphics.getWidth() / 4,
			height = love.graphics.getWidth() / 4,
		})())

		Loader.Image:load('compound_red', mergeDescription(red_block)({
			width = 32 * 2,
			height = 32 * 2
		})())

		Loader.Image:load('compound_white', mergeDescription(white_block)({
			width = 32 * 2,
			height = 32 * 2
		})())

		local function stdDraw(image, x, y)
			return function (self)
				love.graphics.draw(image, x, y)
			end
		end

		ED = EventDispatcher:create()
		ED:add({
			draw = stdDraw(Dictionnary['compound_green1'], (love.graphics.getWidth() - Dictionnary['compound_green1']:getWidth()) / 2, 0)
		})
		ED:add({
			draw = stdDraw(Dictionnary['compound_green2'], 0, 100)
		})
		ED:add({
			draw = stdDraw(Dictionnary['compound_red'], 100, 0)
		})
		ED:add({
			draw = stdDraw(Dictionnary['compound_white'], 200, 0)
		})

		self.radius = 32 * 8
		self.time = 0

		self.harmony_step = {}
		for i=1,360,36 do
			table.insert(self.harmony_step, i)
		end
		self.harmony = Color.harmonize(self.harmony_step, {128, 21, 21, 255})

		love.math.setRandomSeed(42)

		self.image_table = {}
		for i=1,#self.harmony_step do
			local t = {}
			local id = love.image.newImageData(8, 8)

			id:mapPixel( function (x, y, r, g, b, a)

				if x >= 4 then
					return unpack(t[(3 - (x - 4))..y])
				end

				if love.math.random() > 0.5 then
					t[x..y] = {255, 255, 255, 255}
					return 255, 255, 255, 255
				else
					t[x..y] = {255, 255, 255, 0}
					return r, g, b, 0
				end
			end)

			local image = love.graphics.newImage(id)
			image:setFilter('nearest')

			table.insert(self.image_table, image)
		end

		self.banner_table = {}
		local width = 100
		for i=1,#self.harmony_step do
			local t = {}
			local id = love.image.newImageData(width, 8)

			id:mapPixel( function (x, y, r, g, b, a)

				if x >= width / 2 then
					return unpack(t[((width / 2 - 1) - (x - width / 2))..y])
				end

				if love.math.random() > 0.75 then
					t[x..y] = {255, 255, 255, 255}
					return 255, 255, 255, 255
				else
					t[x..y] = {255, 255, 255, 0}
					return r, g, b, 0
				end
			end)

			local image = love.graphics.newImage(id)
			image:setFilter('nearest')

			table.insert(self.banner_table, image)
		end

		self.scale = 8
	end,

	update = function (self, dt)
		self.time = self.time + dt
	end,

	wheelmoved = function (self, x, y)
		self.scale = self.scale + y
	end,

	draw = function (self)

		-- ED.draw:dispatch()

		local scale = self.scale
		local radius = self.radius
		local center = { x = love.graphics.getWidth() / 2 - 8 * scale / 2, y = love.graphics.getHeight() / 2 - 8 * scale / 2 }

		local nbr = #self.harmony_step
		local step = 2 * math.pi / nbr
		local angle = math.pi / 2 + self.time / 5
		for i=1,nbr do
			local x = radius * math.cos(angle) + center.x;
			local y = radius * math.sin(angle) + center.y;
			angle = angle + step
			-- love.graphics.draw(Dictionnary['compound_white'], x, y / 2, 0, 2, 2, Dictionnary['compound_green']:getWidth() / 2, Dictionnary['compound_green']:getHeight() / 2)
			love.graphics.setColor(self.harmony[i][1], self.harmony[i][2], self.harmony[i][3], self.harmony[i][4])
			-- love.graphics.rectangle('fill', x, y, 10, 10)
			love.graphics.draw(self.image_table[i], x, y / 2, 0, scale, scale)
			love.graphics.setColor(255, 255, 255, 255)
		end

		for i=1,nbr do
			local x = 0
			local y = love.graphics.getHeight() / 2  + i * 12 * scale

			love.graphics.setColor(self.harmony[i][1], self.harmony[i][2], self.harmony[i][3], self.harmony[i][4])
			love.graphics.draw(self.banner_table[i], x, y, 0, scale, scale)
			love.graphics.setColor(255, 255, 255, 255)
		end


	end
}
