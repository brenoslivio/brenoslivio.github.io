# Curriculum vitae

The CV is maintained in Typst. `cv.typ` is the entry point, and `cv.pdf`
is the compiled file linked by the website.

```text
capybara/
├── cv.typ             # Main document and contact header
├── sections/          # Education, publications, employment, and other content
├── layout/
│   └── style.typ      # Typography, icons, colors, and reusable layout helpers
├── data/
│   └── metrics.json   # Citation counts and snapshot dates
├── cv.pdf       # Website download
└── README.md
```

## Build

### Command line

From the repository root, with the Typst CLI installed:

```sh
typst compile --ignore-system-fonts capybara/cv.typ capybara/cv.pdf
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

- Edit the matching file in `sections/`. Keep the include order in `cv.typ`.
- Edit `layout/style.typ` to change typography, icons, colors, and spacing.
- Use `entry[date][content]` for dated entries and `cv-list([item], [item])` for lists.
- Publications are in `sections/publications.typ`, preserving the original ordering,
  author emphasis, equal-contribution markers, links, and manuscript statuses.

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
  general-purpose icons, including the Scholar graduation cap and entry bookmarks.
- [`scienceicons:0.1.0`](https://typst.app/universe/package/scienceicons/0.1.0/)
  supplies ORCID, GitHub, and LinkedIn logos.

Both packages include their graphics and license information and need no icon
fonts. The `icon` and `field` helpers apply the CV's purple color and alignment.
