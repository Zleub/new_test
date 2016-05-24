local Compound = {}

function Compound:create(desc, width, height)
	local d = Dictionnary[desc.image]

	local _w = desc.width / width
	local _h = desc.height / height
	local c = love.graphics.newCanvas(desc.width, desc.height)

	love.graphics.setCanvas(c)
	for i=1, _w - 1 do
		for j=1, _h - 1 do
			love.graphics.draw(d[desc.body], i * width, j * height)
		end
	end
	for i=1, _w - 1 do
		love.graphics.draw(d[desc.bu], i * width, 0)
		love.graphics.draw(d[desc.bd], i * width, desc.height - height)
	end
	for i=1, _h - 1 do
		love.graphics.draw(d[desc.bl], 0, i * height)
		love.graphics.draw(d[desc.br], desc.width - width, i * height)
	end

	function _(image, x, y)
		love.graphics.setScissor(x or 0, y or 0, image:getDimensions())
		love.graphics.clear()
		love.graphics.setScissor()
		love.graphics.draw(image, x, y)
	end

	_(d[desc.ul])
	_(d[desc.ur], desc.width - width)
	_(d[desc.dl], 0, desc.height - height)
	_(d[desc.dr], desc.width - width, desc.height - height)
	love.graphics.setCanvas()

	return love.graphics.newImage(c:newImageData())
end

return Compound
