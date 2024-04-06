#!bin/bash

set -eu

echo 'Start test mj!'

SUBSCRIBE_URL=''

COLOR_GREEN='\033[0;32m'
COLOR_RED='\033[0;31m'
COLOR_NO='\033[0m'

test_trojan () {
  local line=$1

  local port=$(echo $line | cut -f 1 -d '#' | ggrep -oP ':\K\d+')
  local origin=$(echo $line | grep -oE "@(.*):$port" | cut -c 2-)
  # echo $origin

  local resp=$(curl -sI --connect-timeout 3 -m 5 -w "http_code:%{http_code} total_time:%{time_total}" -o /dev/null "https://"$origin | sed 's/^.//')
  # echo $resp
  
  local status=`echo $resp | ggrep -oP 'http_code:\K(\d+)'`
  local total_time=$(echo $resp | ggrep -oP 'total_time:\K(\d+(\.\d+)?)')
  # echo "$status, $total_time"

  if [[ $status -eq 200 && $(echo "$total_time < 3" | bc -l) -eq 1 ]]; then
    prefix="${COLOR_GREEN}[SUCCESS]${COLOR_NO}"
  else
    prefix="${COLOR_RED}[FAILED]${COLOR_NO} "
  fi
  
  printf "$prefix %s %s\n" "$origin" "$resp"
}

test_vmess () {
  local line=$1
  local json=$(echo $line | cut -c 9- | base64 -d | jq -c 'del(.ps, .v)')
  # echo $json

  local host=$(echo $json | jq -r '.add')
  local port=$(echo $json | jq -r '.port')
  local user_id=$(echo $json | jq -r '.id')
  # echo "$host, $port, $user_id"

  local ping_rs=$(nc -vz -G 3 -J 1 $host $port 2>&1)
  # echo $ping_rs
  if [[ $? == 0 ]]; then
    prefix="${COLOR_GREEN}[SUCCESS]${COLOR_NO}"
  else
    prefix="${COLOR_RED}[FAILED]${COLOR_NO}"
  fi

  printf "$prefix %s\n" "$json"
}


lines=($(curl -s -m 5 $SUBSCRIBE_URL | base64 -D))

for line in "${lines[@]}"
do
  # echo $line 
  
  if [[ $line =~ ^trojan.* ]]; then
    test_trojan $line
  elif [[ $line =~ ^vmess.* ]]; then
    test_vmess $line
  # else
    # echo 'Unable to parse protocol'
  fi
done

echo ''
