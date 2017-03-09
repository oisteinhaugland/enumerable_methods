
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

	def my_count(parameter = (no_argument_passed = true))
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



	#my_map! would be another method that changes the given array instead of a new one.
	def my_map
		return to_enum(:my_map) unless block_given?
		mapped_array = []
		for elements in self
			mapped_array.push(yield(elements))
		end
		mapped_array
	end


	#Apparently the inject and reduce methods are aliases. There is no performance benefit to either.

	def my_reduce(argument = (no_argument_passed = true), args = {})
		sum = nil
		
#if a block is given -> for each element in the array, yield the block.

		if no_argument_passed && block_given?	
			result = []
			for elements in self
				result.push(yield(elements))
			end
			
			return result
		end


		if (argument.is_a? (Integer)) && (args.is_a? (Symbol))  #If you pass an integer and a symbol
			sum = argument
			symbolCase = args		
		elsif(argument.is_a? (Symbol)) && args.size == 0 #If you just pass a symbol.
			sum = self[0]
			symbolCase = argument
		end 

		#this works when no block is given
		if !block_given?
			self.my_each_with_index do |x,i|
				next if i == 0
				case symbolCase
					when :+
						sum += x
					when :-
						sum -= x
					when :/
						sum /= x
					when :*
						sum *= x
					when :**
						sum **=x
				end

			end	
		return sum
		end
	end

end #module end



test = [1,2,3,4,5]

#bob = test.reduce(1, :+)
per =  test.my_reduce do |x|
	x += 5
end

# p test
#p bob
p per


=begin
	

	



	def multiply_els
	end	
=end
	
