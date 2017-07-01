set -uex

# Extract the regular expression from the format file
REGEXP=$(jq .xensource_log.regex.xensource_log.pattern xensource.json | sed 's/\\\\/\\/g' | sed 's/^"\(.*\)"$/\1/')

# Test that the regexp is correct and matches at least one line in the test log
pcregrep --quiet --regexp="$REGEXP" test/test_match/xensource.log
# Test that the regexp matches every line in the test log
(! pcregrep --regexp="$REGEXP" --invert-match test/test_match/xensource.log)

# For each capture group, extract it from every line, and compare the output to
# the expected result
for group in $(cat test/test_captures/capturing_groups); do
  perl -pe "s/$REGEXP/\$+{$group}/" < test/test_captures/xensource.log > /tmp/output
  diff test/test_captures/expected_matches/$group /tmp/output
done
