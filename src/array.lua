local function arrayAllocated(a)
	return blockAllocated(a) and a.length >= 5
end

function ainit(a)
	assert(arrayAllocated(a))

	local s = a.start
	local e = a.start + a.length - 1
	local tmp = e - 1

	for i = 1, tmp - 2 do
		if i % 2 == 0 then
			to(a.start + i)
			inc()
		end
	end

	to(a.start)
end

function aset(a, i, v)
	assert(arrayAllocated(a))
	assert(allocated(i))
	assert(allocated(v))

	local s = a.start
	local e = a.start + a.length - 1
	local tmp = e - 1

	copy(tmp, i)

	to(s + 2)
	open()
		dec()
		emit(">>")
		open()
			emit(">>")
		close(true)
		emit("<")

		open()
			dec()
			emit("<")
			open()
				emit("<<")
			close(true)
		close(true)

		inc()
		emit(">>")
	close(true)
	emit("<<")
	dec()
	at(tmp)

	copy(tmp, v)

	emit("<")
	open()
		emit("<<")
	close(true)
	emit("<[-]>>>")
	open()
		emit(">>")
	close(true)
	emit("<")

	open()
		dec()

		emit("<")		
		open()
			emit("<<")
		close(true)

		emit("<+>>>")
		open()
			emit(">>")
		close(true)
		emit("<")
	close()

	emit("<")
	open()
		emit("<<")
	close(true)
	inc()

	open()
		emit("<<")
	close(true)
	at(s)
end

function aget(r, a, i)
	assert(allocated(r))
	assert(arrayAllocated(a))
	assert(allocated(i))

	local s = a.start
	local e = a.start + a.length - 1
	local tmp = e - 1

	local tmp2 = alloc()

	to(r)
	clear()

	copy(tmp, i)

	to(s + 2)
	open()
		dec()
		emit(">>")
		open()
			emit(">>")
		close(true)
		emit("<")

		open()
			dec()
			emit("<")
			open()
				emit("<<")
			close(true)
		close(true)

		inc()
		emit(">>")
	close(true)
	emit("<<")
	dec()
	at(tmp)

	emit("<")
	open()
		emit("<<")
	close(true)

	emit("<")
	open()
		dec()

		emit(">>>")
		open()
			emit(">>")
		close(true)
		emit("<+<")
		open()
			emit("<<")
		close(true)
		emit("<")
	close()
	emit(">>>")
	open()
		emit(">>")	
	close(true)
	at(e)

	copy(r, tmp)

	to(tmp)
	open()
		dec()

		emit("<")
		open()
			emit("<<")
		close(true)
		emit("<+>>>")
		open()
			emit(">>")
		close(true)
		emit("<")
	close(true)

	emit("<")
	open()
		emit("<<")
	close(true)
	inc()

	open()
		emit(">>")
	close(true)
	at(e)
	to(r)

	free(tmp2)	
end

function alen(r, a)
	assert(allocated(r))
	assert(arrayAllocated(a))

	local s = a.start
	local e = a.start + a.length - 1
	local tmp = e - 1

	set(tmp, 0)

	to(s + 2)
	open()
		dec()

		emit(">>")
		open()
			emit(">>")
		close(true)
		
		emit("<")
		inc()
		
		emit("<")
		open()
			emit("<<")
		close(true)

		inc()
		emit(">>")
	close()
	at(e)

	move(r, tmp)
end