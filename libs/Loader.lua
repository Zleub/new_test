--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Loader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-01 14:19:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-08 15:55:48
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local QuadList = require 'libs.QuadList'
local Class = require 'libs.Class'
local Loader = Class:expand()

function Loader:getSize()
	return #self.queue
end

function Loader:load()
	if self.queue and self.queue[1] then
		local name = self.queue[1].f( unpack(self.queue[1].args) )

		table.remove(self.queue, 1)
		return name
	end
end

function Loader:push(f, ...)
	self.queue = self.queue or {}

	table.insert(self.queue, {f = f, args = {...}})
end

----------------------------------------

function Loader.check(api, config)
	for k,v in pairs(api.mandatoryAPI) do

		if not config[k] then
			io.write(config.file.." error:\n"..api.mandatoryAPI[k]:error())
			config[k] = nil
			return
		end

		local err = api.mandatoryAPI[k]:f(config[k])
		if err then
			io.write(config.file.." error:\n"..err)
			config[k] = nil
			return
		end
	end


	for k,v in pairs(config) do

		if api.optionalAPI[k] then
			local err = api.optionalAPI[k]:f(v)

			if err then
				io.write(config.file.." error:\n"..err)
				config[k] = nil
				return
			end
		end

	end

	return config
end

function Loader.validator(self, input)
	if type(input) ~= 'table' then
		return 'Expected : '..self.error()
	end
	for k,v in pairs(self.model) do
		if not input[k] or type(input[k]) ~= type(v) then
			return 'Expected '..self:error()
		end
	end
end

function Loader.error(self)
	local err = self.name.." : {\n"
	for k,v in pairs(self.model) do
		err = err.."  "..k..": "..type(v)..",\n"
	end
	return err.."}\n"
end

Loader.PNG = {}

Loader.PNG.mandatoryAPI = {
	screen = {
		name = "screen",
		model = {
			width = 42,
			height = 42,
		},
		f = Loader.validator,
		error = Loader.error
	}
}
Loader.PNG.optionalAPI = {
	grid = {
		name = "grid",
		model = {
			width = 42,
			height = 42,
		},
		f = Loader.validator,
		error = Loader.error
	}
}

Loader.PNG.load = function (self, filename, config, img)
	config = Loader.check(self, config)

	local d = Drawable:expand()

	Dictionnary[filename] = {}

	if config and config.grid then
		local quadlist = QuadList.create(config.grid, img)
		local canvas = love.graphics.newCanvas(config.grid.width, config.grid.height)
		local img

		love.graphics.setCanvas(canvas)
		for i,v in ipairs(quadlist) do
			love.graphics.draw(quadlist[0], quadlist[i])
			img = love.graphics.newImage(canvas:newImageData())
			img:setFilter('nearest')

			local d = Drawable:expand()
			d.scale = config.screen.width / img:getWidth()
			d.image = img

			table.insert(Dictionnary[filename], d)
		end
		love.graphics.setCanvas()
	else
		d.image = img

		Dictionnary[filename][1] = d
	end

end

return Loader
