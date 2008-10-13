#!/usr/bin/env perl

# Problem 6: What is the difference between the sum of the squares and the
# square of the sums?

# The sum of the squares of the first ten natural numbers is,
# 12 + 22 + ... + 102 = 385
#
# The square of the sum of the first ten natural numbers is,
# (1 + 2 + ... + 10)2 = 552 = 3025
#
# Hence the difference between the sum of the squares of the first ten natural
# numbers and the square of the sum is 3025 385 = 2640.
#
# Find the difference between the sum of the squares of the first one hundred
# natural numbers and the square of the sum.


# As this problem is solved in Whitespace and Whitespace is rather difficult to
# write (let alone comment!), this Perl script will both spit out the actual
# source and serve as commentary.


use strict;
use warnings;

# Our three symbols
my $SPACE = ' ';
my $TAB   = "\t";
my $LF    = "\x0a";

# Instruction Modification Parameters
my %IMP = (
    stack => $SPACE,
    math  => $TAB.$SPACE,
    heap  => $TAB.$TAB,
    flow  => $LF,
    io    => $TAB.$LF,
);

# Some conversions to Whitespace values

sub convert_number ($) {
    my ($num) = @_;
    # Thanks, Perl Cookbook!
    my $binary = unpack 'B32', pack('N', abs $num);
    $binary =~ s/^0+//;
    $binary ||= '0';

    my $sign = $binary < 0 ? $TAB : $SPACE;
    $binary =~ s/0/$SPACE/g;
    $binary =~ s/1/$TAB/g;
    return $sign . $binary . $LF;
}

my %labels;
my $max_label = 0;
sub convert_label ($) {
    my ($label) = @_;

    if (not $labels{$label}) {
        $max_label++;
        $labels{$label} = $max_label;
    }

    return convert_number($labels{$label});
}

### Instructions, in uppercase so we don't worry about name clashes

my %instructions = (
    stack => {
        PUSH  => [ $SPACE,          \&convert_number    ],
        DUPE  => [ $LF.$SPACE,                          ],
        COPY  => [ $TAB.$SPACE,     \&convert_number    ],
        SWAP  => [ $LF.$TAB,                            ],
        POP   => [ $LF.$LF,                             ],
        SLIDE => [ $TAB.$LF,        \&convert_number    ],
    },
    math => {
        ADD   => [ $SPACE.$SPACE,                       ],
        SUBT  => [ $SPACE.$TAB,                         ],
        MULT  => [ $SPACE.$LF,                          ],
        IDIV  => [ $TAB.$SPACE,                         ],
        MOD   => [ $TAB.$TAB,                           ],
    },
    heap => {
        STORE => [ $SPACE,                              ],
        RETR  => [ $TAB,                                ],
    },
    flow => {
        LABEL => [ $SPACE.$SPACE,   \&convert_label     ],
        CALL  => [ $SPACE.$TAB,     \&convert_label     ],
        JUMP  => [ $SPACE.$LF,      \&convert_label     ],
        JMPZ  => [ $TAB.$SPACE,     \&convert_label     ],
        JMPLZ => [ $TAB.$TAB,       \&convert_label     ],
        RET   => [ $TAB.$LF,                            ],
        EXIT  => [ $LF.$LF,                             ],
    },
    io => {
        WCHAR => [ $SPACE.$SPACE,                       ],
        WNUM  => [ $SPACE.$TAB,                         ],
        RCHAR => [ $TAB.$SPACE,                         ],
        RNUM  => [ $TAB.$TAB,                           ],
    },
);

# Convert all the above to subs
while (my ($imp, $instr_ref) = each %instructions) {
    while (my ($name, $def_ref) = each %{$instr_ref}) {
        no strict 'refs';

        my ($command, $param) = @{$def_ref};
        *{$name} = sub {
            print $IMP{$imp};
            print $command;
            if ($param) {
                print $param->(shift);
            }
        };
    }
}


### Program!

# Rather than the obvious method of calculating the two numbers and figuring
# the difference, we're going to use some ~algebra~.
# Observe:
# (a + b)^2 = a^2 + b^2 + 2ab
# (a + b + c)^2 = a^2 + b^2 + c^2 + 2ab + 2ac + 2bc
# (a + b + c + d)^2 = a^2 + b^2 + c^2 + d^2 + 2ab + 2ac + 2ad + 2bc + 2bd + 2cd
# Because every element is multiplied by every other element exactly once, the
# result will always be a sum of squares, plus every OTHER combination of
# elements (twice, technically; once if they're permutations).
# Thus to get the answer we can do essentially the following:
#     sum = 0
#     for i = 1 to n:
#         for j = 1 to n:
#             if i != j:
#                 sum += i * j
# I could shorten the inner loop considerably by just iterating from i to n and
# doubling the final answer, but I'm not pushing my luck here.

# Init: store the target (100) and running total (0) in heap slots 1 and 2
PUSH(1);
PUSH(100);
STORE();

PUSH(2);
PUSH(0);
STORE();

# Outer loop: take i from 1 to n
PUSH(0);    # stack: i
LABEL('i');

    # Increment i
    PUSH(1);
    ADD();

    # Inner loop: take j from 1 to n
    PUSH(0);    # stack: j i
    LABEL('j');

        # Increment j
        PUSH(1);
        ADD();

        # Skip all this if i == j
        PUSH(3);    # stack: 3 j i
        SWAP();     # stack: j 3 i
        STORE();    # stack: i
        DUPE();     # stack: i i
        PUSH(3);    # stack: 3 i i
        RETR();     # stack: j i i
        SUBT();     # stack: i-j i
        PUSH(3);    # stack: 3 i-j i
        RETR();     # stack: j i-j i
        SWAP();     # stack: i-j j i
        JMPZ('after_add');

        # Get copies of i/j and multiply them
        PUSH(3);    # stack: 3 j i
        SWAP();     # stack: j 3 i
        STORE();    # stack: i
        DUPE();     # stack: i i
        PUSH(3);    # stack: 3 i i
        RETR();     # stack: j i i
        MULT();     # stack: i*j i
        PUSH(3);    # stack: 3 i*j i
        RETR();     # stack: j i*j i
        SWAP();     # stack: i*j j i

        # Fetch the running total from slot 2, add, and store
        PUSH(2);
        RETR();     # stack: sum i*j j i
        ADD();      # stack: newsum j i
        PUSH(2);
        SWAP();     # stack: newsum 2 j i
        STORE();    # stack: j i

      LABEL('after_add');

        # Redo the loop if j < n..  i.e. j - n < 0
        DUPE();     # stack: j j i
        PUSH(1);
        RETR();     # stack: target j j i
        SUBT();     # stack: j-target j i
        JMPLZ('j');

    POP();      # stack: i

    # Redo the loop if i < n; same thing really
    DUPE();     # stack: i i
    PUSH(1);
    RETR();     # stack: target i i
    SUBT();     # stack: i-target i
    JMPLZ('i');

# Fetch the answer and print it
PUSH(2);
RETR();     # stack: sum
WNUM();

# Print newline and exit
PUSH(10);
WCHAR();
EXIT();
