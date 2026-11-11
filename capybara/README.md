# Curriculum vitae

Two traditional academic CVs share one content file:

- `cv.pdf`: full CV (five pages), built by CI and linked by the website.
- `cv-short.pdf`: abbreviated CV (two pages).

Both versions include all publication entries, grouped by publication status,
and the same bioinformatics tools list. The short CV selects entries and omits
some complete details, keeping the full CV's wording except for concise
presentation-topic summaries. Research Software and Resources appears only in
the full CV, leaving room for larger type and more spacing in the short CV.
The short CV also omits the header's Research Interests paragraph; both versions
retain the detailed PhD research description under Education.
The short CV uses 10.25-point body text and 13-point section headings. Dates sit
in a left column, with titles and descriptions aligned together in the right
column, as in the full CV. Margins of 17 mm horizontally and 15 mm vertically
keep the indented layout within two pages.
The PhD research description appears above the thesis title in both versions.
The short CV uses 0.4em line leading and 0.4em entry spacing, with larger 0.6em
gaps in Employment History and Teaching and Mentoring. The compact skills rows
use 0.3em spacing. This keeps distinct roles separated within two pages without
reducing the font size.
Selected presentations show the year, conference, oral presentation type, and
research subject, with a link on the conference name. Exact dates, session codes,
full titles, author lists, and the BAGECO flash talk remain in the full CV.
All publication entries remain in both versions, with 0.25em list spacing in
the short CV to keep it within two pages.
It retains all three reviewing journals, efestus leadership and TechShift Summit
participation, and HIDA-sponsored instructor training. The BSc entry includes
specialisations, GPA, rank, the 600-hour research thesis and its title, and the supervisor.
Both versions include the 2026 evaluator role at the 34th SIICUSP under Academic
Service. The full CV adds the official Portuguese event name; the short CV uses
only the shared opening text, with the subsection label and year inline.

Each PDF has a link beside the name to open the other version on the website.
The links also work from downloaded copies with internet access; publish both PDFs together.
Page counts describe the current content; review pagination after adding details.

## Files

```text
capybara/
├── src/
│   ├── content.typ    # All CV content, funding calculations, and section order
│   ├── style.typ      # Typography, icons, colours, and layout helpers
│   ├── cv.typ         # Full CV entry point
│   └── cv-short.typ   # Abbreviated CV entry point
├── data/
│   └── metrics.json   # Citation counts and actual snapshot dates
├── scripts/
│   ├── build.sh       # Build PDFs and versioned website into _site/
│   └── check-site.py  # Validate hashes, download links, and metadata
└── README.md
```

## Editing

Use British English in CV prose and labels. Preserve the original spelling of
published paper and presentation titles, official project and course names, and
URLs. Both PDFs use the British English language setting.

Most edits belong in [`src/content.typ`](src/content.typ). Comment banners mark
sections, with funding records, bibliography entries, and presentation citations
alongside the functions that display them. Search for the section name to jump
to it. The header and research interests are at the beginning; `document()` at
the end controls section order and page breaks.

Each section takes a `short` argument. Keep a single shared wording for every
included sentence, entry title, and link label. Use `if not short` or entry
selection to omit details; presentation-topic summaries are the exception to
shared wording and must remain faithful to the full titles. Formatting
may differ: combine bullets into paragraphs, place dates inline, or omit
subheadings. Version-switch links, document metadata, and footer labels also
differ by version.
The two entry files only call `document()` with the appropriate option.

- Edit [`src/style.typ`](src/style.typ) for fonts, colours, icons, and spacing.
- Edit [`data/metrics.json`](data/metrics.json) for citation counts and their
  actual retrieval dates.
- Update publication entries and their status grouping when a preprint or
  accepted paper is published.
- Rebuild both PDFs after editing and check their pagination.

## Build and deployment

[The Pages workflow](../.github/workflows/pages.yml) runs on pull requests,
pushes to `main`, and manual dispatch. It installs **Typst 0.14.2**, compiles both
CVs, and validates the complete site artifact before uploading it. Only builds
on `main` deploy to GitHub Pages. Failed builds leave the live site unchanged.

The repository's Pages publishing source must be **GitHub Actions**, with
`breno.science` retained as the custom domain. No generated PDFs, link manifests,
or versioned HTML need to be committed. The Spotify workflow continues to update
its separate data branch independently.

