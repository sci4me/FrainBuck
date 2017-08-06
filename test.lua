include("src/basic.lua")
include("src/bool.lua")
include("src/math.lua")
include("src/print.lua")
include("src/array.lua")

local ADD = 1
local SUB = 2
local LEFT = 3
local RIGHT = 4
local READ = 5
local WRITE = 7
local OPEN = 8
local CLOSE = 9

local r, ip, dp, i, tmp, tmp2 = alloc(6)

set(r, 1)

local code = allocBlock(256 * 2 + 3)
local data = allocBlock(256 * 2 + 3)
ainit(code)
ainit(data)

-- fill out code
local bfcode = {
	ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD,
	ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD,
	ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD,
	ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD,
	ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD, ADD,
	ADD, WRITE, WRITE, WRITE
}
for i = 1, #bfcode do
	set(tmp, i - 1)
	set(tmp2, bfcode[i])
	aset(code, tmp, tmp2)
end

to(r)
open()
	aget(i, code, ip)
	printCell(i)

	to(r)
close()