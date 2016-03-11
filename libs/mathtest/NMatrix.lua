local function __index(t, i)
	return getmetatable(t)[i]
end

local NMatrix = {}
setmetatable(NMatrix, {
	__call = function (t, ...)
		local t = {}
		setmetatable(t, {
			__index = __index,
			__tostring = function (self) return table.concat(self, '  ') end,
			add = function (self, matrix)
				return table.mapi(self, function (t, i, v) return v + matrix[i] end)
			end,
			sub = function (self, matrix)
				return table.mapi(self, function (t, i, v) return v - matrix[i] end)
			end
		})

		for i,v in ipairs({...}) do
			table.insert(t, v)
		end

		return t
	end
})

return NMatrix
