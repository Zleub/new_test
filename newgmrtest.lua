-- @Author: Zleub
-- @Date:   2016-03-14 13:22:02
-- @Last Modified by:   Zleub
-- @Last Modified time: 2016-03-14 17:41:11

local inspect = require 'exts.inspect'
local function debug(...) print(inspect(...)) end

local BNF = {}

BNF.CharactersPrecedence = {
	'repetition-symbol',
	'except-symbol',
	'concatenate-symbol',
	'definition-separator-symbol',
	'defining-symbol',
	'terminator-symbol'
}

BNF.Characters = {
	['repetition-symbol'] 			= '*',
	['except-symbol'] 				= '-',
	['concatenate-symbol'] 			= ',',
	['definition-separator-symbol']	= '|',
	['defining-symbol']				= '=',
	['terminator-symbol']			= ';'
}

BNF.BracketsPrecedence = {
	'first-quote-symbol',
	'first-quote-symbol',
	'second-quote-symbol',
	'second-quote-symbol',
	'start-comment-symbol',
	'end-comment-symbol',
	'start-group-symbol',
	'end-group-symbol',
	'start-option-symbol',
	'end-option-symbol',
	'start-repeat-symbol',
	'end-repeat-symbol',
	'special-sequence-symbol',
	'special-sequence-symbol'
}

BNF.Brackets = {
	['first-quote-symbol']			= "'",
	['first-quote-symbol']			= "'",
	['second-quote-symbol']			= '"',
	['second-quote-symbol']			= '"',
	['start-comment-symbol']		= '(*',
	['end-comment-symbol']			= '*)',
	['start-group-symbol']			= '(',
	['end-group-symbol']			= ')',
	['start-option-symbol']			= '[',
	['end-option-symbol']			= ']',
	['start-repeat-symbol']			= '{',
	['end-repeat-symbol']			= '}',
	['special-sequence-symbol']		= '?',
	['special-sequence-symbol']		= '?'
}

function BNF.escape(str)
	return str:gsub('(['..("%^$().[]*+-?"):gsub("(.)", "%%%1")..'])', "%%%1")
end

function BNF.split(line, sep)
	local sep = BNF.escape(sep)
	return line:match('(.+)'..sep..'(.+)')
end

function BNF.truncate(line)
	return line:match('^%s*(.-)%s*$')
end

function BNF.matchBrackets(index, mixed)
	local first, last = BNF.BracketsPrecedence[index], BNF.BracketsPrecedence[index + 1]
	print('----')
	print(first, last)
	print('----')

	local f = BNF.escape( BNF.Brackets[first] )
	local l = BNF.escape( BNF.Brackets[last] )

	for i,v in ipairs(mixed) do
		print(i, v)
		if type(v) == 'string' then

			local bool = false
			for before, match in v:gmatch( '(.-)'..f..'(.-)'..l ) do
				bool = true
				print(' --> '..before..' -- '..match)
				table.insert(mixed, BNF.matchBrackets(index + 2, before) )
				table.insert(mixed, { match })
			end

			if bool then table.remove(mixed, i) end
			table.insert(mixed, BNF.matchBrackets(index + 2, mixed) )
		end
	end

	return mixed
end

function BNF.fromFile(file)
	local f = io.input(file)
	local rules = {}

	local line = ''
	for l in f:lines() do
		line = line..' '..l
	end

	local mixed = { line }

	mixed = BNF.matchBrackets(1, mixed)
	debug('mixed', mixed)

	return rules
end

for i,v in ipairs(arg) do
	print('------------')
	print(v)
	debug( BNF.fromFile(v) )
end
