[
    PROBLEM 17: Number letter counts

    If the numbers 1 to 5 are written out in words: one, two, three, four,
    five, then there are 3 + 3 + 5 + 4 + 4 = 19 letters used in total.

    If all the numbers from 1 to 1000 (one thousand) inclusive were written out
    in words, how many letters would be used?

    NOTE: Do not count spaces or hyphens. For example, 342 (three hundred and
    forty-two) contains 23 letters and 115 (one hundred and fifteen) contains
    20 letters. The use of "and" when writing out numbers is in compliance with
    British usage.
]
[
    A word on running this:

    The inform7 translator is extremely picky and simply cannot be coaxed into
    compiling a single file -- plus, there's a second pass to compile its
    output anyway.

    Left with no choice, I have written a Makefile solely for this program.
    You can compile this file into 017.z8 with:

        make 017

    Also, to comply with the rules, this MUST be run with a "dumb" z-machine
    interpreter -- that is, one that doesn't have a GUI or use curses or any of
    that fancy nonsense.  A common option is "dumb" Frotz, which at least for
    me, came bundled with regular Frotz as `dfrotz`.  So after building, just
    run:

        dfrotz 017.z8

    dfrotz in particular will still spit out two literal spaces before the
    answer, but I can't find any way around that -- it's specific to dfrotz and
    there's no flag to turn it off.
]

"Project Euler 17" by Eevee.

The story creation year is 2014.

Use the serial comma.

[This is to get rid of some extraneous default output.]
The display banner rule is not listed in the startup rulebook.
The initial room description rule is not listed in the startup rulebook.

[Get rid of the status line, which causes the room name to be printed.]
Rule for constructing the status line:
	rule succeeds.

[Remove the "are you sure?" prompt.]
The quit the game rule is not listed in the carry out quitting the game rulebook.

[Need a room to stick the player in, or this won't compile at all.]
X is a room.

[Yes, in fact, inform7 requires literal tabs for indentation here, and doesn't allow blank lines inside rules.  Alas.]
When play begins:
	[Remove the prompt entirely.  Can't do this declaratively, because it conflicts with the Standard Rules.]
	now the command prompt is "";
	[Alright, here we go, the actual problem!]
	let count be 0;
	repeat with n running from 1 to 1000:
		let letters be "[n in words]";
		repeat with i running from 1 to the number of characters in letters:
			if character number i in letters is in lower case:
				let count be count plus one;
	now the left hand status line is "[count]";
	say count;
	[Can't use "try quitting the game" here, because that asks for confirmation.]
	[This rule is what fires when you type QUIT at a game-over prompt.]
	abide by the immediately quit rule.
