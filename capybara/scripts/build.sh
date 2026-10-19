#!/usr/bin/env bash
set -euo pipefail

# Run from any directory. No Python or Node installation is needed.
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
cd -- "$repo_dir"

case "${1:-both}" in
  full|short|both|links) ;; # All modes rebuild the linked pair together.
  *) echo "Usage: bash capybara/scripts/build.sh [both|full|short|links]" >&2; exit 2 ;;
esac

# PDF-to-PDF links use a shared source hash: hashing mutually linked final PDFs
# would create a circular dependency. Exclude the generated version manifest.
source_version() {
  local digest
  digest=$(
    {
      typst --version
      sha256sum capybara/scripts/build.sh
      find capybara/src capybara/data -type f \
        ! -path capybara/data/cv-link-version.json -print0 \
        | LC_ALL=C sort -z | xargs -0 sha256sum
    } | sha256sum
  )
  printf '%s' "${digest:0:16}"
}

link_version=$(source_version)
build_dir=$(mktemp -d)
trap 'rm -rf -- "$build_dir"' EXIT

echo "Building both CVs with embedded link version $link_version"
for name in cv cv-short; do
  typst compile --root capybara --ignore-system-fonts \
    --input "cv-link-version=$link_version" \
    "capybara/src/$name.typ" "$build_dir/$name.pdf"
done
if [[ "$(source_version)" != "$link_version" ]]; then
  echo "CV inputs changed during compilation; run the build again." >&2
  exit 1
fi

# Publish local build outputs only when both compilations succeed. The manifest
# lets Tinymist previews and direct exports use the last successful link version.
printf '{"version":"%s"}\n' "$link_version" > "$build_dir/cv-link-version.json"
for name in cv cv-short; do
  mv -- "$build_dir/$name.pdf" "capybara/$name.pdf"
done
if ! cmp -s -- "$build_dir/cv-link-version.json" capybara/data/cv-link-version.json; then
  mv -- "$build_dir/cv-link-version.json" capybara/data/cv-link-version.json
fi

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

temp_file="$build_dir/page.html"

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
