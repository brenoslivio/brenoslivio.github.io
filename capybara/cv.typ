#import "layout/style.typ": cv, field
#show: cv

#block(below: 0.7em)[
  #text(size: 20pt, weight: "bold")[Breno Livio Silva de Almeida]
  #linebreak()
  #text(size: 11pt, weight: "bold")[Computational Biologist | Data Scientist | Bioinformatician]
  #linebreak()
  #field("envelope", url: "mailto:brenoslivio@pm.me", alt: "Email")[brenoslivio\@pm.me]
  #linebreak()
  #field("globe", url: "https://brenoslivio.github.io/")[Webpage] #h(1em)
  #field("graduation-cap", url: "https://scholar.google.com/citations?user=g0zZ_U4AAAAJ")[Google Scholar] #h(1em)
  #field("orcid", url: "https://orcid.org/0000-0002-2041-9170", alt: "ORCID")[0000-0002-2041-9170]
  #linebreak()
  #field("linkedin", url: "http://www.linkedin.com/in/brenoslivio/", alt: "LinkedIn")[brenoslivio] #h(1em)
  #field("github", url: "https://github.com/brenoslivio", alt: "GitHub")[brenoslivio] #h(1em)
  #field("mobile", alt: "Phone")[+55 11968392259] #h(1em)
  #field("location-arrow", alt: "Location")[São Carlos, Brazil]
]

#include "sections/education.typ"
#include "sections/funding.typ"
#include "sections/employment.typ"
#include "sections/publications.typ"
#include "sections/peerreview.typ"
#include "sections/awards.typ"
#block(breakable: false)[#include "sections/skills.typ"]
#include "sections/presentations.typ"
#include "sections/collab.typ"
#include "sections/other.typ"
#include "sections/assoc.typ"
