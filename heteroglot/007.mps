 ; PROBLEM 7: Find the 10001st prime.
 ;
 ; By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
 ; that the 6th prime is 13.
 ;
 ; What is the 10001st prime number?

 ; Note that lines cannot, in fact, start with a semicolon.
 ; Also, comments inside a block need the same dot-indenting.

zmain
    SET targetidx=10001
    SET currentidx=0

    ; Iterate over natural numbers until we find our xth prime
    FOR n=2:1 DO
    . SET sqrt=$zr(n)

    . ; Iterate over the primes we've seen thusfar and test them against ours
    . SET isprime=1
    . FOR p=1:1:currentidx*isprime DO
    .. ; Bail if we've passed the square root
    .. IF primes(p)>sqrt BREAK
    .. ; # is modulus; if evenly divisible, bail
    .. IF n#primes(p)=0 DO
    ... SET isprime=0

    .. ; BREAK is nonstandard, but a necessary optimization.  :(
    .. ; QUIT functions like CONTINUE within a DO block.
    .. IF isprime=0 BREAK
    . IF isprime=0 QUIT

    . SET currentidx=currentidx+1
    . SET primes(currentidx)=n
    . IF currentidx=targetidx WRITE n,! HALT
