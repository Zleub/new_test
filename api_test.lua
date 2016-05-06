-- @Author: adebray
-- @Date:   2016-05-03 16:22:16
-- @Last Modified by:   Zleub
-- @Last Modified time: 2016-05-03 23:51:39

Color = require 'libs.Color'
Description = require 'libs.Description'


QuadDescription = Description {
	screen = {
		width = 'number',
		height = 'number'
	}
}

print( QuadDescription {
	width = 42,
	height = 42
} )

print( QuadDescription {
	screen = {
		width = 42,
		height = 42
	}
})
