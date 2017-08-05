include("src/bool.lua")

function eq(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		copy(a, tmp1)
		copy(b, tmp2)
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

	truthy(tmp1, b)
	bnot(r, tmp1)

	free(c, tmp1, tmp2)
end

function ne(r, a, b)
	eq(r, a, b)
	copy(r, a)
	bnot(r, a)	
end

function lt(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		copy(a, tmp1)
		copy(b, tmp2)
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

	truthy(r, b)

	free(c, tmp1, tmp2)
end

function gt(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		copy(a, tmp1)
		copy(b, tmp2)
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

	free(c, tmp1, tmp2)
end

function lte(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local ta, tb = alloc(2)
	local g, e = alloc(2)

	copy(a, ta)
	copy(b, tb)
	lt(g, ta, tb)

	copy(a, ta)
	copy(b, tb)
	eq(e, ta, tb)

	bor(r, g, e)

	free(ta, tb, g, e)
end

function gte(r, a, b)
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

function divmod(quotient, remainder, a, b)
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