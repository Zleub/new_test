local function _w() return love.graphics.getWidth() end
local function _h() return love.graphics.getHeight() end

local function mergeDescription(src)
	return function (ext)
		if not ext then return src end
		for k,v in pairs(ext) do src[k] = v end
		return mergeDescription(src)
	end
end

local CC = {}

local white_block = {
	image = 'UI.imagelist',
	screen = {
		width = 32,
		height = 32
	},
	ul = 26 + 4 * 25, ur = 28 + 4 * 25, dl = 76 + 4 * 25, dr = 78 + 4 * 25,
	bl = 51 + 4 * 25, br = 53 + 4 * 25, bu = 27 + 4 * 25, bd = 77 + 4 * 25,
	body = 52 + 4 * 25
}

CC.once = function (self)
	self.ED = EventDispatcher:create()

	Loader.Image:load('compound_white', mergeDescription(white_block)({
		width = _w() / 2,
		height = _h() / 2
	})())

	self.ED:add({
		draw = function ()
			love.graphics.draw(
				Dictionnary['compound_white'],
				_w() / 4,
				_h() / 4
			)
		end
	})
end
CC.update = function (self)

end

CC.draw = function (self)
	self.ED.draw:dispatch()
end

return CC

