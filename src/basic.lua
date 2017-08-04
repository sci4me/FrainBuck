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