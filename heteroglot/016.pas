(*
    PROBLEM 16: Power digit sum

    2^15 = 32768 and the sum of its digits is 3 + 2 + 7 + 6 + 8 = 26.

    What is the sum of the digits of the number 2^1000?
*)
program ProjectEuler16;

const
    base = 2;
    exponent = 1000;
    number_base = 10;
    digits = 1000;

var
    bignum: packed array[1..digits] of integer;
    digit, carry, i, n: integer;

begin
    (*
        Despite my best efforts, I can't find any way to solve this without
        actually computing the number.  :(  So here's a quick and dirty bigint
        implementation.
    *)

    (* Compute the sum of the digits in base ^ exponent, in base number_base,
        with digits of space to work with. *)
    (* Populate our bignum with 1.  Note that the digits are stored in reverse
        order (so the units digit comes first) and numbered from 1. *)
    for digit := 1 to digits do begin
        bignum[digit] := 0;
    end;
    bignum[1] := 1;

    (* Multiply it by base, exponent times. *)
    for i := 1 to exponent do begin
        carry := 0;
        for digit := 1 to digits do begin
            carry := carry + bignum[digit] * base;
            bignum[digit] := carry mod number_base;
            carry := carry div number_base;
        end;
    end;

    (* Sum the digits *)
    n := 0;
    for digit := 1 to digits do begin
        n := n + bignum[digit];
    end;

    (* And print the answer. *)
    writeln(n);
end.
