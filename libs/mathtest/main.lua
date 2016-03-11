-- inspect = require 'exts.inspect'

-- Class = require 'libs.Class'
-- require 'libs.Lib'

math.randomseed( os.time() )

-- function Range(min, max)
-- 	local value = max
-- 	return function (v)
-- 		if not v then return value / max
-- 		elseif min < v and v < max then value = v
-- 		else print('exception') end
-- 	end
-- end

-- function Function(...)
-- 	local args = {...}

-- 	return function ()
-- 		return table.unpack( args )
-- 	end
-- end

-- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- -- --

require 'Table'
NMatrix = require 'NMatrix'

for i=1,10 do
	local m = NMatrix(math.random(1, 5), math.random(1, 5), math.random(1, 5), math.random(1, 5))
	local n = NMatrix(math.random(1, 5), math.random(1, 5), math.random(1, 5), math.random(1, 5))
	local k = m:sub(n)

	print( m, n, k )

	print('A', table.fold_left(k, function (t, i, v) return v + t[i] end, 0 ) )
	print('B', table.fold_left(k, function (t, i, v) return v + t[i] + t[i] ^ 2 end, 0 ) )

	print('')

end

function love.load()
end

function love.update() end

function love.draw() end
