--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Shader_Rectangle
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 03:29:10
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-11 03:31:21
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Shader_Rectangle = Draggable:expand()

function Shader_Rectangle:create(screen_size, filename)
	local s = Draggable.create(self)

	s.filename = filename
	s.shader = love.graphics.newShader(s.filename)

	s.width = screen_size.width
	s.height = screen_size.height
	s.x, s.y = 0, 0

	return s
end

function Shader_Rectangle:update(dt, resolution, test)
	Draggable.update(self, dt)

	self.shader = love.graphics.newShader(self.filename)
	self.shader:send("width", self.width)
	self.shader:send("height", self.height)
	self.shader:send("resolution", resolution)
	self.shader:send("test", test)
	self.shader:send("x", self.x)
	self.shader:send("y", self.y)
end

function Shader_Rectangle:draw(x, y, scale)
	love.graphics.setShader(self.shader)
	love.graphics.rectangle('fill', self.x, self.y, self.width, self.height)
	love.graphics.setShader()
end

return Shader_Rectangle
