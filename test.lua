local inspect = require 'exts.inspect'

function debug(...)
	if ({...})[1] == nil then print('nil') end

	for i,v in ipairs({...}) do
		io.write(inspect(v))
		if ({...})[i + 1] then io.write(', ')
		else io.write('\n') end
	end
end

local test = {
	binop = { '+', '-', '*', '/' },
	operand = { 'x', 'y' },
	expression = { 'operand', 'binop', 'operand' }
}


function toto(t, s, it, next)
	local s = s or ''

	local it = it or pairs(t)

	-- for k,v in  do
	local k, v = it(t, next)
	debug(k, v)

		if test[v] then
			s = s..toto(test[v])
		elseif k then
			return s..v..toto(t, s, it, k)
		end
	-- end
	return s
end

debug( toto(test.expression) )
