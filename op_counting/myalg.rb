#Date: 09/13/2017
#Class: CS5310
#Assignment: Assignment 2
#Author: Dillon Daudert

class MyAlg

    attr_accessor :array
    
    def initialize array
        # verify that array is at least of size 1
        if not array.length >= 1
            raise ArgumentError            
        end
        # verify that it is an array of integers
        for item in array
            if not item.is_a? Integer
                raise ArgumentError
            end
        end

        @array = array
    end

    def bubble_sort
        for i in 0 ... @array.length
            for j in (@array.length-1).downto(i+1)
                if @array[j-1] > @array[j]
                    t = @array[j-1]
                    @array[j-1] = @array[j]
                    @array[j] = t
                end
            end
        end
        return @array
    end

    def linear_search tar
        for i in 0 ... @array.length
            if @array[i] == tar
                return @array[i]
            end
        end
        return nil
    end

    def swap
        i = 0
        while i < @array.length - 1
            temp = @array[i]
            @array[i] = @array[i+1]
            @array[i+1] = temp
            i = i + 2
        end
        
        return @array
    end
end
