#!/bin/sh
set -eu

if [ "$(uname)" = "Darwin" ]; then
  now=$(date -v-1m '+%Y%m')
else
  now=$(date -d '1 month ago' '+%Y%m')
fi

target="data/${now}.md"
[ -f "$target" ] || { echo "File not found: $target" >&2; exit 1; }

{
  echo "${now}のレポート"
  echo ""
  awk '{print $2}' "$target" | sort | uniq -c | sort -rn | \
    awk '{print NR"位", $2 "(" $1 "回)"}'
} > "report/${now}"

