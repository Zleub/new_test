local Class = {}

Class.dictionnary = {}

Class.mandatoryAPI = Description.mandatoryAPI {
	strength = 'number',
	intelligence = 'number',
	dexterity = 'number'
}

function Class:load(path, filename, configname)
	local key = filename
	local value =  dofile(path..(configname or filename)..'.lua')

	local err, msg = Class.mandatoryAPI(value)
	if not err then return print(msg..' in '..Color.shell(filename, 'red')) end

	if Class.dictionnary[key] then
		print(Color.shell('Erasing', 'orange')..' Class['..key..']')
	else
		print('Class '..':\t'..Color.shell(key, 'green'))
	end

	Class.dictionnary[key] = value
end

return Class
