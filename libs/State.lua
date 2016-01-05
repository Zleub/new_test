--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  TEST:State
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-01-03 13:17:11
-- :ddddddddddhyyddddddddddd: Modified: 2016-01-03 19:48:19
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Loader = require 'libs.Loader'

local State = {}
State.once_t = {}
setmetatable(State, {
	__call = function (self, state)
		if self.current and self[self.current].after then
			self[self.current]:after() end
		self.current = state

		if not self.once_t[self.current] and self[self.current].once then
			self.once_t[self.current] = true
			self[self.current]:once()
		end

		if self[self.current].before then
			self[self.current]:before() end
	end
})

function State:update(dt)
	State[self.current]:update(dt)
end

function State:draw()
	State[self.current]:draw()
end

function State:wheelmoved(x, y)
	if State[self.current].wheelmoved then
		State[self.current]:wheelmoved(x, y)
	end
end

State.Loading = {
	update = function (self, dt)
		local elem = Loader:load()

		if elem then self.text = elem
		else State('Test') end
	end,
	draw = function (self)
		love.graphics.print(State.current)
		love.graphics.print(self.text, 0, 15)
	end
}

-- function std_scrollbar

State.Test = {
	once = function (self)
		self.text = 'toto'
		self.time = 0

		self.button = UI.Button(600, 0, 200, 100, {
			extensions = {Theme.Button}
		})
		-- self.frame = UI.Frame(0, 0, 250, 400, {
		-- 	extensions = {Theme.Frame},
		-- 	draggable = true,
		-- 	drag_margin = 10
		-- })
		self.scrollbar =  --[[self.frame:addElement(]]UI.Scrollarea(0, 10, 200, 4000, {
			extensions = {Theme.Scrollarea},
			area_width = 200,
			area_height = 400 - 10,
			show_scrollbars = true,
			dynamic_scroll_set = true,
		})

		local i, j = 0, 0
		for index,v in ipairs(Dictionnary['hyptosis_tile-art-batch-1']) do
			self.scrollbar:addElement(UI.Frame(0 + i, 0 + j, 48, 48, {extensions = {Theme.Frame,
				{
					draw = function (self) love.graphics.setColor(255, 255, 255, 255)
						v:draw(self.x, self.y, 1.5)
					end
				}
			}}))
			i = i + 64
			if i + 64 > 200 then
				i = 0
				j = j + 64
			end
		end
		-- local i, j = 0, 0
		for index,v in ipairs(Dictionnary['hyptosis_tile-art-batch-2']) do
			self.scrollbar:addElement(UI.Frame(0 + i, 0 + j, 48, 48, {extensions = {Theme.Frame,
				{
					draw = function (self) love.graphics.setColor(255, 255, 255, 255)
						v:draw(self.x, self.y, 1.5)
					end
				}
			}}))
			i = i + 64
			if i + 64 > 200 then
				i = 0
				j = j + 64
			end
		end
	end,
	update = function (self, dt)
		self.time = self.time + dt
		self.button:update(dt)
		self.scrollbar:update(dt)
		-- self.frame:update(dt)
		-- print(self.scrollbar.pressed, self.scrollbar.released)
		if self.button.pressed == true then
			State('Other')
		end
	end,
	draw = function (self)
		self.scrollbar:draw()
		-- self.frame:draw()
		self.button:draw()
		love.graphics.print(self.time, 0, love.graphics.getHeight() - 15)
	end,
	wheelmoved = function (self, x, y)
		-- if self.scrollbar.hot then
		-- print(x, y)
			self.scrollbar.vertical_scrolling = true
			if y > 0 then
				self.scrollbar:scrollDown(self.scrollbar.vertical_step)
			else
				self.scrollbar:scrollUp(self.scrollbar.vertical_step)
			end
		-- end
	end
}

State.Other = {
	once = function (self)
		self.time = 0
		self.button = UI.Button(600, 0, 200, 100, {
			extensions = {Theme.Button},
		})
	end,
	update = function (self, dt)
		self.time = self.time + dt
		self.button:update(dt)
		if self.button.pressed == true then
			State('Test')
		end
	end,
	draw = function (self)
		self.button:draw()
		love.graphics.print(self.time)
	end
}

return State
