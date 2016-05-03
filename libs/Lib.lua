--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Lib
-- /ddddy:oddddddddds:sddddd/ By Zleub - Zleub
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-16 17:32:29
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 17:32:42
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: definition_solver
-- namespace:
-- description: Function for polymorphism in Lua.
-- extendedDescription: The function work with some stringifiction of type into a string to find out which function of the definiton_table to call.\nDefinitively not classy.
-- arguments: "module", "definition_table", "..."
-- returns:
-- tags: "v0.0", "Tips&Tricks"
-- examples: "function Something:create(...)\n\treturn definitions_solver(self, {\n\t['_'] = function (...) debug('Something._', {...}) end,\n\t['string'] = Something.create_from_string,\n\t['number, number'] = Something.create_from_size\n\t}, ...)\nend"

function definitions_solver(self, def_table, ...)
	local s = ''

	for i,v in ipairs({...}) do
		if type(v) == 'table' and v.type then s = s..v:type()
		elseif type(v) == 'userdata' then s = s..v:type()
		else s = s..type(v) end
		if ({...})[i + 1] then s = s..', ' end
	end

	if def_table[s] then
		return def_table[s](self, ...)
	else
		return def_table['_'](self, ...)
	end
end

----
-- name: clamp
-- namespace:
-- description: The function to clamp a number
-- extendedDescription:
-- arguments: "number", "min", "max"
-- returns:
-- tags:
-- examples:

function clamp(num, min, max)
	if num < min then return min
	elseif num > max then return max
	else return num end
end

----
-- name: debug
-- namespace:
-- description: Function for easy debugging.
-- extendedDescription:
-- arguments: "anything"
-- returns:
-- tags:
-- examples: "debug(...)"

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		io.write(inspect(v))
		if ({...})[i + 1] then
			io.write(', ')
		else
			io.write('\n')
		end
	end
end

function print_require_list(...)
	for k,v in ipairs({...}) do
		local name = v:match('.+%.(%w+)')

		_G[name] = require(v)
		print(name..' required:', inspect( _G[name], {depth = 1} ) )
	end
end

----
-- name: require_list
-- namespace:
-- description: Function for easy requirement
-- extendedDescription: That function use the last part of a path as the index for the global variable.
-- arguments: "path"
-- returns:
-- tags: "v0.0", "Tips&Tricks"
-- examples: "require_list('lib.Class', 'ext.inspect')"

function require_list(...)
	local args = ({...})
	for k,v in ipairs(args) do
		local name = v:match('.+%.([%w_]+)')

		_G[name] = require(v)
	end
end
