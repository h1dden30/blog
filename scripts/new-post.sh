#!/usr/bin/env bash
# new-post.sh — scaffold a new post with frontmatter pre-filled.
# Usage: ./scripts/new-post.sh
set -euo pipefail

read -rp "Title: " title
read -rp "Type (research/blog/note): " type

if [[ ! "$type" =~ ^(research|blog|note)$ ]]; then
  echo "Type must be one of: research, blog, note" >&2
  exit 1
fi

read -rp "Tags (comma separated, optional): " tags_raw

slug=$(echo "$title" | tr '[:upper:]' '[:lower:]' | tr -s ' ' '-' | tr -cd 'a-z0-9-')
date=$(date +%Y-%m-%d)
file="_posts/${date}-${slug}.md"

if [[ -f "$file" ]]; then
  echo "File already exists: $file" >&2
  exit 1
fi

tags_yaml="[]"
if [[ -n "$tags_raw" ]]; then
  tags_yaml="[$(echo "$tags_raw" | sed 's/, */, /g')]"
fi

cat > "$file" <<EOF
---
title: "$title"
type: $type
tags: $tags_yaml
---

EOF

echo "Created $file"
"${EDITOR:-vim}" "$file"
