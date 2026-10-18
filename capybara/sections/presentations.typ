#import "../layout/style.typ": cv-list, entry
#import "../data/presentations.typ": invited, oral_presentations, abstracts, isme_program_url

#let presentations(short: false) = [
= #if short [Selected Presentations] else [Invited Talks and Conference Presentations]
#if short [
  #entry[2026][*ISME20, Auckland — oral presentation.* Protein language models for protein-family annotation in environmental metagenomes. #link(isme_program_url)[Program MS13].]
  #entry[2026][*VAAM, Berlin — oral presentation.* Protein language models for functional annotation. #link("https://vaam-kongress.de/fileadmin/vaam/2026/docs/2026/VAAM2026_Abstract_booklet.pdf")[Abstract SL-CM-01].]
  #entry[2025][*BAGECO, Graz — flash talk; Helmholtz AI, Messe Karlsruhe — oral presentation.* Protein language models for uncharacterized microbial proteins. #link("https://bageco.org/fileadmin/bageco/2025/BAGECO2025_Abstractbooklet.pdf#page=257")[BAGECO abstract] · #link("https://haicon.cc/conference-2025/")[Helmholtz AI].]
] else [
  == Invited Talk
  #cv-list(invited)
  == Oral Presentations and Flash Talks
  // Preserve the reported title verbatim; its quantitative result is not reused as a validated research-achievement claim.
  #cv-list(..oral_presentations)
  == Conference Abstracts and Posters
  #cv-list(..abstracts)
  #link("https://brenoslivio.github.io/works/")[Additional conference contributions and abstracts].
  // TODO[TALK-01]: Add presentation type, presenter, and abstract/program link for each conference entry; distinguish co-authorship from personally presenting. ISME20 BioAutoML-FAST was a poster.
]
]
