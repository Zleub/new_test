local inspect = require 'exts.inspect'

require 'gmrtest'

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

function iter(t)
	local i = 1
	return function (b)
		local v = t[i]
		if not b then
			i = i + 1
		end
		return v
	end
end

function makeiter(t)
	local reg = {}

	for i,v in ipairs(t) do
		if rules[v] then
			reg[i] = iter(rules[v])
		end
	end

	for i,v in ipairs(reg) do
		io.write(v())
	end

	print(inspect(reg[#reg]()))
	print(inspect(reg[#reg]()))
	print(inspect(reg[#reg]()))
end

makeiter(rules.expression)
