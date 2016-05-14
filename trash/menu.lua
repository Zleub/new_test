local Menu = {}

local width = love.graphics.getWidth()
local height = love.graphics.getHeight()

function Menu:once()
	local container = UI.Container:create({
		image = 'UI',
		ul = 26, ur = 28, dl = 76, dr = 78,
		bl = 51, br = 53, bu = 27, bd = 77,
		body = 52
	}, width / 2, height / 2)
	container.x = width / 4
	container.y = height / 4

	container:push( Compound:create('UI', {
		width = 3,
		height = 1,
		{ 13, 14, 15 }
	}) )

	container:push( Compound:create('UI', {
		width = 5,
		height = 1,
		{ 13, 14,14,14, 15 }
	}) )

	container:push( Compound:create('UI', {
		width = 3,
		height = 1,
		{ 13, 14, 15 }
	}) )

	self.EventDispatch = EventDispatcher:create()
	self.EventDispatch:add( container )
end

function Menu:update(dt) self.EventDispatch.update:dispatch(dt) end
function Menu:draw() self.EventDispatch.draw:dispatch() end

function Menu:keypressed(key)
	if key == 'a' then self.time = 1 end

	if key == 'q' then self.mousewheel = self.mousewheel + 1 end
	if key == 's' then self.mousewheel = self.mousewheel - 1 end
end

function Menu:wheelmoved(x, y)
		-- self.mousewheel = self.mousewheel + y
		-- if self.mousewheel < 1 then self.mousewheel = 1 end
	end

function Menu:mousepressed(x, y, button)
	self.EventDispatch.mousepressed:dispatch(x, y, button)
end

return Menu
