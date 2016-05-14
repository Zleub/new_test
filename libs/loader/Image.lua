-- @Author: adebray
-- @Date:   2016-05-14 17:04:51
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-14 17:17:01

local Image = {}

function Image:toDictionnary(key, image)
	Dictionnary(key, image)
end

function Image:load(...)
	print('Image.load', ...)
	return definitions_solver(self, {
		['_'] = function (...) debug('Image.anything', {...}) end,
		['string, Image'] = Image.toDictionnary,
		-- ['string'] = Image
	}, ...)
end

return Image
