
#.each takes a block and does something based on the items in an array.
module Enumerable

	def my_each
		return to_enum(:my_each) unless block_given?

		for element in self
			yield(element)
		end	
	end


	def my_each_with_index
		index = 0
		return to_enum(:my_each_with_index) unless block_given?

		for element in self
			yield(element,index)
			index+=1
		end
	end

	def my_select(&block)
		result = []
		return to_enum(:my_select) unless block_given?

		for elements in self
			if yield(element)
				result.push(element)
			end
		end
		result
	end

	def my_all?
		result = true
		if block_given?
			for elements  in self
				yield(element) ? next : result = false
			end
		else
			counter = 0
			for element in self do 
				if self[counter] == nil || self[counter] == false
					result = false
				end
				counter +=1
			end
		end
		result
	end

end



test = [53,1,20,5,9,5]

bob = test.my_all? 

p bob


=begin
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
	
