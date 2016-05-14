-- @Author: adebray
-- @Date:   2016-05-07 15:08:12
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-09 16:42:44

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
			if not t then err, msg = Description.error(model, k)

			elseif type(model[k]) == 'table'
				and model[k]['value']
				and not t[k] then
					t[k] = model[k]['value']

			elseif type(model[k]) == 'table'
				and model[k]['type']
				and type(t[k]) ~= model[k]['type'] then
					err, msg = Description.error(model, k)

			elseif type(model[k]) == 'table' and not t[k] then
				t[k] = {}
				err, msg = optionalAPI (model[k]) (t[k], k)

			elseif type(model[k]) == 'table' then
				err, msg = optionalAPI (model[k]) (t[k], k)

			elseif type(t) == 'table' and type(t[k]) ~= 'nil' and type(t[k]) ~= model[k] then
				err, msg = Description.error(model, k)

			end

			if i and not err then return false, msg..'\nin '..i end
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

