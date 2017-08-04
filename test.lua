include("src/basic.lua")
include("src/bool.lua")
include("src/math.lua")
include("src/print.lua")

local a, b = alloc(2)

set(a, 1)
set(b, 1)

local i = alloc()

local tmp1, tmp2, n = alloc(3)

printCell(a)
printCell(b)

set(i, 11)
open()
	copy(a, tmp1)
	copy(b, tmp2)
	open()
		dec()
		to(tmp1)
		inc()
		to(tmp2)
	close()	

	copy(tmp1, n)
	printCell(n)

	move(b, a)
	move(tmp1, b)
	
	to(i)
	dec()
close()