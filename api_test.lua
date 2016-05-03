-- @Author: adebray
-- @Date:   2016-05-03 16:22:16
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-03 18:29:19

Color = require 'libs.Color'

function Description(model)

	Error = function (model, k, i)
		local i = i or 0
		local format = function (i, s)
			return string.format("%"..(#s + i).."s", s)
		end

		if type(model[k]) ~= 'table' then
			print( format(i, k..' : '..model[k]) )
		else
			print( format(i, k..' : {') )
			for nk,nv in pairs(model[k]) do
				Error(model[k], nk, i + 1)
			end
			print( format(i, '}') )
		end

		return false
	end

	Parse = function (t)
		for k,v in pairs(model) do
			if not t then return Error(model, k)
			elseif not t[k] then return Error(model, k)
			elseif type(model[k]) == 'table' and type(t[k]) ~= 'table' then return Error(model, k)
			elseif type(model[k]) == 'table' then return Description(model[k])(t[k])
			elseif type(t[k]) ~= model[k] then return Error(model, k) end
		end

		return true
	end

	return Parse
end

QuadDescription = Description {
	screen = {
		width = 'number',
		height = 'number'
	},

	grid = {
		width = 'number',
		height = 'number'
	}
}

QuadDescription {
	width = 42,
	height = 42
}

QuadDescription {
	screen = {
		width = 42,
		height = 42
	}
}
