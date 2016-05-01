--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:Loader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-01 14:19:16
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-13 19:10:40
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Loader
-- namespace:
-- description: This is the standard loader for assets and such.
-- extendedDescription: The Loader type is divided into two main uses so that asset declaration should be distinct from asset instanciation. Point is to allow diversity in manipulation of both image's format and composition.
-- arguments:
-- returns:
-- tags: "Loader", "needCare", "Static"
-- examples:

local Loader = {}

----
-- name: getSize
-- namespace: Loader
-- description: This is a method that return the number of element into the Loader that need to be loaded.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Loader"
-- examples: "Loader:getSize()"

function Loader:getSize()
	return #self.queue
end

----
-- name: load
-- namespace: Loader
-- description: The standard method to load the next ressource from the loader's queue. Return the next element to load.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Loader", "needCare"
-- examples: "Loader:load()"

function Loader:load()
	if self.queue and self.queue[1] then
		local name = self.queue[1].mod:load( unpack(self.queue[1].args) )

		table.remove(self.queue, 1)
		if self.queue[1] then return self.queue[1].args[2] end
	end
end

----
-- name: push
-- namespace: Loader
-- description: This is the standard way to add a ressource to the loader's queue.
-- extendedDescription: The first parameter is the Loader's module to use in order to load the ressource.
-- arguments: "mod", "..."
-- returns:
-- tags: "Loader", "needCare"
-- examples: "Loader:push( Loader.PNG, '/images/hello.png')"

function Loader:push(mod , ...)
	self.queue = self.queue or {}

	table.insert(self.queue, {mod = mod, args = {...}})
end

----------------------------------------

----
-- name: LoaderAPIList
-- namespace: Loader
-- description: The standard list of Loader's mods.
-- extendedDescription: A Loader's API should implement a mandatoryAPI and an optionalAPI field for external config convenience as well as a files and a load method respectively for asset loading and Dictionnary registration.
-- arguments:
-- returns:
-- tags: "Loader", "PNG", "Shader"
-- examples:

Loader.PNG = require 'libs.loader.PNG'
Loader.Shader = require 'libs.loader.Shader'

----
-- name: check
-- namespace: Loader
-- description: This function takes an api and a config and make sure the mandatoryAPI or optionnalAPI is respected.
-- extendedDescription:
-- arguments: "api", "config"
-- returns:
-- tags: "Loader"
-- examples:

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
				io.write(config.file..", "..Color.shell("warning:\n", 'orange')..err..'\n')
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

----
-- name: validator
-- namespace: Loader
-- description: Call on one's api, this function validate some config input based on the api's member's type
-- extendedDescription:
-- arguments: "member", "input"
-- returns:
-- tags: "Loader"
-- examples:

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

----
-- name: error
-- namespace: Loader
-- description: This function is called on a loading error and print on console some pretty message.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "Loader"
-- examples:

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

return Loader
