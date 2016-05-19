-- @Author: adebray
-- @Date:   2016-05-14 17:04:51
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-19 19:41:26

local Image = {}

Image.QuadList = Description.mandatoryAPI {
	grid = {
		width = 'number',
		height = 'number'
	}
}

Image.Compound = Description.mandatoryAPI {
	image = 'string',
	width = 'number',
	height = 'number',

	ul = 'number',
	ur = 'number',
	dl = 'number',
	dr = 'number',
	bl = 'number',
	br = 'number',
	bu = 'number',
	bd = 'number',
	body = 'number'
}

function Image:fromDescription(key, description)
	err, msg = Image.Compound(description)
	if err then
		-- print(image[1]:getDimensions())
		Dictionnary(key, Compound:create(description, description.screen.width, description.screen.height))
	else
		print(msg)
	end
end

function Image:fromImage(key, image, description)
	local err, msg = Image.QuadList(description)
	if err then
		Dictionnary(key..'.quadlist', QuadList.create(description, image))
		Dictionnary(key..'.imagelist', QuadList.toImage(description, Dictionnary[key..'.quadlist']))
	end

	if not err and description.exports then
		Dictionnary(key, image)

		for k,v in pairs(description.exports) do
			v.image = key..'.imagelist'
			local e, m = Image.Compound(v)

			if not e then print(k, m)
			else
				Dictionnary(k, Compound:create(v, description.screen.width, description.screen.height))
			end
		end

		return
	end

	Dictionnary(key, image)
end

function Image:toDictionnary(key, image)
	Dictionnary(key, image)
end

function Image:load(...)
	-- print('Image.load', ...)
	return definitions_solver(self, {
		['_'] = function (...) debug('Image.anything', {...}) end,
		['string, Image'] = Image.toDictionnary,
		['string, Image, table'] = Image.fromImage,
		['string, table'] = Image.fromDescription
		-- ['string'] = Image
	}, ...)
end

return Image
