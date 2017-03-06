
#.each takes a block and does something based on the items in an array.
module Enumerable
	def my_each
		for element in self
			yield(element)
		end
	end


	def my_each_with_index
		index = 0
		for element in self
			yield(element,index)
			index+=1
		end
	end

#hmm
	def my_select(&block)
		for element in self
			yield(element)
		end
	end
end


test = [5,1,20,150,9,5]

#test.my_each_with_index do |x,y|
	#puts y
#end

test.select do |x|
	p x == 5
end


=begin

	

	def my_all?

	end

	def my_any?

	end

	def my_none?

	end

	def my_count

	end

	def my_map
	end

	def my_inject
	end

	def multiply_els
	end	
=end
	
