#!/usr/bin/env sh
BASEDIR=$(dirname "$0")
cd "$BASEDIR" || exit 1

RED='\033[0;31m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
NORMAL='\033[0m'


# make a temp dir and copy the input file to it
TEMPDIR=$(mktemp -d 2>/dev/null || mktemp -d -t "test_dir")
cp ./input.vm "$TEMPDIR"/file_mutated_by_tests.vm

# run the script we want to test
yes | ../report-updater.sh "$TEMPDIR"

# check if the output matches what we expected
INPUT="$TEMPDIR"/file_mutated_by_tests.vm
OUTPUT=./expected_output.vm

echo "$BLUE""INPUT:                                                          OUTPUT:$NORMAL"
if diff --side-by-side "$INPUT" "$OUTPUT" ; then
    rm -rf "$TEMPDIR"
    echo "$GREEN""TESTS PASS"
else
    rm -rf "$TEMPDIR"
    echo "$RED""TESTS FAIL"
    exit 1
fi
