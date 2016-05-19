local QuadList = {}

function QuadList.create(config, image)
	local i, j = 0, 0
	local q = { [0] = image }
	local w, h = image:getDimensions()

	while j < h do
		i = 0
		while i < w do
			table.insert(q, love.graphics.newQuad(i, j, config.grid.width + config.spacing.width, config.grid.height + config.spacing.height,
					w, h))
			i = i + config.grid.width + config.spacing.width
		end
		j = j + config.grid.height + config.spacing.height
	end

	return q
end

function QuadList.toImage(config, quadlist)
	local canvaslist = {}
	local canvas = love.graphics.newCanvas(config.grid.width, config.grid.height)

	love.graphics.setCanvas(canvas)
	for i,v in ipairs(quadlist) do
		love.graphics.clear()
		love.graphics.draw(quadlist[0], quadlist[i])

		local img = love.graphics.newImage(canvas:newImageData())
		img:setFilter( 'nearest', 'nearest')

		table.insert(canvaslist, img)
	end
	love.graphics.setCanvas()

	return canvaslist
end

return QuadList
