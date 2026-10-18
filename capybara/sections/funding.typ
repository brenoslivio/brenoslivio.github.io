#import "../layout/style.typ": entry
#import "../data/funding.typ": awards, eur-total, money

#let funding(short: false) = [
= Research Funding and Fellowships
Awarded approximately *€#money(calc.round(eur-total))* in competitive fellowships, research scholarships, and mobility/travel grants across the award periods.
#if short [Selected awards below; full breakdown in the complete CV.]

#for a in awards.filter(a => not short or a.selected) {
  entry(a.year)[
    #strong(a.title) — #a.currency #money(a.amount).
    #if short { a.short-detail } else { a.detail }
    #a.links.map(((label, url)) => link(url, label)).join([ · ]).
  ]
}
#text(size: 8.5pt, fill: rgb("555555"))[
  Indicative total at fixed reporting rates: BRL 1 = EUR 0.17; USD 1 = EUR 0.85.
  These are indicative conversions, not current market rates.
  Total excludes cash prizes, estimated training values, and consortium budgets; it represents award values, not payments received.
]
]
