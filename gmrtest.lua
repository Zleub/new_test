--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  None:gmrtest
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-04 00:09:43
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-09 19:38:23
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'exts.inspect'

rules = {}

function split(s, symbol)
	local tmp = { type = symbol}

	for v in s:gmatch("[^"..symbol.."]+") do
		table.insert(tmp, v)
	end

	return tmp
end

function make_split(s, pattern)
	local t = split(s, pattern)

	if #t == 1 then return t[1]
	else return t end
end

for l in io.lines('gmr.bnf') do
	for name, rule in l:gmatch("(.-)%s-:(.+)") do
		rules[name] = make_split(rule, '|')

		if type(rules[name]) == 'table' then
			for i, _ in ipairs(rules[name]) do
				rules[name][i] = make_split(rules[name][i], '%s')
			end
		else
			rules[name] = split(rules[name], '%s')
		end
	end
end

print(inspect(rules))

print(rules.binop[1]:match("'(.+)'"))
print(rules.expression[1]:match("'(.+)'"))
