# Curriculum vitae

Two traditional academic CVs share one content file:

- `cv.pdf`: full CV (five pages), linked by the website.
- `cv-short.pdf`: abbreviated CV (two pages).

Both versions include all publication entries, grouped by publication status,
and the same bioinformatics tools list. The short CV selects entries and omits
some complete details, keeping the full CV's wording except for concise
presentation-topic summaries. It uses 10-point body text, aligned dates beside
role or award headings, and full-width description paragraphs underneath.
Selected presentations show the year, conference, oral presentation type, and
research subject, with a link on the conference name. Exact dates, session codes,
full titles, author lists, and the BAGECO flash talk remain in the full CV.
All publication entries remain in both versions, with tighter list spacing in
the short CV to keep it within two pages.
It retains all three reviewing journals, efestus leadership and TechShift Summit
participation, and HIDA-sponsored instructor training. The BSc entry includes
specialisations, GPA, rank, the 600-hour research thesis and its title, and the supervisor.

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
│   ├── metrics.json   # Citation counts and actual snapshot dates
│   └── cv-link-version.json # Generated version for links inside the PDFs
├── scripts/
│   └── build.sh       # Compile PDFs and refresh website CV link hashes
├── cv.pdf             # Website download
├── cv-short.pdf       # Abbreviated academic CV
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
- Missing information is marked with `// TODO[ID]: ...` comments in
  `src/content.typ`. These comments never appear in the PDFs. Fill them with
  verified information and remove each resolved comment.
- Update publication entries and their status grouping when a preprint or
  accepted paper is published.
- Rebuild both PDFs after editing and check their pagination.

## Build

### VS Code

Open `src/cv.typ` or `src/cv-short.typ` to preview the corresponding CV.
Press **Ctrl+Shift+B** to build both PDFs. The existing tasks
**Terminal → Run Task → Build full academic CV** or
**Build abbreviated academic CV** now also rebuild both versions, so their
embedded links stay in sync. All build tasks refresh the website's CV links too.

The repository's VS Code settings configure Tinymist's project root as
`capybara/`, so sources in `src/` can read `data/metrics.json`.
Click Tinymist's **PDF** export button to export the current CV, or run the build
task after editing. Automatic export is disabled. The `tinymist.outputPath`
setting (`$root/$name`) makes the PDF button write to `capybara/`, matching the
build tasks and the website's download paths.
Tinymist's PDF button does not run the build script. After exporting with that
button, run **Terminal → Run Task → Refresh CV links**, or use
**Ctrl+Shift+B** to compile and refresh together.
The refresh task also rebuilds both PDFs. Tinymist previews and direct exports
use the embedded link version saved by the last successful build.

### Command line

From the repository root, with Typst, Bash, Git, and standard command-line tools
(`sha256sum`, `sed`, `cmp`, and `mktemp`) available:

```sh
bash capybara/scripts/build.sh both
```

The `full`, `short`, and `links` arguments remain supported, but all modes now
compile both linked PDFs. The script replaces the local PDFs and refreshes the
website links only after both compilations succeed.

Direct Typst compilation also works for previews. Before publishing, run the
build script to refresh the embedded versions and website links:

```sh
typst compile --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
typst compile --root capybara --ignore-system-fonts capybara/src/cv-short.typ capybara/cv-short.pdf
bash capybara/scripts/build.sh links
```

For automatic rebuilding while editing:

```sh
typst watch --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
```

After stopping the watcher, run `bash capybara/scripts/build.sh links` before publishing.

On Nix, the compiler can be run without installing it into your profile:

```sh
nix shell nixpkgs#typst --command bash capybara/scripts/build.sh both
```

`--root capybara` allows the compiler to read the sibling `src/` and `data/`
folders. Supply an output path to keep generated PDFs outside `src/`.

Validated with Typst **0.14.2**. Pin this compiler version when setting up CI for
consistent layout. Typst downloads the pinned packages on the first build
and stores them in its normal package cache, outside this repository. That first
build needs internet access; subsequent builds can use the cache. No separate
font installation, icon download, or asset folder is needed.

## Website cache busting

`scripts/build.sh` versions both kinds of CV links:

- Links inside the PDFs use the first 16 hexadecimal characters of a shared
  SHA-256 hash of the source and data files, build script, and Typst version.
  Changing any of these inputs updates both PDFs' embedded links, including the
  short CV's funding-detail link. Unchanged inputs keep the same embedded version.
- Website HTML links use each final PDF's own SHA-256 prefix. Recompilation can
  change these hashes through PDF metadata even when the visible text stays the same.

The shared version is computed before compilation, passed to Typst, and saved to
`data/cv-link-version.json` after a successful build. This generated file is
excluded from the hash inputs and should be committed with the PDFs. Using the
source hash inside the PDFs avoids a circular dependency: putting each final
PDF's hash into the other would change both hashes again.

Publish the updated HTML and PDFs together. The script edits local files; it
does not commit, push, or deploy. Previously downloaded PDFs keep their embedded
version; they cannot update links when a later edition is published.

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
No API fetching or CV compilation GitHub Actions workflow is configured yet.

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
