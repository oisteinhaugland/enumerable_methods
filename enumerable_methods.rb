
#.each takes a block and does something based on the items in an array.
module Enumerable
	def my_each
		for element in self
			yield(element)
		end
	end
end


test = [1,2,3,4,5]

test.my_each do |x|
	p x
end