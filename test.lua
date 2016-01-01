local inspect = require 'libs.inspect'

local Class = require 'libs.Class'
local newClass = Class:expand()

function newClass:setX(x) self.x = x end

local newI = newClass:create()
print('newI', inspect(newI))

newI:setX(42)
print('newI', inspect(newI))

local newClass2 = newI:expand()
print('newClass2', inspect(newClass2))

newI:setX(41)
print('newI', inspect(newI))

newClass2:setX(43)
print('newClass2', inspect(newClass2))

local test = newClass2:create()
print(inspect(test))

test:setX(44)
print(test.x)
print(inspect(test))
