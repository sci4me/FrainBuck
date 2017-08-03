local _tmp, _tmp2 = alloc(2)

local _chars = { alloc(15) }
local _pad2 = alloc()

local bs = { 10, 9, 11, 11, 12, 3, 9, 10, 11, 10, 10, 9, 12, 3, 1 }
local bs2 = { 4, 7,  2,  2,  1, 2, 8,  5,  4,  2,  0, 7,  1, 3, 0 }

to(_tmp)
add(10)
open()
	for i = 1, #bs do
		to(_chars[i])
		add(bs[i])
	end

	to(_tmp)
	sub()
close()

for i = 1, #bs2 do
	to(_chars[i])
	if bs2[i] > 0 then
		add(bs2[i])
	end
end

for i = 1, 2 do
	to(_tmp2)
	add(20)
	open()
		to(_tmp)
		add(10)
		to(_tmp2)
		sub()
	close()

	to(_tmp)
	open()
		to(_chars[1])
		open()
			write()
			right()
		close(true)
		at(_pad2)
		to(_tmp)
		sub()
	close()
end

to(_tmp)
add(20)
open()
	to(_chars[1])
	open()
		write()
		right()
	close(true)
	at(_pad2)
	to(_tmp)
	sub()
close()