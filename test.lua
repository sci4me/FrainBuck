for i = 0, 9 do
	to(i)
	add(i + 1)
	emitln()
end

right()

add(10)
open()
	right()
	add(4)
	left()
	sub()
close()
right()
add(8)

emitln()
to(0)
emitln()

open()
	right()
close(true)
to(11)
write()