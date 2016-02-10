--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 00:52:30
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'exts.inspect'

function clamp(num, min, max)
	if num < min then return min
	elseif num > max then return max
	else return num end
end

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

function print_require_list(...)
	for k,v in ipairs({...}) do
		local name = v:match('.+%.(%w+)')

		_G[name] = require(v)
		print(name..' required:', inspect( _G[name], {depth = 1} ) )
	end
end

function require_list(...)
	for k,v in ipairs({...}) do
		local name = v:match('.+%.(%w+)')

		_G[name] = require(v)
	end
end

Dictionnary = {}

require_list(
	'libs.Class',
	'libs.Drawable',
	'libs.Draggable',

	'libs.Color',
	'libs.UI',
	'libs.Loader',
	'libs.State'
)

local scale = 4

function love.wheelmoved(x, y)
	State:wheelmoved(x, y)
end

function love.keypressed(key)
	State:keypressed(key)
end

function love.load()
	debug(_VERSION)
	Loader:push( Loader.Asset.load, 'pict', 'png' )
	Loader:push( Loader.Asset.load, 'hyptosis_tile-art-batch-1', 'png' )
	-- Loader:push( Loader.Asset.Load, 'hyptosis_tile-art-batch-2', 'png' )
	Loader:push( Loader.Asset.load, 'Untitled_master', 'png' )
	Loader:push( Loader.Asset.load, 'UI', 'png' )
	-- Loader:push( Loader.Asset.Load, 'hyptosis_tile-art-batch-3', 'png' )
	-- Loader:push( Loader.Asset.Load, 'hyptosis_tile-art-batch-4', 'png' )
	-- Loader:push( Loader.Asset.Load, 'hyptosis_tile-art-batch-5', 'png' )

	State('Loading')
end

function love.update(dt)
	State:update(dt)
end

function love.draw()
	State:draw()
end

