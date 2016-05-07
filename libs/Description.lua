Color = require 'libs.Color'

----
-- name: Description
-- namespace:
-- description: The tool to make Images upon a single meaningful call. Return a validation function.
-- extendedDescription:
-- arguments: "model"
-- returns:
-- tags: "v0.1", "Description"
-- examples: "QuadDescription = Description {\n screen = {\n  width = 'number',\n  height = 'number'\n }\n}"

local Description = setmetatable({}, {
	__call = function (t, ...)
	return Description.parse(...)
end
})

function Description.error(model, k, i, err)
	local i = i or 0
	local err = err or ''
	local format = function (i, s)
		return string.format("%"..(#s + i).."s", s)
	end

	if type(model[k]) ~= 'table' then
		err = err..format(i, k..' : '..model[k])..'\n'
	else
		err = err..format(i, k..' : {\n')
		for nk,nv in pairs(model[k]) do
			_, err = Description.error(model[k], nk, i + 1, err)
		end
		err = err..format(i, '}')
	end

	return false, err
end

function Description.parse(model)
	return function(t, i)
		local msg
		local err = true
		for k,v in pairs(model) do
			if not t then
				err, msg = Description.error(model, k)
			elseif not t[k] then
				err, msg = Description.error(model, k)
			elseif type(model[k]) == 'table' and type(t[k]) ~= 'table' then
				err, msg = Description.error(model, k)
			elseif type(model[k]) == 'table' then
				err, msg = Description(model[k])(t[k], k)
			elseif type(t[k]) ~= model[k] then
				err, msg = Description.error(model, k) end

			if i and not err then return msg..'in'..i end
			if not err then return false, msg end
		end

		return true
	end
end

return Description
