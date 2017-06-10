set -uex

REGEXP=$(jq .xensource_log.regex.xensource_log.pattern xensource.json | sed 's/\\\\/\\/g' | sed 's/^"\(.*\)"$/\1/')

pcregrep --quiet --regexp="$REGEXP" test/test_match/xensource.log
(! pcregrep --regexp="$REGEXP" --invert-match test/test_match/xensource.log)

for group in $(cat test/test_captures/capturing_groups); do
  perl -pe "s/$REGEXP/\$+{$group}/" < test/test_captures/xensource.log > /tmp/output
  diff test/test_captures/expected_matches/$group /tmp/output
done
