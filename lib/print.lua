include("lib/math.lua")

function printCell(a)
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

	copy(tmp2, a) 
	divmod(digit, remainder, tmp2, divisor)
	copy(tmp3, digit) 
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
	copy(tmp2, remainder) 
	divmod(digit, remainder, tmp2, divisor)
	copy(tmp3, digit) 
	bor(tmp6, tmp3, tmp5)
	open()
		copy(tmp3, digit) 
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

	to(a)
end