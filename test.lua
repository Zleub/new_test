local inspect = require 'exts.inspect'

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		io.write(inspect(v))
		if ({...})[i + 1] then io.write(', ')
		else io.write('\n') end
	end
end

-- local test = {
-- 	binop = { '+', '-', '*', '/' },
-- 	operand = { 'x', 'y' },
-- 	expression = { 'operand', 'binop', 'operand' }
-- }


-- function toto(t, s, it, next)
-- 	local s = s or ''

-- 	local it = it or pairs(t)

-- 	-- for k,v in  do
-- 	local k, v = it(t, next)
-- 	debug(k, v)

-- 		if test[v] then
-- 			s = s..toto(test[v])
-- 		elseif k then
-- 			return s..v..toto(t, s, it, k)
-- 		end
-- 	-- end
-- 	return s
-- end

-- debug( toto(test.expression) )

local types = {
	'boolean',
	'number',
	'string',
	'function',
	'nil',
	'table'
}

function anything()
	print('anything')
end

function only_one_number()
	print('only_one_number')
end

function number_string()
	print('number_string')
end

local definitions = {
	['_'] = anything,
	['number'] = only_one_number,
	['number, string'] = number_string
}

function definitions_resolve(def_table, ...)
	local s = ''

	for i,v in ipairs({...}) do
		s = s..type(v)
		if ({...})[i + 1] then s = s..', ' end
	end

	if def_table[s] then def_table[s]()
	else def_table['_']() end

end

function called(...)
	definitions_resolve(definitions, ...)
end

called(42)
called('42')
called('42', 42)
called(42, 42)
called(42, '42')
