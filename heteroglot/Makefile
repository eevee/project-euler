# This Makefile is reserved for EXTREMELY obscure cases, where there simply is
# no compiler or interpreter that will compile or run a single input file.
#
# Obviously this file contains ONLY build coaxing, and NOT anything related to
# implementing an actual solution.
#
# Targets are named after the problem numbers, including the zero padding.
.PHONY: all
all:
	echo "This makefile has no 'all' target."


# Problem 17 (inform7)
#
# Compiling inform7 starts with running an inform7-to-inform6 translator called
# "ni".  It is the only such translator, its source is not available, and it
# has no documentation aside from "whatever the GUI wrapper does".  As far as I
# can tell, it's completely impossible to stick a single file in and get a
# single file out; it expects to have a simple directory structure available
# for dumping various build cruft into.
#
# So, this replicates the structure it expects.  Pared down somewhat from here:
# http://wiki.hacdc.org/index.php/Talk:Writing_Interactive_Fiction_with_Inform_7

# These are the paths on my machine.  See the link above for where stuff might
# end up on OS X.
INFORM7_NI=/usr/libexec/gnome-inform7/ni
INFORM7_ROOT=/usr/share/gnome-inform7
INFORM7_INFORM6=/usr/libexec/gnome-inform7/inform6
.PHONY: 017
017:
	$(eval INFORM7_TEMPDIR := $(shell mktemp -t -d inform7-XXXXXXXX))
	echo $(INFORM7_TEMPDIR)
	mkdir -p $(INFORM7_TEMPDIR)/{Build,Source,Index}
	cp 017.ni $(INFORM7_TEMPDIR)/Source/story.ni

	# Compile inform7 to inform6
	$(INFORM7_NI) -internal $(INFORM7_ROOT) -format=z8 -project $(INFORM7_TEMPDIR)

	# Compile inform6 to a z-machine blob
	$(INFORM7_INFORM6) -w -v8 $(INFORM7_TEMPDIR)/Build/auto.inf 017.z8

	# Clean up
	rm -r $(INFORM7_TEMPDIR)

	@echo
	@echo "All done!  Now you can run it with, e.g.: frotz 017.z8"
