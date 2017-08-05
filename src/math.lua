include("src/bool.lua")

function gt(r, a, b)
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

function eq(r, a, b)
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

	truthy(tmp1, b)
	bnot(r, tmp1)
	free(c, tmp1, tmp2)
	to(r)
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