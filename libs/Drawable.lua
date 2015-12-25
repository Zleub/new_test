--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Drawable
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:21:33
-- :ddddddddddhyyddddddddddd: Modified: 2015-12-24 07:33:00
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local QuadList = require 'libs.QuadList'
local Class = require 'libs.Class'
local Drawable = Class:expand()

Drawable.API = {}
Drawable.API.validator = function (self, input)
	if type(input) ~= 'table' then
		return 'Expected : '..self.error()
	end
	for k,v in pairs(self.model) do
		if not input[k] or type(input[k]) ~= type(v) then
			return 'Expected '..self:error()
		end
	end
end
Drawable.API.error = function (self)
	local err = self.name.." : {\n"
	for k,v in pairs(self.model) do
		err = err.."  "..k..": "..type(v)..",\n"
	end
	return err.."}\n"
end

Drawable.mandatoryAPI = {
	screen = {
		name = "screen",
		model = {
			width = 42,
			height = 42,
		},
		f = Drawable.API.validator,
		error = Drawable.API.error
	}
}
Drawable.optionalAPI = {
	grid = {
		name = "grid",
		model = {
			width = 42,
			height = 42,
		},
		f = Drawable.API.validator,
		error = Drawable.API.error
	}
}

function Drawable.checkConfig(config)
	for k,v in pairs(config) do

		if Drawable.mandatoryAPI[k] then
			local str = Drawable.mandatoryAPI[k]:f(v)
			if str then
				io.write(config.file.." error:\n"..str)
				config[k] = nil
				return
			end
		end

		if Drawable.optionalAPI[k] then
			local str = Drawable.optionalAPI[k]:f(v)
			if str then
				io.write(config.file.." error:\n"..str)
				config[k] = nil
			end
		end

	end

	return config
end

function Drawable.create(config, image)
	config = Drawable.checkConfig(config)
	if not config then return end

	local d = {}
	if config.grid then
		d.scale = config.screen.width / config.grid.width
		d.quadlist = QuadList.create(config.grid, image)
		d.index = 1
		d.draw = function (self, scale, x, y)
			love.graphics.draw(self.image, self.quadlist[self.index], self.x, self.y, 0, self.scale * scale, self.scale * scale, x, y)
		end
	else
		d.scale = config.screen.width / image:getWidth()
		d.draw = function (self, scale, x, y)
			love.graphics.draw(self.image, self.x, self.y, 0, self.scale * scale, self.scale * scale, x, y)
		end
	end
	d.image = image
	d.x = 0
	d.y = 0
	d.time = 1
	d.update = function (self, dt)
		self.time = self.time + dt * 10
		print(self.time)
		self.index = math.floor(self.time)
	end

	return d
end

return Drawable
