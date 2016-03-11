function table.fold_left(t, f, init, index)
	local init = init or 0
	local index = index or 1

	if not t[index] then return init
	else return table.fold_left(t, f, f(t, index, init), index + 1) end
end

function table.iteri(t, f)
	for i,v in ipairs(t) do
		t[i] = f(t, i, t[i])
	end
end

function table.mapi(t, f)
	local tmp = NMatrix()

	for i,v in ipairs(t) do
		tmp[i] = f(t, i, t[i])
	end

	return tmp
end
