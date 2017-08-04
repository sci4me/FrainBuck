local function set(cell, value)
	assert(allocated(cell))
	assert(value >= 0)
	to(cell)
	clear()
	add(value)
end

local function move(src, dst)
	to(dst)
	clear()
	to(src)
	open()
		sub()
		to(dst)
		add()
		to(src)
	close()
end

local function copy(src, dst)
	local tmp = alloc()

	to(dst)
	clear()
	to(src)
	open()
		sub()
		to(dst)
		add()
		to(tmp)
		add()
		to(src)
	close()

	to(tmp)
	open()
		sub()
		to(src)
		add()
		to(tmp)
	close()
	free(tmp)
	to(dst)
end

local function nz21(r, a)
	to(r)
	clear()
	to(a)	
	open()
		to(r)
		add()
		to(a)
		clear()
	close()
	to(r)
end

local function bor(r, a, b)
	to(a)
	open()
		to(b)
		add()
		to(a)
		clear()
	close()
	nz21(r, b)
end

local function band(r, a, b)
	to(r)
	clear()
	to(a)
	open()
		to(b)
		open()
			to(r)
			add()
			to(b)
			sub()
		close()
		to(a)
		sub()
	close()
	to(b)
	clear()
	to(r)
end

local function bnot(a)
	local tmp = alloc()

	to(a)
	open()
		to(tmp)
		add()
		to(a)
		clear()
	close()
	add()
	to(tmp)
	open()
		to(a)
		sub()
		to(tmp)
		sub()
	close()
	free(tmp)
	to(a)
end

local function gt(r, a, b)
	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		local tmp3, tmp4 = alloc(2)
		copy(a, tmp3)
		copy(b, tmp4)

		nz21(tmp1, tmp3)
		nz21(tmp2, tmp4)

		free(tmp3, tmp4)

		band(c, tmp1, tmp2)
	end

	cond()
	open()
		to(a)
		sub()
		to(b)
		sub()
		cond()
	close()

	nz21(r, a)

	free(tmp1, tmp2)
end

local function eq(r, a, b)
	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		local tmp3, tmp4 = alloc(2)
		copy(a, tmp3)
		copy(b, tmp4)

		nz21(tmp1, tmp3)
		nz21(tmp2, tmp4)

		free(tmp3, tmp4)

		band(c, tmp1, tmp2)
	end

	cond()
	open()
		to(a)
		sub()
		to(b)
		sub()
		cond()
	close()

	to(a)
	open()
		to(b)
		add()
		to(a)
		clear()
	close()

	nz21(r, b)
	bnot(r)
	free(tmp1, tmp2)
	to(r)
end

local function gte(r, a, b)
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
	local tmp1, tmp2, tmp3 = alloc(3)

	local function cond()
		copy(a, tmp1)
		copy(b, tmp2)
		gte(tmp3, tmp1, tmp2)
	end

	cond()
	open()
		copy(b, tmp1)
		open()
			sub()
			to(a)
			sub()
			to(tmp1)
		close()

		to(quotient)
		add()

		cond()
	close()

	to(a)
	open()
		sub()
		to(remainder)
		add()
		to(a)
	close()

	free(tmp1, tmp2, tmp3)

	to(quotient)
end

local a, b = alloc(2)

set(a, 36)
set(b, 5)

local q, r = alloc(2)

divmod(q, r, a, b)