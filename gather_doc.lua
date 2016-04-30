local inspect = require 'exts.inspect'

-- print(inspect(arg))

local matches = {
	[0] = '%-%-%-%-',
	[1] = '%-%- (name):%s?(.*)',
	[2] = '%-%- (namespace):%s?(.*)',
	[3] = '%-%- (description):%s?(.*)',
	[4] = '%-%- (extendedDescription):%s?(.*)',
	[5] = '%-%- (arguments):%s?(.*)',
	[6] = '%-%- (returns):%s?(.*)',
	[7] = '%-%- (tags):%s?(.*)',
	[8] = '%-%- (examples):%s?(.*)',
}

io.write('[')
local count = 0
for i,v in ipairs(arg) do
	local l
	local file = io.open(v)
	repeat
		l = file:read('*l')
		if l and l:match(matches[0]) then
			local res = {}
			l = file:read('*l')
			for j,m in ipairs(matches) do
				local k,val = l:match(m)
				if k then
					res[k] = val
					l = file:read('*l')
				end
			end

			local key_table = {}
			for k,v in pairs(res) do
				table.insert(key_table, k)
			end

			local str = "{\n"
			for i,k in ipairs(key_table) do

				if k == 'arguments' or k == 'returns' or k == 'tags' or k == 'examples' then
					str = str..'"'..k..'": ['..res[k]..']'
				else
					str = str..'"'..k..'": "'..res[k]..'"'
				end

				if res[key_table[i + 1]] then
					str = str..',\n'
				else
					str = str..'\n'
				end
			end
			str = str.."}"

			if str ~= "{\n}" then
				if count >= 1 then
					print(','..str)
				else
					print(str)
				end
				count = count + 1
			end

		end
	until l == nil
	file:close()
end
io.write(']')
