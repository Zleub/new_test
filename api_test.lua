-- @Author: adebray
-- @Date:   2016-05-07 15:08:12
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-07 17:07:10

inspect = require 'exts.inspect'

Color = require 'libs.Color'
require 'libs.Lib'

Description = require 'libs.Description'

function mandatoryAPI(t)
	return Description(t)
end

function optionalAPI(model)
	return function (t, i)
		local msg
		local err = true
		for k,v in pairs(model) do
			-- print('model', k)
			-- print('t', t, t[k])

			if not t then
				-- print('A')
				err, msg = Description.error(model, k)
			-- elseif not t[k] then
			-- 	err, msg = Description.error(model, k)

			elseif type(model[k]) == 'table'
				and model[k]['value']
				and not t[k] then
				-- print('B')

					-- print('Assign default value')
					t[k] = model[k]['value']
			elseif type(model[k]) == 'table'
				and model[k]['type']
				and type(t[k] ~= model[k]['type']) then
					err, msg = Description.error(model, k)

			elseif type(model[k]) == 'table' and not t[k] then
				-- print('C')
				t[k] = {}
				err, msg = optionalAPI (model[k]) (t[k], k)

			elseif type(model[k]) == 'table' then
				-- print('D')
				err, msg = optionalAPI (model[k]) (t[k], k)

			elseif type(t[k]) ~= model[k] then
				-- print('E')
					err, msg = Description.error(model, k)

			end
			-- elseif type(model[k]) == 'table' and type(t[k]) ~= 'table' then
			-- 	err, msg = Description.error(model, k)
			-- elseif type(model[k]) == 'table' then
			-- 	err, msg = optionalAPI (model[k]) (t[k], k) end
			-- elseif type(t[k]) ~= model[k] then
			-- 	err, msg = Description.error(model, k) end

			if i and not err then return msg..'in'..i end
			if not err then return false, msg end
		end

		return true
	end
end

PNG = {}
PNG.mandatoryAPI = mandatoryAPI {
	screen = {
		width = 'number',
		height = 'number'
	}
}

PNG.optionalAPI = optionalAPI {
	grid = {
		width = 'number',
		height = 'number'
	},

	spacing = {
		width = {
			type = 'number',
			value = 0
		},
		height = {
			type = 'number',
			value = 0
		}
	}
}

test = {
	{
		screen = {
			width = 32,
			height = 32
		},

		grid = {
			width = 32,
			height = 32
		}
	},

	{
		screen = {
			width = 64,
			height = 64
		},

		grid = {
			width = '32',
			height = 32
		},

		exports = {
			banner = {
				width = 1,
				height = 2,
				{ 743 - 2 },
				{ 773 - 2 }
			}
		}
	},

	{
		screen = {
			width = 32,
			height = 32
		},

		grid = {
			width = 32,
			height = 32
		},

		spacing = {
			width = '42',
			height = 42
		}

	}
}

for i,v in ipairs(test) do
	print( Color.shell('----------------------', 'orange'))

	if PNG.optionalAPI (v) then
		print( Color.shell('Yeah', 'green'))
	else
		print( Color.shell('Nope', 'red'))
	end

	debug(v)

end
