" PROBLEM 8: Discover the largest product of five consecutive digits in the
" 1000-digit number.
"
" Find the greatest product of five consecutive digits in the 1000-digit
" number.

" Print data.  This deliberately leaves off newlines, since I'd have to strip
" them anyway, but preserves the block from the problem
execute "normal a73167176531330624919225119674426574742355349194934\<Esc>"
execute "normal a96983520312774506326239578318016984801869478851843\<Esc>"
execute "normal a85861560789112949495459501737958331952853208805511\<Esc>"
execute "normal a12540698747158523863050715693290963295227443043557\<Esc>"
execute "normal a66896648950445244523161731856403098711121722383113\<Esc>"
execute "normal a62229893423380308135336276614282806444486645238749\<Esc>"
execute "normal a30358907296290491560440772390713810515859307960866\<Esc>"
execute "normal a70172427121883998797908792274921901699720888093776\<Esc>"
execute "normal a65727333001053367881220235421809751254540594752243\<Esc>"
execute "normal a52584907711670556013604839586446706324415722155397\<Esc>"
execute "normal a53697817977846174064955149290862569321978468622482\<Esc>"
execute "normal a83972241375657056057490261407972968652414535100474\<Esc>"
execute "normal a82166370484403199890008895243450658541227588666881\<Esc>"
execute "normal a16427171479924442928230863465674813919123162824586\<Esc>"
execute "normal a17866458359124566529476545682848912883142607690042\<Esc>"
execute "normal a24219022671055626321111109370544217506941658960408\<Esc>"
execute "normal a07198403850962455444362981230987879927244284909188\<Esc>"
execute "normal a84580156166097919133875499200524063689912560717606\<Esc>"
execute "normal a05886116467109405077541002256983155200055935729725\<Esc>"
execute "normal a71636269561882670428252483600823257530420752963450\<Esc>"

" Don't want :s/// trying to tell us about how many lines it changed, and
" prepending :silent everywhere sucks
set report=1000000000

" Break on lone zeroes, which will only produce more zeroes -- very unlikely
" to be the maximum of anything and a waste of time
%substitute/0/\r/g

" Scrap segments with fewer than five numbers to multiply
%substitute/\v^\d{0,4}\n

" Of course, if that leaves nothing at all, then obviously the answer is zero.
" The easy way to deal with this is to add a line with just a zero and run the
" rest of the code; the lone zero can then potentially be the biggest product
execute "normal ggI0\<CR>\<Esc>"

" Now break every sequence of 6+ digits into lines of just 5 each; that is,
" replace 1234567\n with 12345\n23456\n34567\n.
" I think this is particularly clever.  It looks for six digits and captures
" them as [1][2345][6], but uses \ze to make Vim consider the pattern as only
" matching the [1].  Then Vim replaces the [1] with [1][2345]\n and continues
" matching immediately after that -- that is, starting at 2.  Without this, we
" would both have to reprint everything we matched AND repeat the whole
" substitution, as Vim would resume searching for a full set of six digits
" starting AFTER the 6!
%substitute/\v(\d)\ze(\d\d\d\d)(\d)/\1\2\r/g

" Replace every line of five digits with their product.  This is admittedly
" pretty lame, but a loop would make this far more complicated and there's not
" much point when the problem explicitly stated we're looking for five digits.
" (The above :s needs manual tweaking for more than five, anyway.)
%substitute/\v^(\d)(\d)(\d)(\d)(\d)$/\=submatch(1) * submatch(2) * submatch(3) * submatch(4) * submatch(5)

" Sort the products numerically
%sort n

" The last line is now the biggest number; yank it into a buffer
normal G
normal 0
normal "ay$

" Normally, using :! will print an extra newline, execute the given command,
" then print another newline and a prompt to press Enter to return to Vim.
" This breaks our rules.  Luckily, :silent takes its job seriously and skips
" ALL of this printing entirely; all we get is the result and a newline!
" Granted, shelling out is a little questionable, but I can't find any other
" way to print to stdout from Vim
silent execute "!echo " . @a
quit!
