--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:other
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:19:25
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 00:28:50
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Other
-- namespace:
-- description: Some other demo state.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "State", "Other"
-- examples:

return {
	once = function (self)
		self.time = 0
		self.cmp = 0
		self.mousewheel = 1

		self.EventDispatch = EventDispatcher:create()

		local batch = CanvasBatch:create(
			function (i, j)
				Dictionnary['hyptosis_tile-art-batch-1'][313]:draw(i, j)
			end,
			love.graphics.getWidth(),
			love.graphics.getHeight() / 2
		)

		batch.y = love.graphics.getHeight() / 4
		self.EventDispatch:add( batch )

		local batch = CanvasBatch:create(
			function (i, j)
				local n = love.math.random(-1, 1)
				Dictionnary['hyptosis_tile-art-batch-1'][302 + 30 * n ]:draw(i, j)
			end,
			love.graphics.getWidth(),
			Dictionnary['hyptosis_tile-art-batch-1'].screen.height * 2
		)

		local drawable = Drawable:create(batch.image)
		drawable.y = love.graphics.getHeight() / 4 - Dictionnary['hyptosis_tile-art-batch-1'].screen.height * 2
		self.EventDispatch:add( drawable )


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

		local item2 = Compound:create('UI', {
			width = 2,
			height = 2,
			{ 20 + 25 * 5, 21 + 25 * 5 },
			{ 20 + 25 * 6, 21 + 25 * 6}
		})

		self.container = container
		self.b = container:push(Drawable:create(item2.image))
		self.b1 = container:push(Drawable:create(item.image))
		self.b2 = container:push(Drawable:create(item.image))
		self.b3 = container:push(Clickable:create(item.image))
		self.b4 = container:push(Drawable:create(item.image))

		self.EventDispatch:add( container )

		self.font = love.graphics.newFont('Minimal3x5.ttf', 32)

	end,

	before = function (self) end,

	update = function (self, dt)
		self.time = self.time + dt
		if self.cmp < math.floor(self.time) then
			self.cmp = math.floor(self.time)
		end

		self.EventDispatch.update:dispatch(dt)

	end,

	draw = function (self)
		love.graphics.print(self.mousewheel)

		self.EventDispatch.draw:dispatch()

		love.graphics.setColor(Color:extract('black'))
		love.graphics.setFont(self.font)
		love.graphics.print('test', self.b1.x + (self.b1.width - self.font:getWidth('test')) / 2, self.b1.y + (self.b1.height - self.font:getHeight()) / 2)
		love.graphics.setFont(love.defaultfont)
		love.graphics.setColor(Color:extract('white'))


		Dictionnary['warrior_m'][5]:draw(200, 200)
		Dictionnary['warrior_f'][5]:draw(200, 300)

	end,

	keypressed = function (self, key)
		if key == 'space' then State('Map') end
		if key == 'a' then self.time = 1 end

		if key == 'q' then self.mousewheel = self.mousewheel + 1 end
		if key == 's' then self.mousewheel = self.mousewheel - 1 end
	end,

	wheelmoved = function (self, x, y)
		self.mousewheel = self.mousewheel + y
		if self.mousewheel < 1 then self.mousewheel = 1 end
	end,

	mousepressed = function (self, x, y, button)
		self.EventDispatch.mousepressed:dispatch(x, y, button)
	end

}
