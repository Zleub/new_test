-- @Author: adebray
-- @Date:   2016-05-14 16:38:54
-- @Last Modified by:   adebray
-- @Last Modified time: 2016-05-14 17:11:29

return {

	before = function (self)
	end,

	update = function (self, dt)
	end,

	draw = function (self)
		love.graphics.print('test')

		love.graphics.draw(Dictionnary['Untitled_master'], 0, 0, 0, 4, 4)
	end
}
