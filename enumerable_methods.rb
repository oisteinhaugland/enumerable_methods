
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
			if yield(elements)
				result.push(elements)
			end
		end
		result
	end

	def my_all?
		result = true
		if block_given?
			for elements  in self
				yield(elements) ? next : result = false
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


	def my_any?
		result = false
		if block_given?
			for elements  in self
				yield(elements) ? result = true: next
			end
		else
			counter = 0
			for element in self do 
				if self[counter] != nil || self[counter] != false
					result = true
				end
				counter +=1
			end
		end
		result
	end

	def my_none?
		result = true
		if block_given?
			for elements in self
				yield(elements) ? result = false : next
			end
		else
			counter = 0
			for element in self do 
				if self[counter] == true
					result = false
				end
				counter +=1
			end
		end
		result
	end

	def my_count(parameter = (no_argument_passed = true;))
		count = 0
		
		if no_argument_passed && !block_given? 
			for elements in self
				count += 1
			end	
		elsif block_given?	
				for elements in self
					yield(elements) ? count += 1 : next
				end
		else
			iterator = 0
			for elements in self
				count += 1 if parameter== self[iterator]
				iterator +=1
			end
		end
		count
	end

end #module end



test = ["bob",52,"test",1,2,3,2]
bob = test.my_count do |x|
	x == 2
end

p bob


=begin
	

	

	def my_map
	end

	def my_inject
	end

	def multiply_els
	end	
=end
	
