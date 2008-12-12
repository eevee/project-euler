(* PROBLEM 10: Calculate the sum of all the primes below two million. *)

(* The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million. *)

(* This is a functional implementation of the Sieve of Eratosthenes.  Given a
 * target n, it constructs a list of integers from 2 to n, then runs through
 * the list and returns head :: sieve(tail not divisible by head).  This
 * filters the list in the correct (increasing) order. *)
fun primes_to n =
  let
    (* Filters multiples of a single divisor out of a list and returns it. *)
    fun partial_sieve divisor nil = nil
    |   partial_sieve divisor (l as h::t) =
        if h mod divisor = 0 then
          partial_sieve divisor t
        else
          h :: partial_sieve divisor t

    (* Actually performs the sieve..ing? *)
    fun prime_sieve nil = nil
    |   prime_sieve (h::t) =
        h :: (prime_sieve (partial_sieve h t))

    (* Returns the list a..b; probably already exists but dunno where *)
    fun dotdot first last =
      if first = last then
        [last]
      else
        first :: dotdot (first + 1) last
  in
    prime_sieve (dotdot 2 n)
  end;
  
print (Int.toString (foldl op+ 0 (primes_to 2000000)));

(* While the above provides the CORRECT output, the answer is gigantic and
 * causes an overflow in MLton.  What I actually did was swap it out for the
 * following line, then pipe the result into:
 *     perl -e 'use List::Util "sum"; print sum <STDIN>;'  *)
(* map (fn x => print (x ^ "\n")) (map Int.toString (primes_to 2000000)); *)

print "\n";
