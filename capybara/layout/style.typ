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

#let cv(body) = {
  set document(title: "Breno Livio Silva de Almeida — Curriculum Vitae", author: "Breno Livio Silva de Almeida")
  set page(paper: "a4", margin: (x: 22.5mm, y: 20mm), numbering: "1", number-align: center)
  // Libertinus Serif is embedded in both the Typst CLI and Tinymist.
  set text(font: "Libertinus Serif", size: 10.5pt, lang: "en")
  set par(leading: 0.5em, spacing: 0.65em)
  set heading(numbering: none)
  show link: set text(fill: purple)
  show heading.where(level: 1): it => block(above: 1.2em, below: 0.65em, sticky: true,
    stack(dir: ttb, spacing: 3pt,
      text(size: 16pt, weight: "bold", it.body),
      rect(width: 100%, height: 2.5pt, stroke: none, fill: gradient.linear(lilac.lighten(40%), white)),
    ),
  )
  show heading.where(level: 2): it => block(above: 0.7em, below: 0.4em, sticky: true)[
    #text(size: 12pt, weight: "bold", it.body)
  ]
  body
}

// Keep each date together with its entry when content moves between pages.
#let entry(date, body) = block(above: 0.3em, below: 0.5em, breakable: false)[
  #grid(
    columns: (30mm, 3mm, 1fr),
    column-gutter: 2mm,
    align: (right + top, center + top, left + top),
    text(size: 10pt, date),
    icon("bookmark", size: 0.85em),
    body,
  )
]

#let cv-list(..items) = {
  set list(indent: 1em, body-indent: 0.5em, spacing: 0.5em)
  list(tight: false, ..items.pos().map(item => block(breakable: false, item)))
}

// Dates belong to the data snapshot, never to the compilation time.
#let citation-metrics(metrics) = block[
  #icon("chart-pie")#h(0.4em)
  *h-index:* #metrics.google_scholar.h_index #h(0.6em)
  *i10-index:* #metrics.google_scholar.i10_index #h(0.6em)
  *Citations:* #metrics.google_scholar.citations (Google Scholar),
  #metrics.scopus.citations (Scopus)
  #linebreak()
  #text(size: 9pt, fill: rgb("555555"))[
    Google Scholar as of #metrics.google_scholar.as_of ·
    Scopus as of #(metrics.scopus.as_of).
  ]
]
