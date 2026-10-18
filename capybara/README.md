# Curriculum vitae

Two traditional academic CVs share the same Typst content:

- `cv.typ` → `cv.pdf`: full CV (five pages), linked by the website.
- `cv-short.typ` → `cv-short.pdf`: abbreviated CV (two pages).

Page counts describe the current content; review pagination after adding details.
Missing information is marked with `// TODO[ID]: ...` comments in the sources.
These comments never appear in the PDFs. See [TODO.txt](TODO.txt) for the
prioritized checklist, funding reconciliation, and supporting sources.
See [SOURCES.txt](SOURCES.txt) for the funding and collaboration source audit,
including the limits of public verification and outstanding budget records.

```text
capybara/
├── cv.typ             # Full CV entry point
├── cv-short.typ       # Abbreviated CV entry point
├── sections/          # Shared sections with optional abbreviated content
├── layout/
│   ├── document.typ   # Shared section order and page boundaries
│   ├── header.typ     # Shared contacts and research interests
│   └── style.typ      # Typography, icons, colors, and layout helpers
├── data/
│   ├── funding.typ    # Award values, fixed reporting rates, calculated total
│   ├── publications.typ # Shared bibliographic entries
│   ├── presentations.typ # Full presentation citations
│   └── metrics.json   # Citation counts and actual snapshot dates
├── cv.pdf             # Website download
├── cv-short.pdf       # Abbreviated academic CV
├── TODO.txt           # Information to supply; never included in either PDF
├── SOURCES.txt        # Evidence and verification gaps for funding and awards
└── README.md
```

## Build

### VS Code

Press **Ctrl+Shift+B** to build both PDFs. To build just one, use
**Terminal → Run Task → Build full academic CV** or
**Build abbreviated academic CV**. Preview either PDF in VS Code.
Tinymist preview does not automatically export PDFs; run the build task after editing.

### Command line

From the repository root, with the Typst CLI installed:

```sh
typst compile --ignore-system-fonts capybara/cv.typ capybara/cv.pdf
typst compile --ignore-system-fonts capybara/cv-short.typ capybara/cv-short.pdf
```

For a live preview while editing:

```sh
typst watch --ignore-system-fonts capybara/cv.typ capybara/cv.pdf
```

On Nix, the compiler can be run without installing it into your profile:

```sh
nix shell nixpkgs#typst --command typst compile --ignore-system-fonts capybara/cv.typ capybara/cv.pdf
```

Validated with Typst **0.14.2**. Pin this compiler version when setting up CI for
consistent layout. Typst downloads the pinned icon packages on the first build
and stores them in its normal package cache, outside this repository. That first
build needs internet access; subsequent builds can use the cache. No separate
font installation, icon download, or asset folder is needed.
`cv.pdf` is the file linked by the website.

## Editing

- Edit the matching file in `sections/`. Each section exports a function with a
  `short` argument; shared text is rendered in both versions, while `if short`
  branches control selection and detail. Their order is in `layout/document.typ`.
- Edit `layout/header.typ` for contact details and research interests.
- Edit `layout/style.typ` to change typography, icons, colors, and spacing.
- Use `entry[date][content]` for dated entries and `cv-list([item], [item])` for lists.
- Publication text is in `data/publications.typ`; selection and status grouping
  are in `sections/publications.typ`. Update both when a preprint is published.
- Full talk citations are in `data/presentations.typ`; presentation selection and
  the abbreviated description are in `sections/presentations.typ`.
- Fill the TODO comments with verified facts, incorporate those facts into the
  visible entry, and remove the resolved comment and corresponding checklist item.
  Rebuild both PDFs and check the abbreviated version still fits two pages.

## Funding summary

`data/funding.typ` holds eight awards in their original currencies. Both CVs
calculate the same total from all eight, even though the abbreviated version
lists only three selected awards. The current indicative total is **€110,181**.
The full CV lists every award and both versions explain the scope and rates.

The calculation uses fixed reporting rates already present in the previous CV:
BRL 1 = EUR 0.17 (formerly used for the doctoral scholarship) and USD 1 = EUR 0.85.
The BRL rate is now applied consistently. These are not current market quotes;
their source/date and the full award periods remain TODOs for confirmation.
Cash prizes, estimated sponsored-training values, and consortium budgets are
excluded. Google and FAPESP fellowships remain prominent in the funding section;
prizes and sponsored training are listed separately under Honors and Awards.

## Citation metrics

`data/metrics.json` stores Google Scholar and Scopus values separately from the layout.
The initial values are copied from the supplied LaTeX source. Their snapshot date
is September 18, 2026, as printed in the existing PDF; no fresh retrieval was
performed during conversion. Each source has its own `as_of` date. Compilation
never updates those dates automatically.

A future update script can write this JSON before compilation. It should update
each date only after a successful retrieval and retain the previous values on
failure. This conversion does not add API fetching or a GitHub Actions workflow.

## Fonts, icons, and attribution

Text and headings use **Libertinus Serif**, which is embedded in Typst and Tinymist.
System-font discovery is disabled for consistent output across machines. The
original Cochineal and Cabin font files are no longer needed or stored here.

`layout/style.typ` imports two packages from Typst Universe:

- [`heroic:0.1.2`](https://typst.app/universe/package/heroic/0.1.2/) supplies the
  general-purpose contact icons, including the Scholar graduation cap.
- [`scienceicons:0.1.0`](https://typst.app/universe/package/scienceicons/0.1.0/)
  supplies ORCID, GitHub, and LinkedIn logos.

Both packages include their graphics and license information and need no icon
fonts. The `icon` and `field` helpers apply the CV's purple color and alignment.
