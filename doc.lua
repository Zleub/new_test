inspect = require 'exts.inspect'

function debug(...) print(inspect(...)) end

print(inspect(rules))

function parse(file)
	local f = io.input(file)

	for l in f:lines() do
		print(l)
	end
end

for i,v in ipairs(arg) do
	parse(v)
end
