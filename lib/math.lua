include("lib/bool.lua")

function eq(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		copy(tmp1, a) 
		copy(tmp2, b) 
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
	copy(a, r) 
	bnot(r, a)	
end

function lt(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	local c, tmp1, tmp2 = alloc(3)

	local function cond()
		copy(tmp1, a) 
		copy(tmp2, b) 
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
		copy(tmp1, a) 
		copy(tmp2, b) 
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

	copy(ta, a) 
	copy(tb, b) 
	lt(g, ta, tb)

	copy(ta, a) 
	copy(tb, b) 
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

	copy(ta, a) 
	copy(tb, b) 
	gt(g, ta, tb)

	copy(ta, a)  
	copy(tb, b)  
	eq(e, ta, tb)

	bor(r, g, e)

	free(ta, tb, g, e)
end

function add(r, a)
	assert(allocated(r))
	assert(allocated(a))

	local tmp = alloc()

	copy(tmp, a) 
	open()
		to(r)
		inc()
		to(tmp)
		dec()
	close()
	to(r)
end

function sub(r, a)
	assert(allocated(r))
	assert(allocated(a))

	local tmp = alloc()

	copy(tmp, a) 
	open()
		to(r)
		dec()
		to(tmp)
		dec()
	close()
	to(r)
end

function mul(r, a, b)
	local tmp1, tmp2 = alloc(2)

	copy(tmp1, a) 
	to(a)
	clear()
	to(tmp1)
	open()
		copy(tmp2, b) 
		open()
			to(a)
			inc()
			to(tmp2)
			dec()
		close()
		to(tmp1)
		dec()
	close()
	move(r, a) 

	free(tmp1, tmp2)
end

function divmod(quotient, remainder, a, b)
	assert(allocated(quotient))
	assert(allocated(remainder))
	assert(allocated(a))
	assert(allocated(b))

	local tmp1, tmp2, tmp3 = alloc(3)

	local function cond()
		copy(tmp1, a) 
		copy(tmp2, b) 
		gte(tmp3, tmp1, tmp2)
	end

	to(quotient)
	clear()
	to(remainder)
	clear()

	cond()
	open()
		copy(tmp1, b) 
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