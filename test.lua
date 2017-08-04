local function set(cell, value)
	assert(allocated(cell))
	assert(value >= 0)

	to(cell)
	clear()
	inc(value)
end

local function move(src, dst)
	assert(allocated(src))
	assert(allocated(dst))

	to(dst)
	clear()
	to(src)
	open()
		dec()
		to(dst)
		inc()
		to(src)
	close()
end

local function copy(src, dst)
	assert(allocated(src))
	assert(allocated(dst))

	local tmp = alloc()

	to(dst)
	clear()
	to(src)
	open()
		dec()
		to(dst)
		inc()
		to(tmp)
		inc()
		to(src)
	close()

	move(tmp, src)
	free(tmp)
	to(dst)
end

local function swap(a, b)
	assert(allocated(a))
	assert(allocated(b))

	local tmp = alloc()

	move(a, tmp)
	move(b, a)
	move(tmp, b)

	free(tmp)
end

local function truthy(r, a)
	assert(allocated(r))
	assert(allocated(a))

	to(r)
	clear()
	to(a)	
	open()
		to(r)
		inc()
		to(a)
		clear()
	close()
	to(r)
end

local function bor(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	to(r)
	clear()
	to(a)
	open()
		to(b)
		inc()
		to(a)
		clear()
	close()
	truthy(r, b)
end

local function band(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	to(r)
	clear()
	to(a)
	open()
		to(b)
		open()
			to(r)
			inc()
			to(b)
			clear()
		close()
		to(a)
		clear()
	close()
	to(r)
end

local function bnot(a)
	assert(allocated(a))

	local tmp = alloc()

	to(a)
	open()
		to(tmp)
		inc()
		to(a)
		clear()
	close()
	inc()
	to(tmp)
	open()
		to(a)
		dec()
		to(tmp)
		dec()
	close()
	free(tmp)
	to(a)
end

local function gt(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		local tmp3, tmp4 = alloc(2)
		copy(a, tmp3)
		copy(b, tmp4)

		truthy(tmp1, tmp3)
		truthy(tmp2, tmp4)

		free(tmp3, tmp4)

		band(c, tmp1, tmp2)
	end

	cond()
	open()
		to(a)
		dec()
		to(b)
		dec()
		cond()
	close()

	truthy(r, a)

	free(tmp1, tmp2)
end

local function eq(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		local tmp3, tmp4 = alloc(2)
		copy(a, tmp3)
		copy(b, tmp4)

		truthy(tmp1, tmp3)
		truthy(tmp2, tmp4)

		free(tmp3, tmp4)

		band(c, tmp1, tmp2)
	end

	cond()
	open()
		to(a)
		dec()
		to(b)
		dec()
		cond()
	close()

	to(a)
	open()
		to(b)
		inc()
		to(a)
		clear()
	close()

	truthy(r, b)
	bnot(r)
	free(c, tmp1, tmp2)
	to(r)
end

local function gte(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local ta, tb = alloc(2)
	local g, e = alloc(2)

	copy(a, ta)
	copy(b, tb)
	gt(g, ta, tb)

	copy(a, ta)
	copy(b, tb)
	eq(e, ta, tb)

	bor(r, g, e)

	free(ta, tb, g, e)
end

local function divmod(quotient, remainder, a, b)
	assert(allocated(quotient))
	assert(allocated(remainder))
	assert(allocated(a))
	assert(allocated(b))

	local tmp1, tmp2, tmp3 = alloc(3)

	local function cond()
		copy(a, tmp1)
		copy(b, tmp2)
		gte(tmp3, tmp1, tmp2)
	end

	to(quotient)
	clear()
	to(remainder)
	clear()

	cond()
	open()
		copy(b, tmp1)
		open()
			dec()
			to(a)
			dec()
			to(tmp1)
		close()

		to(quotient)
		inc()

		cond()
	close()

	to(a)
	open()
		dec()
		to(remainder)
		inc()
		to(a)
	close()

	free(tmp1, tmp2, tmp3)

	to(quotient)
end

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

local n = 8
local a = allocBlock(n)

for i = 1, n do
	to(a.start + i - 1)
	inc(i)
end

freeBlock(a)

--[[
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
]]