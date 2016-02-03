--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Loader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-01 14:19:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-03 11:50:51
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

	print('Loading\t'..filename)
	Dictionnary[filename] = {}

	if config and config.grid then

		local quadlist = QuadList.create(config.grid, img)
		local canvas = love.graphics.newCanvas(config.grid.width, config.grid.height)

		love.graphics.setCanvas(canvas)
		for i,v in ipairs(quadlist) do
			love.graphics.clear()
			love.graphics.draw(quadlist[0], quadlist[i])

			local d = Drawable:create()
			local new_img = love.graphics.newImage(canvas:newImageData())
			new_img:setFilter('nearest')

			d.scale = config.screen.width / new_img:getWidth()
			d.image = new_img

			table.insert(Dictionnary[filename], d)
		end
		love.graphics.setCanvas()

		if config.exports then
			for k,v in pairs(config.exports) do
				debug('--', v.width * config.grid.width, v.height * config.grid.height)
				local canvas = love.graphics.newCanvas(v.width * config.grid.width, v.height * config.grid.height)

				love.graphics.setCanvas(canvas)
				for i = 0, v.height - 1 do
					for j = 0, v.width - 1 do
						debug(i * config.grid.width, j * config.grid.height)
						Dictionnary[filename][v[i + 1][j + 1]]:draw(j * config.grid.width, i * config.grid.height, 1)
					end
				end

				local d = Drawable:create()
				local new_img = love.graphics.newImage(canvas:newImageData())
				new_img:setFilter('nearest')

				d.scale = config.screen.width * v.width / new_img:getWidth()
				d.image = new_img

				debug(k)
				Dictionnary[filename][k] = d

				love.graphics.setCanvas()


			end
		end
	else
		local d = Drawable:create()
		d.image = img

		Dictionnary[filename][1] = d
	end

end

return Loader
