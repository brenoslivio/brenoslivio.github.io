#import "../layout/style.typ": cv-list, citation-metrics
#import "../data/publications.typ": papers

#let publications(short: false) = [
= #if short [Selected Publications] else [Publications]
#citation-metrics(json("../data/metrics.json"))
// TODO[MET-01]: Refresh citation counts and each source's actual retrieval date together; do not change dates merely because the CV was rebuilt.
#text(size: 9pt)[#super[†] Equal contribution.]
#if not short [
  == Published Journal Articles
]
#cv-list(..(if short { ("small_proteins", "deepfuse", "automl") } else { ("small_proteins", "deepfuse", "entropy", "automl") }).map(k => papers.at(k)))
#if not short [
  == Accepted Journal Articles
  #cv-list(papers.hub, papers.dominique)
  == Conference Proceedings
  #cv-list(papers.bsb)
]
== Preprint
#cv-list(papers.fast)
]
