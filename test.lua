include("src/basic.lua")
include("src/bool.lua")
include("src/math.lua")

local function printCell(a)
	assert(allocated(a))

	local tmp1, tmp2, tmp3, divisor, digit, remainder, tmp5, tmp6 = alloc(8)

	to(tmp1)
	inc(10)
	open()
		dec()
		to(divisor)
		inc(10)
		to(tmp1)
	close()

	copy(a, tmp2)
	divmod(digit, remainder, tmp2, divisor)
	copy(digit, tmp3)
	open()
		to(tmp5)
		inc()
		to(tmp3)
		inc(48)
		write()		
		clear()
	close()

	to(divisor)
	clear()
	inc(10)
	copy(remainder, tmp2)
	divmod(digit, remainder, tmp2, divisor)
	copy(digit, tmp3)
	bor(tmp6, tmp3, tmp5)
	open()
		copy(digit, tmp3)
		inc(48)
		write()
		clear()
		to(tmp6)
		clear()
	close()

	to(remainder)
	inc(48)
	write()

	to(divisor)
	write()

	free(tmp1, tmp2, tmp3, divisor, digit, remainder, tmp5, tmp6)
end

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