--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Loader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-01 14:19:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-10 12:40:14
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
			io.write(config.file.." error:\n"..Loader.error(api.mandatoryAPI[k])..'\n')
			config[k] = nil
			return
		end

		local err = Loader.validator(api.mandatoryAPI[k], config[k])
		if err then
			io.write(config.file.." error:\n"..err..'\n')
			config[k] = nil
			return
		end
	end


	for k,v in pairs(config) do

		if api.optionalAPI[k] then
			local err = Loader.validator(api.optionalAPI[k], v)

			if err then
				io.write(config.file.." error:\n"..err)
				config[k] = nil
				return
			end
		end

	end

	return config
end

function Loader.validator(member, input)
	if type(input) ~= 'table' then
		return 'Expected : '..Loader.error()
	end
	for k,v in pairs(member.model) do

		-- debug(k, v)
		local t
		if type(v) == 'table' then t = v.type
		else t = v end

		if not input[k] or type(input[k]) ~= t then
			return 'Expected '..Loader.error(member)
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
	return err.."}\n"
end

print('Reminder -->')
Loader.PNG = require 'libs.loader.PNG'

return Loader
