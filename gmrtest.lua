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

separators = {
	['|'] = 'or',
	['%s'] = 'and'
}

function split(s, symbol)
	local tmp = { type = separators[symbol]}

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

local file = arg[1] or 'gmr.bnf'

for l in io.lines(file) do
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


function and_function(t, line)
	local l = line
	for i,v in ipairs(t) do
		print('andloop:', v)
		local s = match_litteral(v, l)

		print('and result:', s)
		if not s then return end

		l = s
	end
end

function or_function(t, line)
	-- print('or function:', inspect(t))

	local l = line
	for i,v in ipairs(t) do
		print('orloop:', v, l)
		local res = match_litteral(v, l)
	end
end

local quotepattern = '(['..("%^$().[]*+-?"):gsub("(.)", "%%%1")..'])'
string.quote = function(str)
	return str:gsub(quotepattern, "%%%1")
end

function match_litteral(v, line)
	if type(v) == 'table' then
		do_table(v, line)
	elseif v:match("'.+'") == nil then
		do_rule(rules, v, line)
	else
		local value = v:match("'(.+)'")

		local value = string.quote(value)
		return line:match('^'..value..'(.+)')
		-- print('matching: '..value, line:match('^'..value..'(.+)') )
	end
end

separator_table = {
	['and'] = and_function,
	['or'] = or_function
}

function do_rule(t, i, line)
	print(i, line)
	separator_table[t[i].type](t[i], line)
end

function do_table(t, line)
	separator_table[t.type](t, line)
end

function parse(line)
	do_rule(rules, 'main', line)
end

parse('Hello World !')

