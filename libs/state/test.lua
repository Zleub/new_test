-- @Author: adebray
-- @Date:   2016-05-14 16:38:54
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-19 19:41:03

return {

	before = function (self)
		print(Dictionnary['UI']:getDimensions())
		Loader.Image:load('compound_test', {
			screen = {
				width = 32,
				height = 32
			},
			image = 'UI.imagelist',
			width = love.graphics.getWidth() / 4,
			height = love.graphics.getHeight() / 4,
			ul = 26, ur = 28, dl = 76, dr = 78,
			bl = 51, br = 53, bu = 27, bd = 77,
			body = 52
		})
	end,

	update = function (self, dt)
	end,

	draw = function (self)
		love.graphics.print('test')

		function _(image, x, y) love.graphics.draw(image, x or 0, y or 0, 0, 4, 4) return _ end

		_(Dictionnary['Untitled_master'])
		_(Dictionnary['Untitled_master.imagelist'][1], 200)

		love.graphics.draw(Dictionnary['compound_test'], 200, 200, 0)
	end
}
