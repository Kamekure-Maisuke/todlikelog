#!/bin/sh
set -eu

now=$(date '+%Y%m%d%H%M%S')
ym=$(echo "$now" | cut -c -6)

find data -type f | grep -q "$ym" || {
  touch "data/${ym}.md"
}

getMembers(){
  echo "白石麻衣"
  echo "丹生明里"
  echo "賀喜遥香"
  echo "守屋麗奈"
  echo "弓木奈於"
}
memberCount=$(getMembers | wc -l)
rand=$(awk -v mc="$memberCount" 'BEGIN{srand(); print int(rand()*mc)+1}')
getMembers |
awk -v line="$rand" -v now="$now" 'NR==line{print now, $1}' >> "data/${ym}.md"