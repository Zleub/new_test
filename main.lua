--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:main
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2015-12-19 23:19:42
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-16 17:33:22
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

inspect = require 'exts.inspect'

require 'libs.Lib'

require_list(
	'libs.Class',

	'libs.Dictionnary',
	'libs.Drawable',
	'libs.Draggable',
	'libs.Compound',
	'libs.EventDispatcher',
	'libs.CanvasBatch',
	'libs.Clickable',
	'libs.Modulable',

	'libs.Color',
	'libs.UI',
	'libs.Loader',
	'libs.State'
)

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

	State.previous = 'Test'
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

