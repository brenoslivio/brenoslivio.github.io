#import "../layout/style.typ": entry
#import "other.typ": community

#let service(short: false) = [
= Academic Service
#if short [
  Journal reviewer: _Briefings in Bioinformatics_ and _Journal of Thermal Biology_. Member of six undergraduate thesis examination committees.
] else [
  == Journal Peer Review
  #entry[2026 – Present][*Computational and Structural Biotechnology Journal.* One manuscript reviewed.]
  #entry[2026 – Present][*Journal of Thermal Biology.* One manuscript reviewed.]
  #entry[2025 – Present][*Briefings in Bioinformatics.* One manuscript reviewed across two rounds.]
  == Undergraduate Thesis Examination
  #entry[][Member of six undergraduate thesis examination committees.]
  #community()
]
// TODO[SERVICE-02]: Add dates and institutions for thesis committees; refresh review counts without disclosing confidential manuscript information.
]
