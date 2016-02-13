--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 19:53:16
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

return {
	once = function (self)
		self.time = 0
		self.cmp = 0
		self.mousewheel = 1

		self.queue = {}
		local canvas = love.graphics.newCanvas(love.graphics.getWidth(), love.graphics.getHeight() / 2)

		love.graphics.setCanvas(canvas)
		for i=0, love.graphics.getWidth() - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.width do
			for j=0, love.graphics.getHeight() - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.height do

				Dictionnary['hyptosis_tile-art-batch-1'][313]:draw(i, j)

			end
		end
		love.graphics.setCanvas()

		local d = Drawable:create( love.graphics.newImage( canvas:newImageData() ) )
		d.y = love.graphics.getHeight() / 4
		table.insert(self.queue, d )


		local canvas = love.graphics.newCanvas(love.graphics.getWidth(), Dictionnary['hyptosis_tile-art-batch-1'].screen.height * 2)

		love.graphics.setCanvas(canvas)
		for i=0, love.graphics.getWidth() - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.width do
			for j=0, love.graphics.getHeight() - 1, Dictionnary['hyptosis_tile-art-batch-1'].screen.height do

				Dictionnary['hyptosis_tile-art-batch-1'][302]:draw(i, j)

			end
		end
		love.graphics.setCanvas()

		local d = Drawable:create( love.graphics.newImage( canvas:newImageData() ) )
		d.y = love.graphics.getHeight() / 4 - Dictionnary['hyptosis_tile-art-batch-1'].screen.height * 2
		table.insert(self.queue, d )

		local container = UI.Container:create(
			-- {
			-- 	image = 'UI',
			-- 	ul = 26, ur = 28, dl = 76, dr = 78,
			-- 	bl = 51, br = 53, bu = 27, bd = 77,
			-- 	body = 52
			-- },
			love.graphics.getWidth(),
			love.graphics.getHeight() / 4
		)
		container.y = (love.graphics.getHeight() / 4) * 3

		local item = Compound:create('UI', {
			width = 3,
			height = 1,
			{ 13, 14, 15 }
		})
		-- container:push(Drawable:create(item.image))
		-- container:push(Drawable:create(item.image))

		local item2 = Compound:create('UI', {
			width = 2,
			height = 2,
			{ 20 + 25 * 5, 21 + 25 * 5 },
			{ 20 + 25 * 6, 21 + 25 * 6}
		})

		container:push(Drawable:create(item2.image))
		-- container:push(Drawable:create(item2.image))
		container:push(Drawable:create(item.image))
		-- container:push()
		-- container:push(Drawable:create(item.image))

		table.insert(self.queue, container)

	end,

	before = function (self) end,

	update = function (self, dt)
		self.time = self.time + dt
		if self.cmp < math.floor(self.time) then
			self.cmp = math.floor(self.time)
		end

		for i,v in ipairs(self.queue) do
			if v.update then v:update(dt) end
		end

	end,

	draw = function (self)
		-- love.graphics.setColor(Color:extract('grey'))
		-- love.graphics.rectangle('fill', 0, 0, love.graphics.getDimensions())
		-- love.graphics.setColor(Color:extract('white'))

		love.graphics.print(self.mousewheel)
		-- love.graphics.print(self.queue[2].x..self.queue[2].y, 0, 15)

		for i,v in ipairs(self.queue) do
			if v.draw then v:draw() end
		end

		Dictionnary['warrior_m'][5]:draw(200, 200)

	end,

	keypressed = function (self, key)
		if key == 'space' then State('Map') end
		if key == 'a' then self.time = 1 end
	end,

	wheelmoved = function (self, x, y)
		self.mousewheel = self.mousewheel + y
		if self.mousewheel < 1 then self.mousewheel = 1 end
	end

}
