--          `--::-.`
--      ./shddddddddhs+.
--    :yddddddddddddddddy:
--  `sdddddddddddddddddddds`
--  ydddh+sdddddddddy+ydddds  new_test:Collection
-- /ddddy:oddddddddds:sddddd/ By adebray - adebray
-- sdddddddddddddddddddddddds
-- sdddddddddddddddddddddddds Created: 2016-02-14 20:43:39
-- :ddddddddddhyyddddddddddd: Modified: 2016-02-14 22:24:49
--  odddddddd/`:-`sdddddddds
--   +ddddddh`+dh +dddddddo
--    -sdddddh///sdddddds-
--      .+ydddddddddhs/.
--          .-::::-`

local Collection = Class:expand()

function Collection:create(typestr)
	local t = Class.create(self)
	t.name = typestr

	return t
end

function Collection:add(elem)
	local err = ''

	if type(elem) == 'table' then
		for t in elem:type_iter() do

			if err ~= '' then err = err..', ' end

			if t == self:type() then
				return table.insert(self, elem)
			end

			err = err..t
		end

		print('Collection type error', self:type(), err)
	elseif type(elem) == self:type() then
		table.insert(self, elem)
	else
		print('Collection type error', self:type(), type(elem))
	end
end

function Collection:iter(f)
	for i,v in ipairs(self) do
		f(i, v)
	end
end

return Collection
