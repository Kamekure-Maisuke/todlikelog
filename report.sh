#!/bin/sh
set -eu

uname | grep -q "Darwin" && {
  now=$(date -v-1m '+%Y%m')
} || {
  now=$(date -d '1 month ago' '+%Y%m')
}

target=$(find data -type f | grep "$now")

showReport(){
  echo "$now"のレポート
  echo ""

  cut -d ' ' -f2 $target |
  sort |
  uniq -c | 
  sort -r |
  awk '
  {
    print NR"位", $2 "(" $1 "回)"
  }
  '
}

showReport > report/"$now"
