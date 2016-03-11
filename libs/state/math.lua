require 'libs.mathtest.Table'
NMatrix = require 'libs.mathtest.NMatrix'

math.randomseed( os.time() )

return {

	before = function (self)

		self.EventDispatch = EventDispatcher:create()

		self.EventDispatch:add({
			load = function (self)
				self.size = love.graphics.getWidth() / 2
				self.imgdt = love.image.newImageData(self.size, self.size)
				self.img = love.graphics.newImage(self.imgdt)

				self.m = NMatrix(2, 1, 4, 0)
				self.n = NMatrix(1, 0, 0, 0)

			end,
			update = function (self)
				self.imgdt:mapPixel( function (x, y)
						if table.fold_left(self.m, function (t, i, v)
							return v * ((x - self.size / 2) / (self.size) * 2) ^ t[i]
						end, 1) < self.size / 2 - y then
							return 255, 0, 0, 255
						else
							return 0, 0, 0, 255
						end
				end )
				self.img:refresh()
			end,
			-- draw = function (self) love.graphics.draw(self.img) end
		})

		self.EventDispatch:add({
			load = function (self)
				self.size = love.graphics.getHeight()
				self.imgdt = love.image.newImageData(self.size, self.size)
				self.img = love.graphics.newImage(self.imgdt)

				self.m = NMatrix(0, 0, 0, 0, 0, 0, 0)
				self.n = NMatrix(2, 2, 2, 2, 0, 0, 0)

			end,
			update = function (self, dt)
				if not self.time then self.time = 0
				elseif self.time > 1 then
					self.m = NMatrix(math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4))
					self.n = NMatrix(math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4), math.random(0, 4))

					self.time = 0
				else self.time = self.time + dt end


				self.imgdt:mapPixel( function (x, y)
						if table.fold_left( self.m:sub(self.n), function (t, i, v)
							return math.floor( v * ((x - self.size / 2) / (self.size) ) ^ t[i] )
						end, 1) == self.size / 2 - y then
							return 255, 0, 0, 255
						else
							return 0, 0, 0, 255
						end
				end )
				self.img:refresh()
			end,
			draw = function (self)
				love.graphics.draw(self.img)
				love.graphics.print(
					self.m:__tostring()..' - '..self.n:__tostring()..' = '..self.m:sub(self.n):__tostring()
				)
			end
		})

		self.EventDispatch.load:dispatch()

	end,

	update = function (self, dt)
		self.EventDispatch.update:dispatch(dt)
	end,

	draw = function (self)
		self.EventDispatch.draw:dispatch()
	end
}
