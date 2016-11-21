#! /bin/bash

# Throw away stderr since it has a bunch of diagnostic output from our I/O backend.
../../BUILD/xetex -fmt=trip -no-pdf -output-comment=trip trip >trip.fot 2>/dev/null
anybad=false

# Remove first line of log that contains a datestamp
mv trip.log trip.log.tmp
sed -e 1d trip.log.tmp >trip.log
rm -f trip.log.tmp

for f in trip.log trip.fot trip.xdv tripos.tex ; do
    if ! cmp $f reference-$f ; then
	echo >&2 "trip failed: file $f differs"
	anybad=true
    fi
done

$anybad && exit 1

rm -f 8terminal.tex trip.fot trip.log trip.xdv tripos.tex