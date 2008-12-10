OBTW
    PROBLEM 9: Find the only Pythagorean triplet, {a, b, c}, for which
    a + b + c = 1000.
    
    A Pythagorean triplet is a set of three natural numbers, a < b < c, for
    which, a^2 + b^2 = c^2.

    For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

    There exists exactly one Pythagorean triplet for which a + b + c = 1000.
    Find the product abc.
TLDR

OBTW
    This code uses the 1.0-mod spec, more or less.  1.1 is incomplete, and I
    cannot seem to find an interpreter capable of running 1.2.

    This was successfully run under YALI, found here:
        http://1.618034.com/yali-yet-another-lolcode-interpreter

    I'd like to update this to reflect 1.2 (or even 1.3), but I can't find an
    interpreter that works sufficiently well.
TLDR

HAI 1.0

I HAS A sum ITZ 1000
I HAS A a ITZ 1
IM IN YR A_LOOP
    IZ a LIEK sum O RLY?
      YA RLY
        GTFO
    KTHX

    I HAS A a_sq ITZ a TIEMZ a
    I HAS A b ITZ a UP 1
    IM IN YR B_LOOP
        IZ b LIEK sum O RLY?
          YA RLY
            GTFO
        KTHX

        BTW Bail if a + b is already bigger than the total
        I HAS A ab ITZ a UP b
        IZ ab LIEK sum O RLY?
          YA RLY
            GTFO
        KTHX

        I HAS A c ITZ sum NERF ab

        BTW The problem defines that a < b < c, so bail if c is less than b
        IZ b BIGR THAN c O RLY?
          YA RLY
            GTFO
        KTHX

        I HAS A b_sq ITZ b TIEMZ b
        I HAS A c_sq ITZ c TIEMZ c

        IZ c_sq LIEK a_sq UP b_sq O RLY?
          YA RLY
            VISIBLE a TIEMZ b TIEMZ c
            DIAF ""
            GTFO
        KTHX

        UP b!!
    KTHX

    UP a!!
KTHX

KTHXBYE