The build writes only `_site/`, containing public assets, the two PDFs, and
`capybara/cv-versions.json`. It never edits source HTML or local preview PDFs.
The uploaded `github-pages` artifact is available from the workflow run, and the
run summary lists both versioned download URLs. PR artifacts are for review;
their URLs do not become live unless deployed from `main`.

### Local previews

Open `src/cv.typ` or `src/cv-short.typ` in Tinymist to preview it. The VS Code tasks
**Preview full academic CV**, **Preview abbreviated academic CV**, and
**Preview both academic CVs** compile ignored PDFs under `capybara/` without
hashing or modifying website links. **Ctrl+Shift+B** previews both.

Tinymist uses `capybara/` as the root, disables system fonts, and exports to
`$root/$name`. Automatic export is disabled. The PDF export button remains
available. Preview PDFs link to the stable public CV URLs without a query string.

To preview directly:

```sh
typst compile --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
typst compile --root capybara --ignore-system-fonts capybara/src/cv-short.typ capybara/cv-short.pdf
```

To reproduce the CI artifact for troubleshooting, use Typst 0.14.2, Python 3,
Bash, Git, and standard GNU command-line tools:

```sh
bash capybara/scripts/build.sh
```

This optional check writes ignored `_site/` files; deployment hashes are always
computed again by CI. Normal editing requires no local publishing build.
Typst downloads the pinned packages on the first build and caches them outside
the repository. No separate font installation is needed.

## Website cache busting

The build versions two kinds of links:

- Website HTML links use the first 16 hexadecimal characters of each final PDF's
  SHA-256 hash, for example `/capybara/cv.pdf?v=<hash>`. Source HTML keeps plain
  paths; only the deployment copies get hashes.
- Links inside the PDFs use a shared hash of the CV sources, data, build script,
  and compiler version. This avoids a circular dependency between mutually
  linked PDFs. CI passes this value through Typst's `cv-link-version` input.

The deployed `capybara/cv-versions.json` exposes `full`, `short`, and `embedded`
hashes. The build also reports the PDF hashes through GitHub Actions outputs.
PDF creation timestamps use the commit timestamp (`SOURCE_DATE_EPOCH`), making
repeat builds of the same revision reproducible with the same compiler.

Both PDFs and all versioned pages deploy together. Previously downloaded PDFs
keep their embedded version; they cannot update links after a later deployment.

## Funding summary

The funding section in `src/content.typ` holds eight awards in their original
currencies. The full CV lists every award and reports the indicative total of
**€110,181**, with its scope and conversion rates. The abbreviated version lists
only three selected awards with their individual amounts in the original
currencies, plus the same indicative total across all eight awards, conversion
rates, and scope notes as the full CV.

The calculation uses fixed reporting rates from the previous CV:
BRL 1 = EUR 0.17 and USD 1 = EUR 0.85. These are not current market quotes;
their source/date and the full award periods still need confirmation.
Cash prizes, estimated sponsored-training values, and consortium budgets are
excluded. Google and FAPESP fellowships appear in the funding section;
prizes and sponsored training are listed separately under Honours and Awards.
Public grant records establish the award or project but may not publish its value.

## Citation metrics

`data/metrics.json` stores Google Scholar and Scopus values separately from the
content. Update each source's counts and `as_of` date together after retrieval.
Compilation never refreshes the statistics or changes their dates automatically.

A future update script can write this JSON before compilation. It should update
each date only after a successful retrieval and retain previous values on failure.
CI compiles the CVs using the committed metrics; no automatic metrics fetching is configured.

## Fonts, icons, and attribution

Text and headings use **Libertinus Serif**, embedded in Typst and Tinymist.
System-font discovery is disabled for consistent output across machines.
No font files or icon assets are stored in this repository.

Packages are pinned in the sources:

- [`heroic:0.1.2`](https://typst.app/universe/package/heroic/0.1.2/) supplies
  general-purpose contact icons, including the Scholar graduation cap.
- [`scienceicons:0.1.0`](https://typst.app/universe/package/scienceicons/0.1.0/)
  supplies ORCID, GitHub, and LinkedIn logos.
- [`metalogo:1.2.0`](https://typst.app/universe/package/metalogo/1.2.0/) supplies
  the LaTeX wordmark in Technical Skills.

The icon packages include their graphics and licence information and need no
icon fonts. The `icon` and `field` helpers apply the CV's purple colour and alignment.
