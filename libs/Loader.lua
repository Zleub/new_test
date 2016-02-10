--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Loader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-01 14:19:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-10 21:22:50
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Loader = {}

function Loader:getSize()
	return #self.queue
end

function Loader:load()
	if self.queue and self.queue[1] then
		local name = self.queue[1].f( unpack(self.queue[1].args) )

		table.remove(self.queue, 1)
		if self.queue[1] then return self.queue[1].args[1] end
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
			io.write(config.file..", "..Color.shell("error:\n", "red")..Loader.error(v)..'\n')
			config[k] = nil
			return
		end

		local err = Loader.validator(v, config[k])
		if err then
			io.write(config.file..", "..Color.shell("error:\n", "red")..err..'\n')
			config[k] = nil
			return
		end
	end


	for k, v in pairs(api.optionalAPI) do

		if config[k] then
			local err = Loader.validator(v, config[k])

			if err then
				io.write(config.file..", "..Color.shell("warning:\n", 202)..err..'\n')
				config[k] = nil
			end
		end

		if not config[k] then
			local t = {}
			local err = Loader.validator(v, t)

			if next(t) ~= nil then
				config[k] = t
			end
		end

	end

	return config
end

function Loader.validator(member, input)
	if type(input) ~= 'table' then
		return Loader.error(member)
	end

	for k,v in pairs(member.model) do

		if type(v) == 'table' then
			if input[k] and type(input[k]) ~= v.type then
				return Loader.error(member)
			end
			input[k] = input[k] or v.value
		else
			if not input[k] or type(input[k]) ~= v then
				return Loader.error(member)
			end
		end
	end
end

function Loader.error(member)
	local err = member.name.." : {\n"
	for k,v in pairs(member.model) do
		if type(v) == 'table' then
			err = err.."  "..k..": "..v.type..",\n"
		else
			err = err.."  "..k..": "..v..",\n"
		end
	end
	return err.."}"
end

Loader.PNG = require 'libs.loader.PNG'

return Loader
