PROBLEM 5: What is the smallest number divisible by each of the numbers 1 to 20?

[ 2520 is the smallest number that can be divided by each of the numbers from 1
to 10 without any remainder.

What is the smallest number that is evenly divisible by all of the numbers from
1 to 20? ]


=== A WARNING ===

[ This is slow.  Really, really slow.  Unfathomably slow.  Even compiling to C,
it takes almost four minutes to get a final result on my machine.

In other words, do NOT try to run this script as-is with the given interpreter
as-is.  Either cut down on the starting value (20, first line) significantly
or change the interpreter's main loop to spit out C code and then run that.

Some may call it cheating that I borrowed a divmod algorithm from Esolang.  I
call those people assholes, as this already took far too much time to create.
I think using it to print a multi-digit number is clever enough to earn some
forgiveness, anyway.

I don't use "long comments" anywhere else in this file, if you were wondering
why there are no periods or commas.  They're a hassle. ]


=== EXPLANATION ===

The basic algorithm here is as follows:
  * Stick max value 20 in cell (1)
  * Stick a running product in cell (2)
  * Loop over cell (1) until it reaches 1
      * Find the GCD of (1) and (2) via Euclidean algorithm
          * Find the product (2) mod the counter (1)
          * If the mod is zero: the counter is the GCD
          * Otherwise: repeat but find the counter mod the last mod
      * Divide (1) by the GCD; multiply (2) by this result
  * Print contents of (2)
      * Loop over (2) splitting it into div 10 and mod 10 until nothing is left
      * Go back and print all those digits

The division algorithm I use is the following (shamelessly found on Esoland):

    To turn {*n d} into {*0 n/d*d n%d n/d}:
    [->-[>+>>]>[+[-<+>]>+>>]<<<<<]

Note that this makes use of several empty cells on the right AND that it doesn't
work very well when dividing by one!


nb: most of the lines below begin with a number in braces which is where the
    cursor ought to be when the next instruction is executed


=== SETUP ===

Set the counter (1) to the max value
{1} +++++ +++++ +++++ +++++

Initialize the running product (2) to 1
{1} > + <


=== MAIN LOOP ===

Start looping over the counter (1); note that we subtract and then add so the
loop stops at 1
{1} - [ +

    We need the GCD of (1) and (2) first; to get this we need to calculate
    (2) mod (1) repeatedly

    To do this we are going to:
      * Set up {counter *product counter}
      * Divide and get {counter *0 junk modulus junk}
      * Shuffle this to {modulus *counter modulus}
      * Repeat if modulus isn't zero
    UNFORTUNATELY there is one snag here: the division algorithm screws up
    royally if the divisor is 1!
    This means that IF the modulus is 1 either before the loop starts OR the
    loop restarts we need to specialcase and:
      * Set the modulus (both of them) to 0
      * Set the counter to 1

    First we do the initial setup in cells (3 4 5): {counter product counter}
    Copy the counter to all three cells then move (4) back to (1)
    {1} [ >>+ >+ >+ <<<<- ]
    {1} >>>  [ <<<+ >>>- ]

    Now copy the product (2) to cells (4 6) then restore from (6)
    {4} << [ >>+ >>+ <<<<- ]
    {2} >>>> [ <<<<+ >>>>- ]

    Move the cursor to the clone of the product and we are good to go
    {6} <<

    Do the specialcasing for 1: if the modulus minus one is zero then set it
    to zero and the counter to 1
    Alas we can only test for truth (not false) so first we copy to (6 7) and
    restore from (7):
    {4} >
    {5} [ >+ >+ <<- ]
    {5} >> [ <<+ >>- ]
    Set (7) to true and CLEAR it if (6) is not 1
    {7} + <
    {6} - [ >- <[-] ] + >
    Now we can set mod (3 5) to 0 and counter (4) to 1 iff (7) is set
    {7} [ <<<<[-] >[-]+ >[-] >>[-] ]
    Clear out (6) too
    {7} < [-] <<

    Start the loop: remember we are testing the last iteration's modulus which
    has a copy in (3) so do the test there
    {4} < [ >

        Perform the division
        {4} [->-[>+>>]>[+[-<+>]>+>>]<<<<<]

        Now we have {counter product old_modulus *0 junk modulus junk}

        Delete the junk
        {4} > [-] >> [-]
        
        Move the old modulus to the dividend cell (4)
        {7} <<<< [ - >+ < ]

        Move the new modulus to the hold cell (3) and divisor cell (5)
        {3} >>> [ - <<<+ >>+ > ]

        Tape is now {counter product modulus old_modulus modulus *0}

        Just move the cursor back where it started and loop
        {6} <<<

        Our special case: test to see if the modulus is 1
        Note that this is the same as the code above
        {3} >>
        {5} [ >+ >+ <<- ]
        {5} >> [ <<+ >>- ]
        {7} + <
        {6} - [ + >- <[-] ] >
        {7} [ <<<<[-] >[-]+ >[-] >>[-] ]
        {7} < [-] <<<

    End the loop with {counter product *0 GCD}
    {3} ]

    Now we need to divide the counter by the GCD
    First copy it to (3 5) and restore it from (5)
    {3} << [ >>+ >>+ <<<<- ]
    {1} >>>> [ <<<<+ >>>>- ]
    {5} <<

    Apply division algorithm IFF the gcd is not 1
    {counter product *counter gcd}
    {3} > - [ + <
        {3} [->-[>+>>]>[+[-<+>]>+>>]<<<<<]
        {counter product *0 junk junk quotient}

        Clear out junk
        {3} >[-] >[-]

        Move quotient to 3 to be consistent to what we'd have if we skipped
        this block
        {5} > [ <<<+ >>>- ]

        Restore the state of the block opening
        {6} <<

    Undo what we did before
    {4} ] <

    Move quotient back to 6 for consistency with what the following code was
    written to expect; bf is way too fragile for me to want to change it
    {3} [ >>>+ <<<- ]
    {3} >>

    Multiply product by quotient
    {counter product 0 0 *0 quotient}
    {5} <<<
    Move product to a temp space (3)
    {2} [ >+ <- ] >
    Iterate over temp product
    {3} [
        Pour quotient (6) into target cell (2) and temp cell (4) then restore
        {3} >>> [ <<<<+ >>+ >>- ]
        {6} << [ >>+ <<- ]
        Decrement temp product
        {4} < -
    {3} ]
    {counter new_prduct *0 0 0 quotient}

    Nuke quotient
    {3} >>> [-]

    Decrement counter and do it all over!
    {6} <<<<< -

Remember to do another decrement to match the inc we do at the loop start
{1} - ]
        

=== PRINTING ===

Everything is now zero except cell (2) which contains the answer
{1} >

But we have to split it up by digit for printing; one digit per cell
{2} [

    Put 10 in cell (3) and use division algorithm repeatedly to print
    {n} > +++++ +++++ <

    Remember: this changes {n d} into {0 junk n%d n/d}
    {n} [->-[>+>>]>[+[-<+>]>+>>]<<<<<]

    Deal with cells individually

    First up is junk we don't need: clear it
    {n} > [-]

    Then the modulus: our first digit which we save in the original slot
    {n&1} > [-<<+>>]

    But add one to it so we know not to skip it when printing
    {n&2} <<+>>

    Division result is the new n: move it to the slot after the original
    {n&2} > [-<<+>>]

    Move to the slot after the original and do it again if there's anything left
    {n&3} <<

{n&1} ]

Skip the current digit; it's the remaining zero
<

For each digit:
[

    Add 47 instead of 48 since we bumped its value by one
    ++++++  ++++++  ++++++  ++++++
    ++++++  ++++++  ++++++  +++++

    Print
    .

    Be polite
    [-]

    And go back one
    <
]

Print the required newline
+++++ +++++ . [-]

Done!  Tape should be empty with pointer on first cell
