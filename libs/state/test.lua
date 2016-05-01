--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:test
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-09 19:18:37
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 18:16:59
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Test
-- namespace:
-- description: Some test state.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "State", "Test"
-- examples:

return {
	once = function (self)
		self.text = 'toto'
		self.time = 0
		self.cmp = 1
		self.test = 1

		self.EventDispatch = EventDispatcher:create()

		local m = Modulable.create(Draggable)

		function m:load()
			self.x, self.y = 0, 0
			self.width, self.height = 32 * 2, 32 * 2
			self.scale = 2
			self.canvas = love.graphics.newCanvas(self.width, self.height)
			self.d = Drawable:create( love.graphics.newImage( self.canvas:newImageData() ) )
			self.data = self.d.image:getData( )
			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
		end
		function m:update(dt, cmp, test)
			Draggable.update(self)

			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
			self.shader:send("width", self.width)
			self.shader:send("height", self.height)
			self.shader:send("resolution", cmp)
			self.shader:send("test", test)
			self.shader:send("x", 0)
			self.shader:send("y", 0)

			love.graphics.setCanvas(self.canvas)
				love.graphics.clear()
				love.graphics.setShader(self.shader)
				love.graphics.polygon('fill',
					16 * 2,  0 * 2,
					 1 * 2, 11 * 2,
					 7 * 2, 29 * 2,
					25 * 2, 29 * 2,
					31 * 2, 11 * 2
				)
				love.graphics.setShader()
				love.graphics.setColor(0, 0, 0, 255)
				love.graphics.polygon('fill',
					16 * 2,  2 * 2,
					 3 * 2, 12 * 2,
					 8 * 2, 27 * 2,
					24 * 2, 27 * 2,
					29 * 2, 12 * 2
				)
				love.graphics.setColor(Color:extract('white'))
			love.graphics.setCanvas()

			local d = self.canvas:newImageData()
			self.data:paste( d, 0, 0, 0, 0, self.width, self.height )
			self.d.image:refresh()
			self.d.x, self.d.y = self.x, self.y

		end
		function m:draw(x, y, scale)
			self.d:draw(x, y, self.scale)
		end

		m:load()
		self.EventDispatch:add(m)

		local m = Modulable.create(Draggable)
		function m:load()
			self.d = Dictionnary['Untitled_master'][8]
			self.scale = 8
			self.x, self.y = self.d.x, self.d.y
			self.width, self.height = self.d:getSize()
			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
		end
		function m:update(dt, cmp, test)
			Draggable.update(self)

			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
			self.shader:send("width", self.width * self.scale)
			self.shader:send("height", self.height * self.scale)
			self.shader:send("resolution", cmp)
			self.shader:send("test", test)
			self.shader:send("x", self.x)
			self.shader:send("y", self.y)
		end
		function m:draw()
			self.d:draw(self.x, self.y, self.scale)
			love.graphics.setShader(self.shader)
			self.d:draw(self.x, self.y, self.scale)
			love.graphics.setShader()
		end

		m:load()
		m.x = 100
		self.EventDispatch:add(m)

		local m = Modulable.create(Draggable)
		function m:load()
			self.d = Dictionnary['Untitled_master'][8]
			self.scale = 1
			self.x, self.y = 0, 0
			self.width, self.height = 200, 200
			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
		end
		function m:update(dt, cmp, test)
			Draggable.update(self)

			self.shader = love.graphics.newShader('shaders/test_shader2.glsl')
			self.shader:send("width", self.width * self.scale)
			self.shader:send("height", self.height * self.scale)
			self.shader:send("resolution", cmp)
			self.shader:send("test", test)
			self.shader:send("x", self.x)
			self.shader:send("y", self.y)
		end
		function m:draw()
			love.graphics.setShader(self.shader)
			love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
			love.graphics.setShader()
		end

		m:load()
		m.x = 200
		self.EventDispatch:add(m)
	end,
	update = function (self, dt)
		if not self.pause then self.time = self.time + dt / 2.5 end
		self.test = math.cos(self.time) * 4

		self.EventDispatch.update:dispatch(dt, self.cmp, self.test)
	end,
	draw = function (self)
		love.graphics.print(self.time, 0, 0)
		love.graphics.print(self.cmp, 0, 15)
		love.graphics.print(self.test, 0, 30)


		self.EventDispatch.draw:dispatch()

		Dictionnary.banner:draw()
	end,
	wheelmoved = function (self, x, y)
		self.cmp  = self.cmp + y
	end,
	keypressed = function (self, key)
		if key == 'space' then State('Other') end
		if key == 'return' then
			if self.pause then self.pause = false
			else self.pause = true end
		end


		if key == 'a' then
			self.test = self.test + 1
		elseif key == 'z' then
			self.test = self.test - 1
		end

		if key == 'w' then
			self.cmp = self.cmp + 1
		elseif key == 'x' then
			self.cmp = self.cmp - 1
		end


	end
}

