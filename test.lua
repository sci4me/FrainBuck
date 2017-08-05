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
	copy(tmp1, a) 
	copy(tmp2, b) 
	open()
		to(tmp1)
		inc()
		to(tmp2)
		dec()
	close()	

	copy(n, tmp1) 
	printCell(n)

	move(a, b) 
	move(b, tmp1) 
	
	to(i)
	dec()
close()