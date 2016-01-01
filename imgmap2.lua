return function ()
	if nbr2 * (1 / 16) > nbr * (15 / 16) then return  Color:extract('white', nbr * nbr2) end
	if nbr2 * (4 / 16) > nbr * (12 / 16) then return  Color:extract('brown', 1 - (nbr * nbr2)) end
	if nbr2 * (8 / 16) > nbr * (8 / 16) then return  Color:extract('green', 1 - (nbr * nbr2)) end
	if nbr2 * (12 / 16) > nbr * (4 / 16) then return  Color:extract('yellow', 1 - (nbr * nbr2)) end

	return Color:extract('blue', (nbr * nbr2))
end
