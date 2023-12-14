


lines=$(curl -s -m 5 $SUBSCRIBE_URL | base64 -D)
# echo $lines

IFS='
'
for line in $lines
do
  port=$(echo $line | cut -f 1 -d '#' | ggrep -oP ':\K\d+')
  d=$(echo $line | grep -oE "@(.*):$port" | cut -c 2-)

  resp=$(curl -sI --connect-timeout 3 -m 5 -w "http_code:%{http_code} total_time:%{time_total}" -o /dev/null "https://"$d | sed 's/^.//')
  echo "Testing $d: $resp"
done
