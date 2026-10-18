#import "../layout/style.typ": entry, cv-list
#import "collab.typ": collaborations

#let experience(short: false) = [
= Research Experience
#entry[07.2025 – 06.2026][
  *Research Assistant — Helmholtz Centre for Environmental Research (UFZ).* Microbial Data Science group, Department of Computational Biology and Chemistry.
  #if short [Contributed protein-language-model approaches for functional annotation of environmental metagenomic sequences.] else [
    #cv-list(
      [Contributed to protein-language-model approaches for functional annotation of metagenomic sequences within #link("https://www.ufz.de/index.php?en=102369")[AI MareExplore].],
      [Contributed to AI-assisted data-type categorization and ontology alignment in #link("https://helmholtz-metadaten.de/inf-projects/ereemid")[EReMiD].],
    )
  ]
  // TODO[RES-02]: Describe your individual model/pipeline contribution and evaluation. Define the baseline, confidence thresholds, validation, and publication status behind the 14.2-fold annotation result before using it as an achievement bullet.
  // TODO[RES-03]: Add your specific EReMiD deliverable, ontology/data coverage, and a public resource or measured outcome.
]
#entry[07.2022 – 09.2022][
  *Research Intern — Big Data Biology Lab, Fudan University.*
  Performed rarefaction analyses of small open reading frames across environmental metagenomes, contributing to _A catalog of small proteins from the global microbiome_ (_Nature Communications_, 2024).
  // TODO[RES-04]: Add the scale of your own analysis and the specific finding or resource it supported.
]
#if not short { collaborations() }
]
