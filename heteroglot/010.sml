(* PROBLEM 10: Calculate the sum of all the primes below two million. *)

(* The sum of the primes below 10 is 2 + 3 + 5 + 7 = 17.
 *
 * Find the sum of all the primes below two million. *)

(* This is a functional implementation of the Sieve of Eratosthenes.  Given a
 * target n, it constructs a list of integers from 2 to n, then runs through
 * the list and returns head :: sieve(tail not divisible by head).  This
 * filters the list in the correct (increasing) order. *)
fun primes_to n : IntInf.int list =
  let
    (* Filters multiples of a single divisor out of a list and returns it. *)
    (* NOTE: This is not strictly the Sieve as originally described, as it
     * removes numbers from the list entirely rather than blanking them, as
     * above.  However, in functional languages, rebuilding a list with two
     * million elements many times over takes a phenomenally long time.  This
     * function is much quicker, as it strips down the list by half just in
     * the first pass.  If you wish to use the true sieve, change the call to
     * partial_sieve to true_sieve instead in prime_sieve below. *)
    fun partial_sieve divisor nil = nil
    |   partial_sieve divisor (l as h::t) =
        if h mod divisor = 0 then
          partial_sieve divisor t
        else
          h :: partial_sieve divisor t

    (* Performs individual sieving per prime divisor that is true to the
     * original method, replacing every divisor-th list element with a 0. *)
    fun true_sieve' divisor pos nil = nil
    |   true_sieve' divisor pos (l as h::t) =
        if pos = 0 then
          0 :: true_sieve' divisor (divisor - 1) t
        else
          h :: true_sieve' divisor (pos - 1) t

    fun true_sieve divisor nil = nil
    |   true_sieve divisor l = true_sieve' divisor (divisor - 1) l

    (* Creates the full list, sieving out the next prime with each recursion *)
    fun prime_sieve nil = nil
    |   prime_sieve (0::t) = prime_sieve t
    |   prime_sieve (h::t) =
        h :: (prime_sieve (partial_sieve h t))
     (* h :: (prime_sieve (true_sieve h t)) *)

    (* Returns the list a..b; probably already exists but dunno where *)
    fun dotdot first last =
      if first = last then
        [last]
      else
        first :: dotdot (first + 1) last
  in
    prime_sieve (dotdot 2 n)
  end;
  
print (IntInf.toString (foldl op+ 0 (primes_to 2000000)));
print "\n";
