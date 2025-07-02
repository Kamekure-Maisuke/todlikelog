#!/bin/sh
set -eu

now=$(date '+%Y%m')
last=$(echo $now "-1" | bc)

target=$(find data -type f | grep "$last")

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

showReport > report/"$last"
