module HomeHelper
	def truncate(input, length)
	    if (input.length <= length) 
	        input
	    else 
	        input.slice(0, length) + "..."
    	end
    end
end
