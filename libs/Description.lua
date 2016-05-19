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
	return Description.match(...)
end
})

----
-- name: error
-- namespace: Description
-- description: The standard error for Description matching
-- extendedDescription:
-- arguments: "model", "key"
-- returns: "errro message"
-- tags: "v0.1", "Description"
-- examples:

function Description.error(model, k, i, err)
	local i = i or 0
	local err = err or ''
	local format = function (i, s)
		return string.format("%"..(#s + i).."s", s)
	end

	if type(model[k]) ~= 'table' then
		err = err..format(i, k..' : '..model[k])
		if i ~= 0 then err = err..'\n' end
	else
		err = err..format(i, k..' : {\n')
		for nk,nv in pairs(model[k]) do
			_, err = Description.error(model[k], nk, i + 1, err)
		end
		err = err..format(i, '}')
	end

	return false, err
end

----
-- name: match
-- namespace: Description
-- description: The standard way to match a Description. It takes a model and return a function which take a table to match.
-- extendedDescription:
-- arguments: "model"
-- returns: "function"
-- tags: "v0.1", "Description"
-- examples:

function Description.match(model)
	return function(t, i)
		local msg
		local err = true
		for k,v in pairs(model) do
			if not t then
				err, msg = Description.error(model, k)
			elseif type(t) ~= 'table' and type(t) ~= model[k] then
				err, msg = Description.error(model, k)
			elseif type(t) == 'table' and not t[k] then
				err, msg = Description.error(model, k)
			elseif type(t) == 'table' and type(model[k]) == 'table' and type(t[k]) ~= 'table' then
				err, msg = Description.error(model, k)
			elseif type(t) == 'table' and type(model[k]) == 'table' then
				err, msg = Description(model[k])(t[k], k)
			elseif type(t) == 'table' and type(t[k]) ~= model[k] then
				err, msg = Description.error(model, k) end

			if i and not err then return false, msg..'\nin'..i end
			if not err then return false, msg end
		end

		return true
	end
end

----
-- name: mandatoryAPI
-- namespace: Description
-- description: Shorthand for Description.match
-- extendedDescription:
-- arguments: "model"
-- returns:
-- tags: "v0.1", "Description", "API"
-- examples:

function Description.mandatoryAPI(...)
	return Description(...)
end

----
-- name: optionalAPI
-- namespace: Description
-- description: The standard way to match a Description without strictness.
-- extendedDescription:
-- arguments: "model"
-- returns:
-- tags: "v0.1", "Description", "API"
-- examples:

function Description.optionalAPI(model)
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
				err, msg = Description.optionalAPI (model[k]) (t[k], k)

			elseif type(model[k]) == 'table' then
				err, msg = Description.optionalAPI (model[k]) (t[k], k)

			elseif type(t) == 'table' and type(t[k]) ~= 'nil' and type(t[k]) ~= model[k] then
				err, msg = Description.error(model, k)

			end

			if i and not err then return false, msg..' in '..i end
			if not err then return false, msg end
		end

		return true
	end
end

return Description
