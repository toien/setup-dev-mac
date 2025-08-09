#!bin/bash

set -eu

echo 'Start test ss!'


COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_NO='\033[0m'


lines=($(curl -s -m 10 $SUBSCRIBE_URL | base64 -D))

for line in "${lines[@]}"
do
  # echo $line 
  port=$(echo $line | cut -f 1 -d '#' | grep -oE ':(\d+)' | cut -c 2-)
  origin=$(echo $line | grep -oE "@(.*):$port" | cut -c 2-)

  resp=$(curl -sI --connect-timeout 3 -m 5 -w "http_code:%{http_code} total_time:%{time_total}" -o /dev/null "https://"$origin | sed 's/^.//')
  # echo $resp
  
  status=$(echo $resp | grep -oE 'http_code:([0-9]+)' | sed 's/http_code://')
  total_time=$(echo $resp | grep -oE 'total_time:([0-9]+([.0-9]+)?)' | sed 's/total_time://')
  # echo "$status, $total_time"

  if [[ $status -eq 200 && $(echo "$total_time < 3" | bc -l) -eq 1 ]]; then
    prefix="${COLOR_GREEN}[SUCCESS]${COLOR_NO}"
  else
    prefix="${COLOR_RED}[FAILED]${COLOR_NO} "
  fi
  
  printf "$prefix %s %s\n" "$origin" "$resp"
done

echo ''
