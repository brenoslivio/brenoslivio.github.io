#import "style.typ": cv
#import "header.typ": header
#import "../sections/education.typ": education
#import "../sections/employment.typ": experience
#import "../sections/funding.typ": funding
#import "../sections/awards.typ": honors
#import "../sections/publications.typ": publications
#import "../sections/software.typ": software
#import "../sections/presentations.typ": presentations
#import "../sections/teaching.typ": teaching
#import "../sections/peerreview.typ": service
#import "../sections/skills.typ": skills
#import "../sections/assoc.typ": memberships

#let document(short: false) = {
  show: cv.with(short: short)
  header(short: short)
  education(short: short)
  experience(short: short)
  {
    if not short {
      set text(size: 10pt)
      set par(leading: 0.45em)
      funding(short: short)
      honors(short: short)
    } else {
      funding(short: short)
      honors(short: short)
    }
  }
  // Start the publication record and its citation metrics together.
  pagebreak(weak: true)
  publications(short: short)
  software(short: short)
  if not short { pagebreak(weak: true) }
  presentations(short: short)
  teaching(short: short)
  // Keep these compact sections intact when a page is nearly full.
  block(breakable: false, service(short: short))
  block(breakable: false, skills(short: short))
  memberships(short: short)
}
