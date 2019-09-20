#!/usr/bin/env sh
BASEDIR=$(dirname "$0")
cd "$BASEDIR" || exit


# make a temp dir and copy the input file to it
TEMPFILE=$(mktemp -d 2>/dev/null || mktemp -d -t "test_dir")
cp ./input.vm "$TEMPFILE"/input.vm

# run the script we want to test
yes | ../report-updater.sh "$TEMPFILE"

# check if the output matches what we expected
diff --side-by-side --width "$(tput cols)" "$TEMPFILE"/input.vm ./output.vm
