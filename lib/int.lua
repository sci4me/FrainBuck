function Int(size)
	local blk = allocBlock(size)

	local self = {
		type = "int",
		size = size,
		address = blk.address,
		blk = blk
	}

	self.add = function(other)
		assert(other.type == "int")
		assert(other.size == size)

		local a, b = allocBlock(size), allocBlock(size)
		copy(blk, a)
		copy(other.blk, b)

				
	end

	return self
end