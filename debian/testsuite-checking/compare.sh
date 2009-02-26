#!/bin/bash

if [ $# -ne '2' ]; then
  echo -e "\nUsage: Compare a test-expected-* file and a test-results-* file."
  echo -e "$0 : < Expected testsuite results > < Testsuite results >\n";
  exit 1
fi;

expected=$(tempfile)
results=$(tempfile)
sort $1 | grep -Ev '^ *$|^#' > $expected
sort $2 | grep -Ev '^ *$|^#' > $results

REGRESSIONS=$(diff -wBI '^#.*' $expected $results | sed -e '/^>/!d;s/^> //g')
PROGRESSIONS=$(diff -wBI '^#.*' $expected $results | sed -e '/^</!d;s/^< //g')
if [ -n "$REGRESSIONS" ] ; then
  echo "Encountered regressions that don't match expected failures:"
  echo "$REGRESSIONS"
  for test in $(echo "$REGRESSIONS" | sed -e's/, Error.*//')
  do
    echo TEST $test:
    find . -name "$test" | xargs -r cat
  done
  rv=1
else
  echo "Passed regression testing. No new failures, no changed error values."
  for test in $(sed -n '/^[^#]/s/, Error.*//p' $results)
  do
    echo TEST $test:
    find . -name "$test" | xargs -r cat
  done
  rv=0
fi

if [ -n "$PROGRESSIONS" ] ; then
  echo "Encountered progressions that don't match expected failures:"
  echo "$PROGRESSIONS"
fi

rm -f $expected $results
exit 0
exit $rv
