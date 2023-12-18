#!bin/bash

set -eux

SUBSCRIBE_URL='{SUB_URL}'
COLOR_GREEN='\033[0;32m'
COLOR_NO='\033[0m'


lines=($(curl -s -m 5 $SUBSCRIBE_URL | base64 -D))

for line in "${lines[@]}"
do
  # echo $line 
  port=$(echo $line | cut -f 1 -d '#' | ggrep -oP ':\K\d+')
  origin=$(echo $line | grep -oE "@(.*):$port" | cut -c 2-)

  resp=$(curl -sI --connect-timeout 3 -m 5 -w "http_code:%{http_code} total_time:%{time_total}" -o /dev/null "https://"$origin | sed 's/^.//')
  # echo $resp
  
  status=$(echo $resp | ggrep -oP 'http_code:\K(\d+)')
  total_time=$(echo $resp | ggrep -oP 'total_time:\K(\d+(\.\d+)?)')
  # echo "$status, $total_time"

  if [[ $status -eq 200 && $(echo "$total_time < 3" | bc -l) -eq 1 ]]; then
    color=$COLOR_GREEN
  else
    color=$COLOR_NO
  fi
  
  printf "${color}Testing $origin: $resp $COLOR_NO\n"
done
