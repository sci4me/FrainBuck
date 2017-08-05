function ainit(a)
	assert(blockAllocated(a))
	assert(a.length >= 5)

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
	assert(blockAllocated(a))
	assert(allocated(i))
	assert(allocated(v))

	local s = a.start
	local e = a.start + a.length - 1
	local tmp = e - 1

	copy(tmp, i)

	to(s + 2)
	open()
		right(2)
	close(true)


end

function aget(r, a, i)
	assert(allocated(r))
	assert(blockAllocated(a))
	assert(allocated(i))

end

function alen(r, a)
	assert(allocated(r))
	assert(blockAllocated(a))
	
end