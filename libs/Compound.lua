--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Compound
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 00:55:46
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 22:27:17
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

----
-- name: Compound
-- namespace:
-- description: A Compound is a Drawable made from others Drawables.
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Compound", "Drawable"
-- examples: "Compound:create('file', {})", "Compound:create({}, w, h)"

----
-- name: Description
-- namespace: Compound
-- description: A Compound Description
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Compound"
-- examples:

local Compound = Drawable:expand()

Compound.name = 'Compound'

----
-- name: create_from_filename
-- namespace: Compound
-- description: This function create a Drawable from a filename and an arbitrary description
-- extendedDescription:
-- arguments: "filename", "description"
-- returns:
-- tags: "v0.0", "Compound", "Description"
-- examples:

function Compound:create_from_filename(filename, desc)
	local _w, _h = Dictionnary[filename].screen.width, Dictionnary[filename].screen.height
	local canvas = love.graphics.newCanvas(desc.width * _w, desc.height * _h)

	love.graphics.setCanvas(canvas)
	for i = 0, desc.height - 1 do
		for j = 0, desc.width - 1 do
			Dictionnary[filename][desc[i + 1][j + 1]]:draw(j * _w, i * _h, 1)
		end
	end
	love.graphics.setCanvas()

	local c = Drawable.create(self, love.graphics.newImage(canvas:newImageData()))
	c.scale = _w * desc.width / c.image:getWidth()

	return c
end

----
-- name: create_from_size
-- namespace: Compound
-- description: This function create a Drawable given a description and some size
-- extendedDescription:
-- arguments: "description", "width", "height"
-- returns:
-- tags: "v0.0", "Compound", "Description"
-- examples:

function Compound:create_from_size(desc, width, height)
	local d = Dictionnary[desc.image]

	local _w = width / d.screen.width
	local _h = height / d.screen.height
	local c = love.graphics.newCanvas(width, height)

	love.graphics.setCanvas(c)
	for i=1, _w - 1 do
		for j=1, _h - 1 do
			d[desc.body]:draw(i * d.screen.width, j * d.screen.height)
		end
	end
	for i=1, _w - 1 do
		d[desc.bu]:draw(i * d.screen.width, 0)
		d[desc.bd]:draw(i * d.screen.width, height - d.screen.height)
	end
	for i=1, _h - 1 do
		d[desc.bl]:draw(0, i * d.screen.height)
		d[desc.br]:draw(width - d.screen.width, i * d.screen.height)

	end
	d[desc.ul]:draw()
	d[desc.ur]:draw(width - d.screen.width)
	d[desc.dl]:draw(0, height - d.screen.height)
	d[desc.dr]:draw(width - d.screen.width, height - d.screen.height)
	love.graphics.setCanvas()

	local c = Drawable.create(self, love.graphics.newImage(c:newImageData()))
	c.width, c.height = width, height

	return c
end

----
-- name: create
-- namespace: Compound
-- description: Standard Selector Constructor
-- extendedDescription:
-- arguments:
-- returns:
-- tags: "v0.0", "Compound"
-- examples: "Compound:create('filename', {})", "Compound:create({}, 100, 100)"


function Compound:create(...)
	return definitions_solver(self, {
		['_'] = function (...) debug('Compound.anything', {...}) end,
		['string, table'] = Compound.create_from_filename,
		['table, number, number'] = Compound.create_from_size
	}, ...)
end

return Compound
