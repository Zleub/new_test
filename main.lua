--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-15 23:58:59
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'exts.inspect'

function definitions_solver(self, def_table, ...)
	local s = ''

	for i,v in ipairs({...}) do
		if type(v) == 'table' and v.type then s = s..v:type()
		elseif type(v) == 'userdata' then s = s..v:type()
		else s = s..type(v) end
		if ({...})[i + 1] then s = s..', ' end
	end

	if def_table[s] then
		return def_table[s](self, ...)
	else
		return def_table['_'](self, ...)
	end
end

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
		local name = v:match('.+%.([%w_]+)')

		_G[name] = require(v)
	end
end

require_list(
	'libs.Class',

	'libs.Dictionnary',
	'libs.Drawable',
	'libs.Draggable',
	'libs.Compound',
	'libs.Shader',
	'libs.Shader_Rectangle',
	'libs.EventDispatcher',
	'libs.CanvasBatch',
	'libs.Clickable',

	'libs.Color',
	'libs.UI',
	'libs.Loader',
	'libs.State'
)

local scale = 4

function love.load()
	debug(_VERSION)
	love.defaultfont = love.graphics.getFont()

	Loader:push( Loader.PNG, 'assets/', 'pict' )
	Loader:push( Loader.PNG, 'assets/', 'hyptosis_tile-art-batch-1' )
	Loader:push( Loader.PNG, 'assets/', 'hyptosis_tile-art-batch-2' )
	Loader:push( Loader.PNG, 'assets/', 'Untitled_master' )
	Loader:push( Loader.PNG, 'assets/', 'UI' )

	Loader:push( Loader.PNG, 'assets/characters/', 'warrior_m', 'character')
	Loader:push( Loader.PNG, 'assets/characters/', 'warrior_f', 'character')

	State.previous = 'Other'
	State('Loading')
end

function love.update(dt)
	State:update(dt)
end

function love.draw()
	State:draw()
end

function love.wheelmoved(x, y)
	State:wheelmoved(x, y)
end

function love.keypressed(key)
	State:keypressed(key)
end

function love.mousepressed(x, y, button)
	State:mousepressed(x, y, button)
end

