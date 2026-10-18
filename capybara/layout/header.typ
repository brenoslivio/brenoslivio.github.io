#import "style.typ": field

#let header(short: false) = [
#text(size: 19pt, weight: "bold")[Breno Livio Silva de Almeida]
#linebreak()
#text(size: 10.5pt)[Computational biology · Biological sequence representation · Machine learning]
#linebreak()
#field("envelope", url: "mailto:brenoslivio@pm.me", alt: "Email")[brenoslivio\@pm.me] #h(0.8em)
#field("location-arrow", alt: "Location")[São Carlos, Brazil]
#if not short [#h(0.8em)#field("mobile", alt: "Phone")[+55 11 96839 2259]]
#linebreak()
#field("globe", url: "https://brenoslivio.github.io/", alt: "Website")[Website] #h(0.7em)
#field("graduation-cap", url: "https://scholar.google.com/citations?user=g0zZ_U4AAAAJ", alt: "Google Scholar")[Google Scholar] #h(0.7em)
#field("orcid", url: "https://orcid.org/0000-0002-2041-9170", alt: "ORCID")[0000-0002-2041-9170] #h(0.7em)
#field("github", url: "https://github.com/brenoslivio", alt: "GitHub")[GitHub] #h(0.7em)
#field("linkedin", url: "https://www.linkedin.com/in/brenoslivio/", alt: "LinkedIn")[LinkedIn]

*Research interests:* Representation and prediction of biological sequences, combining handcrafted descriptors, learned representations from foundation models, metagenomic metadata curation and automated machine learning for classification and annotation in microbial ecology.
]
