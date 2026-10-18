#import "../layout/style.typ": entry, icon

#let supervisor(name, orcid) = [#name~#link("https://orcid.org/" + orcid, icon("orcid", alt: "ORCID: " + orcid))]
#let andre = supervisor("André C. P. L. F. de Carvalho", "0000-0002-4765-6459")
#let peter = supervisor("Peter F. Stadler", "0000-0002-5016-5191")

#let education(short: false) = [
= Education
#entry[2024 – Present][
  *PhD in Computer Science — University of São Paulo / Leipzig University.* Double-degree program.
  #if not short [Thesis: _Decoding the Language of Life: Towards the Limits of Biological Sequence Representation_.]
  Supervisors: #andre and #peter.
]
#entry[2020 – 2024][
  *BSc in Computer Science — University of São Paulo.* GPA: 9.4/10; rank: 7/116.
  #if not short [
    Specializations: Data Engineering and Data Science.
    Thesis: _BioDeepFuse: A Hybrid Deep Learning Approach with Handcrafted Features for Non-coding RNA Classification_.
    Research conducted with UFZ, supported by the São Paulo Research Foundation (FAPESP); supervisor: #andre.
  ]
]
]
