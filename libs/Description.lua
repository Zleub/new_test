Color = require 'libs.Color'

----
-- name: Description
-- namespace:
-- description: The tool to make Images upon a single meaningful call. Return a validation function.
-- extendedDescription:
-- arguments: "model"
-- returns:
-- tags: "v0.1", 'Description'
-- examples: "QuadDescription = Description {\n screen = {\n  width = 'number',\n  height = 'number'\n }\n}"

local Description = setmetatable({}, {
	__call = function (t, ...)
	return Description.parse(...)
end
})

function Description.error(model, k, i)
	local i = i or 0
	local format = function (i, s)
		return string.format("%"..(#s + i).."s", s)
	end

	if type(model[k]) ~= 'table' then
		print( format(i, k..' : '..model[k]) )
	else
		print( format(i, k..' : {') )
		for nk,nv in pairs(model[k]) do
			Description.error(model[k], nk, i + 1)
		end
		print( format(i, '}') )
	end

	return false
end

function Description.parse(model)
	return function(t, i)
		local err = true
		for k,v in pairs(model) do
			if not t then err = Description.error(model, k)
			elseif not t[k] then err = Description.error(model, k)
			elseif type(model[k]) == 'table' and type(t[k]) ~= 'table' then
				err = Description.error(model, k)
			elseif type(model[k]) == 'table' then
				err = Description(model[k])(t[k], k)
			elseif type(t[k]) ~= model[k] then err = Description.error(model, k) end

			if i and not err then print('in', i) end
			if not err then return false end
		end

		return true
	end
end

return Description
