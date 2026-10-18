#import "../layout/style.typ": entry
#import "other.typ": development

#let teaching(short: false) = [
= Teaching and Mentoring
#entry[2025 – 2026][
  *Instructor — UFZ Summer School*, Leipzig.
  Unix/Bash/Git, machine learning, and alignment-based and alignment-free annotation.
  // TODO[TEACH-01]: Add teaching hours, participant counts, links to your materials, and documented feedback for the July 2025 and July 2026 editions.
]
#if not short [
  #entry[09.2025][
    *Instructor — NFDI4Microbiota workshop, ISAM*, Leipzig. Taught submission of research data and metadata to public repositories.
    // TODO[TEACH-02]: Add workshop size, your teaching hours, and a public lesson/materials link.
  ]
]
#entry[06.2025][
  *Co-organizer and instructor — BAGECO metagenomics workshop*, Graz.
  #if not short [Taught experimental design, computer experiments, and end-to-end sequence analysis with BioAutoML.]
  // Source: https://bageco.org/fileadmin/bageco/2025/docs/Metagenomics_WS.pdf lists Breno among the organizers.
  // TODO[TEACH-03]: Describe your organizing responsibilities, actual attendance (not advertised capacity), and teaching materials.
]
#entry[05.2021 – 11.2022][
  *Teaching Assistant — University of São Paulo.*
  #if short [Four undergraduate courses.] else [
    Eight hours/week across Object-Oriented Analysis and Design, Statistics, Fundamentals of Data Science, and Computational Visualization. Graded assignments, prepared exams, and delivered practical lectures.
  ]
  // TODO[TEACH-04]: Add verified class sizes or teaching outcomes. If you mentored students, add level, dates, your role, and outcomes separately; thesis examination is not supervision.
]
#if not short { block(breakable: false, development()) }
]
