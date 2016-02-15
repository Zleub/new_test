--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Shader
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-11 02:06:58
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-15 00:04:34
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Shader = Draggable:expand()

function Shader:create(drawable, filename)
	local s = Draggable.create(self)

	s.drawable = drawable
	s.filename = filename
	s.shader = love.graphics.newShader(s.filename)

	s.width, s.height = s.drawable:getSize()
	s.x, s.y = s.drawable.x, s.drawable.y

	return s
end

function Shader:update(dt, resolution, test)
	Draggable.update(self, dt)

	-- self.shader = love.graphics.newShader(self.filename)
	self.drawable.x, self.drawable.y = self.x, self.y
	self.shader:send("width", self.width)
	self.shader:send("height", self.height)
	self.shader:send("resolution", resolution)
	self.shader:send("test", test)
	self.shader:send("x", self.x)
	self.shader:send("y", self.y)
end

function Shader:draw(x, y, scale)
	love.graphics.setShader(self.shader)
	self.drawable:draw(x, y, scale)
	love.graphics.setShader()
end

return Shader
