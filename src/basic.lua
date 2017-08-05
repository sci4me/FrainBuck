function set(cell, value)
	assert(allocated(cell))
	assert(value >= 0)

	to(cell)
	clear()
	inc(value)
end

function move(src, dst)
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

function copy(src, dst)
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

function swap(a, b)
	assert(allocated(a))
	assert(allocated(b))

	local tmp = alloc()

	move(a, tmp)
	move(b, a)
	move(tmp, b)

	free(tmp)
end

function if_then(cond, t)
	assert(allocated(cond))
	assert(type(t) == "function")

	to(cond)
	open()
		t()
		to(cond)
		clear()
	close()
end

function if_then_else(cond, t, f)
	assert(allocated(cond))
	assert(type(t) == "function")
	assert(type(f) == "function")

	local tmp = alloc()

	set(tmp, 1)

	to(cond)
	open()
		t()
		to(tmp)
		dec()
		to(cond)
		clear()
	close()
	to(tmp)
	open()
		f()
		to(tmp)
		dec()
	close()
end