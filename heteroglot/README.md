This is a set of Project Euler solutions in which no programming language is
used twice.

Each program begins with a comment containing the entire problem description.
When run, each program prints the solution and a single newline to standard
output.  There are no Makefiles or other compilation aids here; with very few
exceptions, solutions should only require a single source file.


# Rules

The rules are loose and entirely subject to my interpretation, but I try to
stick to the following:

* Languages may not be reused.  Variants are generally avoided, but the
  ultimate guideline is whether the result would be _interesting_.

* Languages shall be chosen without regard for the requirements of the next
  problem.  Ideally, I should have no idea what the next problem even is.

* Trivial transformational scripts (in any language) are allowed in extreme
  cases if a language is particularly difficult to read or write.  This
  exception exists solely for Whitespace.

* Programs must perform the actual calculation.  The general pattern is that
  any numbers or other parameters that appear in the problem are defined as
  constants within the program; changing the constants thus ought to produce
  the appropriate answer.  (Programs are not, however, expected to deal with
  excessively large or malformed parameters.)


# Languages used

* Problem 1: Ruby  
    _Add all the natural numbers below one thousand that are multiples of 3 or 5._

* Problem 2: C  
    _By considering the terms in the Fibonacci sequence whose values do not exceed four million, find the sum of the even-valued terms._

* Problem 3: C++  
    _Find the largest prime factor of a composite number._

* Problem 4: x86 assembly  
    _Find the largest palindrome made from the product of two 3-digit numbers._

* Problem 5: Brainfuck  
    _What is the smallest number divisible by each of the numbers 1 to 20?_

* Problem 6: Whitespace  
    _What is the difference between the sum of the squares and the square of the sums?_

* Problem 7: MUMPS  
    _Find the 10001st prime._

* Problem 8: vimscript  
    _Discover the largest product of five consecutive digits in the 1000-digit number._

* Problem 9: LOLcode  
    _Find the only Pythagorean triplet, {a, b, c}, for which a + b + c = 1000._

* Problem 10: Standard ML  
    _Calculate the sum of all the primes below two million._

* Problem 11: Bash  
    _What is the greatest product of four adjacent numbers on the same straight line in the 20 by 20 grid?_

* Problem 12: Prolog  
    _What is the value of the first triangle number to have over five hundred divisors?_

* Problem 13: Lua  
    _Find the first ten digits of the sum of one-hundred 50-digit numbers._

* Problem 14: XSLT  
    _Find the longest sequence using a starting number under one million._

* Problem 15: COBOL  
    _Starting in the top left corner in a 20 by 20 grid, how many routes are there to the bottom right corner?_

* ...

* Problem 67: Haskell  
    _Using an efficient algorithm find the maximal sum in the triangle?_

## Declared unusable

For posterity, the following languages have been attempted in the past, but
have been ruled _unusable_ by executive decree.

* Malbolge


# Links

* [Project Euler](http://projecteuler.net/)
* [Full list of Project Euler problems](http://projecteuler.net/problems)
* [Blog series about these solutions](http://me.veekun.com/blog/categories/project-euler/)
