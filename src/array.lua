function ainit(a)
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

end

function alen(r, a)

end