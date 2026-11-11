#!/usr/bin/env bash
set -euo pipefail

# Build the deployment artifact without rewriting source HTML or local previews.
repo_dir=$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")/../.." && pwd)
cd -- "$repo_dir"
if [[ $# -gt 0 ]]; then
  echo "Usage: bash capybara/scripts/build.sh (writes _site/)" >&2
  exit 2
fi

# Pin PDF creation metadata to the revision rather than the runner's wall clock.
export SOURCE_DATE_EPOCH=${SOURCE_DATE_EPOCH:-$(git log -1 --format=%ct)}
source_version() {
  local digest
  digest=$(
    {
      typst --version
      sha256sum capybara/scripts/build.sh
      find capybara/src capybara/data -type f -print0 \
        | LC_ALL=C sort -z | xargs -0 sha256sum
    } | sha256sum
  )
  printf '%s' "${digest:0:16}"
}

link_version=$(source_version)
build_dir=$(mktemp -d)
trap 'rm -rf -- "$build_dir"' EXIT
site_dir="$build_dir/site"
mkdir -p "$site_dir/capybara"

# Copy only public assets, never sources or old local preview PDFs.
cp -- index.html style.css spotify.css robots.txt sitemap.xml CNAME \
  google*.html "$site_dir/"
cp -R -- js imgs works events faq "$site_dir/"

echo "Building both CVs with embedded link version $link_version"
for name in cv cv-short; do
  typst compile --root capybara --ignore-system-fonts \
    --input "cv-link-version=$link_version" \
    "capybara/src/$name.typ" "$site_dir/capybara/$name.pdf"
done
if [[ "$(source_version)" != "$link_version" ]]; then
  echo "CV inputs changed during compilation; run the build again." >&2
  exit 1
fi

# HTML links identify the final PDF bytes. PDF-to-PDF links use the shared
# source hash because hashing mutually linked final PDFs would be circular.
full_hash=$(sha256sum "$site_dir/capybara/cv.pdf")
full_hash=${full_hash:0:16}
short_hash=$(sha256sum "$site_dir/capybara/cv-short.pdf")
short_hash=${short_hash:0:16}
while IFS= read -r -d '' page; do
  sed -i -E \
    -e "s|(href=[\"']/capybara/cv\\.pdf)(\\?v=[[:alnum:]._-]+)?([\"'])|\\1?v=$full_hash\\3|g" \
    -e "s|(href=[\"']/capybara/cv-short\\.pdf)(\\?v=[[:alnum:]._-]+)?([\"'])|\\1?v=$short_hash\\3|g" \
    "$page"
done < <(find "$site_dir" -type f -name '*.html' -print0)
printf '{"full":"%s","short":"%s","embedded":"%s"}\n' \
  "$full_hash" "$short_hash" "$link_version" > "$site_dir/capybara/cv-versions.json"

python3 capybara/scripts/check-site.py "$site_dir"
# Preserve any previous artifact if compilation or validation fails.
rm -rf -- "$repo_dir/_site"
mv -- "$site_dir" "$repo_dir/_site"

echo "CV link versions: full=$full_hash short=$short_hash"
if [[ -n "${GITHUB_OUTPUT:-}" ]]; then
  printf 'full_hash=%s\nshort_hash=%s\n' "$full_hash" "$short_hash" >> "$GITHUB_OUTPUT"
fi
