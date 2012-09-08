      * PROBLEM 15: Starting in the top left corner in a 20 by 20 grid,
      * how many routes are there to the bottom right corner?
      *
      * Starting in the top left corner of a 2×2 grid, there are 6
      * routes (without backtracking) to the bottom right corner.
      *
      * How many routes are there through a 20×20 grid?

       IDENTIFICATION DIVISION.
       PROGRAM-ID. project-euler-15


       DATA DIVISION.
       WORKING-STORAGE SECTION.

      * grid size: 20 x 20
       78 width VALUE IS 20.
       78 height VALUE IS 20.

       LOCAL-STORAGE SECTION.

      * used by n-choose-r
       01 i                            USAGE IS UNSIGNED-LONG.
       01 n                            USAGE IS UNSIGNED-LONG.
       01 r                            USAGE IS UNSIGNED-LONG.
       01 n-choose-r-result            USAGE IS UNSIGNED-LONG.


       PROCEDURE DIVISION.
       do-the-needful.
      * nCr(width, width + height)
           COMPUTE n = width + height
           MOVE width TO r
           PERFORM n-choose-r
           DISPLAY n-choose-r-result
           .


      * precond: desired arguments in n, r
      * postcond: return value in n-choose-r-result
       n-choose-r.
           MOVE 1 TO n-choose-r-result
      * cute trick to avoid overflow: go through the numerator's factors
      * from largest to smallest, and the denominator's from smallest to
      * largest.  every step will produce an integer, simply because of
      * how nCr works: nCr on two integers is always integral, and
      * looping in this way, the intermediate results are nCr(n, 1),
      * nCr(n, 2), nCr(n, 3)... which must all also be integers.
           PERFORM VARYING i FROM 1 BY 1 UNTIL i > r
               COMPUTE n-choose-r-result =
                   n-choose-r-result * (n - i + 1) / i
           END-PERFORM
           .

       END PROGRAM project-euler-15.
