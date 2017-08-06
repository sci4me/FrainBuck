include("src/basic.lua")
include("src/bool.lua")
include("src/math.lua")
include("src/print.lua")
include("src/array.lua")

local i, v = alloc(2)

local a = allocBlock(9)

ainit(a)

for j = 0, 2 do
	set(i, j)
	set(v, math.pow(2, j + 1))
	aset(a, i, v)
end

for j = 2, 0, -1 do
	set(i, j)
	aget(v, a, i)
	printCell(v)
end