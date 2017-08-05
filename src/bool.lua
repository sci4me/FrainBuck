include("src/basic.lua")

function truthy(r, a)
	assert(allocated(r))
	assert(allocated(a))

	to(r)
	clear()
	if_then(a, function()
		to(r)
		inc()
	end)
	to(r)
end

function bor(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	to(r)
	clear()
	if_then(a, function()
		to(b)
		inc()
	end)
	truthy(r, b)
end

function band(r, a, b)
	assert(allocated(r))
	assert(allocated(a))
	assert(allocated(b))

	to(r)
	clear()
	to(a)
	if_then(a, function()
		if_then(b, function()
			to(r)
			inc()
		end)
	end)
	to(r)
end

function bnot(a)
	assert(allocated(a))

	local tmp = alloc()

	to(tmp)
	inc()
	if_then(a, function()
		to(tmp)
		dec()		
	end)
	move(tmp, a)

	free(tmp)
end