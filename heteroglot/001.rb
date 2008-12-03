#!/usr/bin/env ruby

# PROBLEM 1: Add all the natural numbers below one thousand that are multiples
# of 3 or 5.
#
# If we list all the natural numbers below 10 that are multiples of 3 or 5, we
# get 3, 5, 6 and 9. The sum of these multiples is 23.
#
# Find the sum of all the multiples of 3 or 5 below 1000.

sum = 0
for i in (1 .. 999)
    if i % 3 == 0 or i % 5 == 0
        sum += i
    end
end

puts sum
