#!/usr/bin/env bash
set -euo pipefail

# Run from any directory. No Python or Node installation is needed.
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
cd -- "$repo_dir"

compile_cv() {
  typst compile --root capybara --ignore-system-fonts \
    "capybara/src/$1.typ" "capybara/$1.pdf"
}

case "${1:-both}" in
  full) compile_cv cv ;;
  short) compile_cv cv-short ;;
  both) compile_cv cv; compile_cv cv-short ;;
  links) ;; # Refresh after a Tinymist export or direct Typst compilation.
  *) echo "Usage: bash capybara/scripts/build.sh [both|full|short|links]" >&2; exit 2 ;;
esac

# Hash the final PDF bytes, including their metadata. Identical files keep the
# same version; a changed PDF gets a different URL even within the same day.
for pdf in capybara/cv.pdf capybara/cv-short.pdf; do
  if [[ ! -s "$pdf" ]]; then
    echo "Missing or empty PDF: $pdf. Build both CVs first." >&2
    exit 1
  fi
done
full_hash=$(sha256sum capybara/cv.pdf)
full_hash=${full_hash:0:16}
short_hash=$(sha256sum capybara/cv-short.pdf)
short_hash=${short_hash:0:16}

temp_file=$(mktemp)
trap 'rm -f -- "$temp_file"' EXIT

# Only rewrite local CV hrefs, leaving other asset versions and external URLs
# untouched. Also discover new, untracked pages that are not ignored by Git.
while IFS= read -r -d '' page; do
  sed -E \
    -e "s|(href=[\"']/capybara/cv\\.pdf)(\\?v=[[:alnum:]._-]+)?([\"'])|\\1?v=$full_hash\\3|g" \
    -e "s|(href=[\"']/capybara/cv-short\\.pdf)(\\?v=[[:alnum:]._-]+)?([\"'])|\\1?v=$short_hash\\3|g" \
    "$page" > "$temp_file"
  if ! cmp -s -- "$page" "$temp_file"; then
    cat -- "$temp_file" > "$page"
    echo "Updated CV links: $page"
  fi
done < <(git ls-files --cached --others --exclude-standard -z -- '*.html')

echo "CV link versions: full=$full_hash short=$short_hash"
