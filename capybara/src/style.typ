#import "@preview/heroic:0.1.2"
#import "@preview/scienceicons:0.1.0"

#let purple = rgb("630d91")
#let lilac = rgb("bc5fed")

// Package-managed graphics: no icon fonts or project-local asset files.
#let icon(name, size: 0.95em, alt: "") = {
  set image(alt: alt)
  let brands = (
    orcid: scienceicons.orcid-icon,
    github: scienceicons.github-icon,
    linkedin: scienceicons.linkedin-icon,
  )
  let symbols = (
    envelope: "envelope",
    globe: "globe-alt",
    graduation-cap: "academic-cap",
    mobile: "device-phone-mobile",
    location-arrow: "paper-airplane",
    bookmark: "bookmark",
    chart-pie: "chart-pie",
  )
  if name in brands {
    brands.at(name)(color: purple, height: size, baseline: 0.1em)
  } else {
    heroic.hi(symbols.at(name), color: purple, height: size,
      baseline: 0.1em, solid: name != "envelope")
  }
}

#let field(name, body, url: none, alt: "") = {
  let content = box[#icon(name, alt: alt)#h(0.4em)#body]
  if url == none { content } else { link(url, content) }
}

#let cv(body, short: false) = {
  set document(title: "Breno Livio Silva de Almeida — " + if short { "Abbreviated Academic CV" } else { "Curriculum Vitae" }, author: "Breno Livio Silva de Almeida")
  set page(paper: "a4", margin: if short { (x: 17mm, y: 15mm) } else { (x: 20mm, y: 17mm) },
    footer: context text(size: 9pt, fill: rgb("555555"))[
      Breno Livio Silva de Almeida #h(1fr)
      #if short { [Abbreviated CV · ] }#counter(page).display("1 / 1", both: true)
    ])
  // Libertinus Serif is embedded in both the Typst CLI and Tinymist.
  set text(font: "Libertinus Serif", size: if short { 10.25pt } else { 10.5pt }, lang: "en", region: "GB")
  set par(leading: if short { 0.38em } else { 0.5em },
    spacing: if short { 0.6em } else { 0.7em })
  set heading(numbering: none)
  show link: set text(fill: purple)
  show heading.where(level: 1): it => block(
    above: if short { 0.8em } else { 0.9em },
    below: if short { 0.4em } else { 0.45em }, sticky: true,
    stack(dir: ttb, spacing: 3pt,
      text(size: if short { 13pt } else { 14pt }, weight: "bold", it.body),
      line(length: 100%, stroke: 0.5pt + lilac.lighten(35%)),
    ),
  )
  show heading.where(level: 2): it => block(
    above: if short { 0.5em } else { 0.7em },
    below: if short { 0.3em } else { 0.4em }, sticky: true)[
    #text(size: if short { 11pt } else { 12pt }, weight: "bold", it.body)
  ]
  body
}

// Keep each date together with its entry when content moves between pages.
#let entry(date, body, compact: false, label-width: 24mm, title: none) = if compact {
  block(above: 0.3em, below: 0.3em, breakable: false)[
    #if date == [] { body } else {
      grid(columns: (label-width, 1fr), column-gutter: 2mm,
        align: (left + top, left + top),
        text(size: 9pt, date), if title == none { body } else { [#title #body] })
    }
  ]
} else { block(above: 0.5em, below: 0.5em, breakable: false)[
  #grid(
    columns: (25mm, 1fr),
    column-gutter: 4mm,
    align: (left + top, left + top),
    text(size: 9pt, date),
    if title == none { body } else { [#title #body] },
  )
] }

#let cv-list(compact: false, dense: false, ..items) = if compact {
  items.pos().join([ ])
} else {
  set list(indent: 1em, body-indent: 0.5em, spacing: if dense { 0.2em } else { 0.5em })
  list(tight: dense, ..items.pos().map(item => block(breakable: false, item)))
}

// Dates belong to the data snapshot, never to the compilation time.
#let citation-metrics(metrics) = {
  let scholar-url = "https://scholar.google.com/citations?user=" + metrics.google_scholar.profile_id
  let scopus-url = "https://www.scopus.com/authid/detail.uri?authorId=" + metrics.scopus.profile_id
  let metric(value, label, source, url, prominent: false) = {
    set text(top-edge: "cap-height", bottom-edge: "baseline")
    block(width: 100%, height: 30pt, above: 0pt, below: 0pt,
      align(center + horizon, stack(
        dir: ttb,
        spacing: 1.5pt,
        text(size: if prominent { 17pt } else { 15pt },
          weight: "bold", fill: purple, str(value)),
        text(size: 9pt, weight: "bold", fill: rgb("333333"), label),
        text(size: 8pt, link(url, source)),
      )),
    )
  }
  block(breakable: false)[
    #block(width: 100%, fill: purple.lighten(95%),
      stroke: 0.4pt + purple.lighten(80%), radius: 3pt,
      inset: (x: 8pt, y: 4pt), above: 0pt, below: 3pt,
      grid(columns: (1fr, 1fr, 1fr, 1fr), column-gutter: 10pt,
        metric(metrics.google_scholar.citations, "Citations", "Google Scholar", scholar-url, prominent: true),
        metric(metrics.scopus.citations, "Citations", "Scopus", scopus-url, prominent: true),
        metric(metrics.google_scholar.h_index, "h-index", "Google Scholar", scholar-url),
        metric(metrics.google_scholar.i10_index, "i10-index", "Google Scholar", scholar-url),
      ),
    )
    #text(size: 8.5pt, fill: rgb("555555"))[
      Google Scholar as of #metrics.google_scholar.as_of ·
      Scopus as of #(metrics.scopus.as_of).
    ]
  ]
}
