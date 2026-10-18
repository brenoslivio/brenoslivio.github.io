# Curriculum vitae

Two traditional academic CVs share one content file:

- `cv.pdf`: full CV (five pages), linked by the website.
- `cv-short.pdf`: abbreviated CV (two pages).

Both versions include all publication entries, grouped by publication status,
and the same bioinformatics tools list. The short CV abbreviates other sections
and uses 10-point body text with tighter spacing to fit two pages.

Each PDF has a link beside the name to open the other version on the website.
The links also work from downloaded copies with internet access; publish both PDFs together.
Page counts describe the current content; review pagination after adding details.

## Files

```text
capybara/
├── src/
│   ├── content.typ    # All CV content, funding calculations, and section order
│   ├── style.typ      # Typography, icons, colors, and layout helpers
│   ├── cv.typ         # Full CV entry point
│   └── cv-short.typ   # Abbreviated CV entry point
├── data/
│   └── metrics.json   # Citation counts and actual snapshot dates
├── cv.pdf             # Website download
├── cv-short.pdf       # Abbreviated academic CV
└── README.md
```

## Editing

Most edits belong in [`src/content.typ`](src/content.typ). Comment banners mark
sections, with funding records, bibliography entries, and presentation citations
alongside the functions that display them. Search for the section name to jump
to it. The header and research interests are at the beginning; `document()` at
the end controls section order and page breaks.

Each section takes a `short` argument. Shared text appears in both versions;
`if short` and `if not short` select abbreviated and full details. The two entry
files only call `document()` with the appropriate option.

- Edit [`src/style.typ`](src/style.typ) for fonts, colors, icons, and spacing.
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
Press **Ctrl+Shift+B** to build both PDFs. To build just one, use
**Terminal → Run Task → Build full academic CV** or
**Build abbreviated academic CV**.

The repository's VS Code settings configure Tinymist's project root as
`capybara/`, so sources in `src/` can read `data/metrics.json`.
Click Tinymist's **PDF** export button to export the current CV, or run the build
task after editing. Automatic export is disabled. The `tinymist.outputPath`
setting (`$root/$name`) makes the PDF button write to `capybara/`, matching the
build tasks and the website's download paths.

### Command line

From the repository root, with the Typst CLI installed:

```sh
typst compile --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
typst compile --root capybara --ignore-system-fonts capybara/src/cv-short.typ capybara/cv-short.pdf
```

For automatic rebuilding while editing:

```sh
typst watch --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
```

On Nix, the compiler can be run without installing it into your profile:

```sh
nix shell nixpkgs#typst --command typst compile --root capybara --ignore-system-fonts capybara/src/cv.typ capybara/cv.pdf
```

`--root capybara` allows the compiler to read the sibling `src/` and `data/`
folders. Supply an output path to keep generated PDFs outside `src/`.

Validated with Typst **0.14.2**. Pin this compiler version when setting up CI for
consistent layout. Typst downloads the pinned packages on the first build
and stores them in its normal package cache, outside this repository. That first
build needs internet access; subsequent builds can use the cache. No separate
font installation, icon download, or asset folder is needed.

## Funding summary

The funding section in `src/content.typ` holds eight awards in their original
currencies. Both CVs calculate the same total from all eight, even though the
abbreviated version lists only three selected awards. The current indicative
total is **€110,181**. The full CV lists every award and both versions explain
the scope and rates.

The calculation uses fixed reporting rates from the previous CV:
BRL 1 = EUR 0.17 and USD 1 = EUR 0.85. These are not current market quotes;
their source/date and the full award periods still need confirmation.
Cash prizes, estimated sponsored-training values, and consortium budgets are
excluded. Google and FAPESP fellowships appear in the funding section;
prizes and sponsored training are listed separately under Honors and Awards.
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

The icon packages include their graphics and license information and need no
icon fonts. The `icon` and `field` helpers apply the CV's purple color and alignment.
