
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

	
	#this can apparently be done in 3 lines of code.
	#does not work with strings
	def my_reduce(argument = (no_argument_passed = true), args = {})
		
		sum = nil
	
		#fix here
		#bruk my each
		if block_given? 
			if (argument.is_a? (Integer))
				accumulator = argument			
			end
			
			for value in self
				 accumulator = yield(accumulator,value)
			end
			return accumulator
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

	def my_map_modified(&proc)
		return to_enum(:my_map) unless block_given?
		new = []
		self.my_each do |elements|
			new << proc.call(elements)
		end
		new
	end

end #Enumerable module end
	
def multiply_els(numbers)
	result = numbers.my_reduce(:*)	
end



testy = Proc.new {|x| x*2}


someNumbers = [2,4,5]

#test = someNumbers.my_map do |x|
	#x*2
#end

p someNumbers.my_map_modified(&testy)
p someNumbers.my_map_modified{|x| x*5}










