include("lib/basic.lua")
include("lib/bool.lua")
include("lib/math.lua")
include("lib/print.lua")
include("lib/array.lua")

local tmp = alloc()
local a = alloc()

to(tmp)
inc(10)
open()
	to(a)
	inc(10)
	to(tmp)
	dec()
close()

to(tmp)
inc(5)
open()
	to(a)
	inc(3)
	to(tmp)
	dec()
close()
to(a)

write()

inc(2)
write()

to(tmp)
inc(5)
open()
	to(a)
	dec(3)
	to(tmp)
	dec()
close()
to(a)

dec(3)
write()
write()

local b = alloc()
to(tmp)
inc(10)
open()
	to(b)
	inc(3)
	to(tmp)
	dec()
close()
to(b)

inc(2)
write()

to(a)
inc(10)
write()

dec(8)
write()