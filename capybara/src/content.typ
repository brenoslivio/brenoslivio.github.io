// Shared content for both CVs. Edit the section below; short: true selects the abbreviated version.
#import "style.typ": cv, entry, cv-list, icon, field, citation-metrics
#import "@preview/metalogo:1.2.0": LaTeX

// ========================================================================
// Header and research interests
// ========================================================================

#let header(short: false) = [
#text(size: 19pt, weight: "bold")[Breno Livio Silva de Almeida]
#h(1fr)
#text(size: 9pt)[
  #if short {
    link("https://brenoslivio.github.io/capybara/cv.pdf")[View full academic CV ↗]
  } else {
    link("https://brenoslivio.github.io/capybara/cv-short.pdf")[View short CV ↗]
  }
]
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


// ========================================================================
// Education
// ========================================================================

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


// ========================================================================
// International collaborations
// ========================================================================

#let collaborations() = [
= International Collaborations
#text(size: 9pt, fill: rgb("555555"))[Dates indicate my participation; budgets refer to projects or institutions, not individual awards.]

#entry[2024 – Present][
  *#link("https://autoaipandemics.icmc.usp.br/")[AutoAI-Pandemics].*
  AI4PEP collaboration across Brazil, Germany, Canada, and the UK developing accessible AI for epidemic preparedness and biological-data analysis.
  *CAD 362,500 awarded in 2023* for four years, supported by IDRC and UK International Development.
  I contribute to BioAutoML-FAST and publications on AutoAI Hub and Dominique.
  #link("https://ai4pep.org/brazil/")[AI4PEP Brazil hub] · #link("https://agencia.fapesp.br/projeto-propoe-criar-plataforma-baseada-em-inteligencia-artificial-para-ajudar-no-combate-a-epidemias/44935")[Funding announcement].
]
#entry[2024 – Present][
  *#link("https://nfdi4microbiota.de/")[NFDI4Microbiota].*
  German consortium providing FAIR microbial data, analysis tools, and training.
  Initial DFG funding: *approximately EUR 3 million annually for five years from October 2021*, including *approximately EUR 1 million for UFZ* over that period.
  I contribute to microbial genome and metadata deposition and workshop teaching.
  #link("https://www.ufz.de/index.php?en=36336&webc_pm=50/2021")[Funding and UFZ role] · #link("https://gepris.dfg.de/project/460129525")[DFG project record].
]
#entry[2025 – Present][
  *#link("https://www.ufz.de/index.php?en=102369")[AI MareExplore].*
  Helmholtz Innovation Pool project (2025–2027), led by GEOMAR with UFZ, Forschungszentrum Jülich, and GFZ, using AI to discover marine microbial enzymes for plastic degradation and carbon capture.
  I contribute protein-language-model approaches for microbial protein annotation.
  #link("https://www.geomar.de/en/research/ongoing-projects/project-details/prj/376660?cHash=87327bc2071186ed874d7d56c68e4400")[Funder, dates, and partners] · #link("https://www.geomar.de/en/news/article/mit-kuenstlicher-intelligenz-neue-marine-enzyme-aufspueren")[Project announcement].
  // TODO[AUDIT-02]: Add the AI MareExplore total budget or UFZ allocation only with an award document or public source; GEOMAR's public funding fields are blank.
]
]


// ========================================================================
// Research experience
// ========================================================================

#let experience(short: false) = [
= Research Experience
#entry[07.2025 – 06.2026][
  *Research Assistant — Helmholtz Centre for Environmental Research (UFZ).* Microbial Data Science group, Department of Computational Biology and Chemistry.
  #if short [
    Helped develop a machine-learning approach to classify data types across millions of Sequence Read Archive (SRA) runs within #link("https://helmholtz-metadaten.de/inf-projects/ereemid")[EReMiD]. Contributed to metagenomic metadata standardisation in related projects and to teaching materials.
  ] else [
    #cv-list(
      [Helped develop a machine-learning approach to classify data types across millions of runs from the Sequence Read Archive (SRA) within #link("https://helmholtz-metadaten.de/inf-projects/ereemid")[EReMiD].],
      [Contributed to metagenomic metadata standardisation in related projects and to the development of teaching materials.],
    )
  ]
  // TODO[RES-03]: Add a public resource, model evaluation results, and links to metadata standards or teaching materials you contributed to.
]
#entry[07.2022 – 09.2022][
  *Research Intern — Big Data Biology Lab, Fudan University.*
  #if short [
    Developed a rarefaction workflow for nearly one billion small open reading frames (smORFs) across 63,402 samples, identifying undersampled soil-associated diversity. Contributed to _A catalog of small proteins from the global microbiome_ (_Nature Communications_, 2024).
  ] else [
    Research internship in Prof. Luis Pedro Coelho's group, contributing to the Global Microbial Small ORFs Catalog (GMSC).
    #cv-list(
      [Developed a rarefaction workflow for nearly one billion unique small open reading frames (smORFs) across 63,402 samples.],
      [Compared smORF richness and sampling saturation across habitats, identifying undersampled soil-associated diversity.],
      [Contributed to _A catalog of small proteins from the global microbiome_ (_Nature Communications_, 2024). #link("https://www.big-data-biology.org/blog/2022/09/29/smorfs_rarefaction/")[Lab blog post] · #link("https://doi.org/10.1038/s41467-024-51894-6")[Paper].],
    )
  ]

]
]


// ========================================================================
// Research funding and fellowships
// ========================================================================

// Original-currency amounts are retained from the supplied CV. Public grant
// records establish the award/project; they do not necessarily publish its value.
#let eur-rates = (BRL: 0.17, USD: 0.85, EUR: 1)
#let awards = (
  (year: [2025], title: [Google PhD Fellowship in Health Research], currency: "USD", amount: 30000,
    detail: [International fellowship recognizing outstanding doctoral research in computing and related fields, with USD 15,000 annually for two years and mentorship from a Google researcher. Selected among 15 fellows in Latin America in 2025, including eight from Brazil; supports research on language models for biological sequences.],
    short-detail: [Two-year fellowship with Google research mentorship; one of 15 Latin American fellows selected in 2025.],
    links: (("Recipients", "https://research.google/programs-and-events/phd-fellowship/recipients/?filtertab=2025"), ("USP award report", "https://icmc.usp.br/noticias/7263-google-seleciona-aluno-da-usp-sao-carlos-para-programa-internacional-de-bolsas-de-pesquisa")), selected: true),
  (year: [2025], title: [ISME Scholar Mobility Fund], currency: "EUR", amount: 2300,
    detail: [Awarded by the International Society for Microbial Ecology for a research visit to UFZ, Leipzig, in July 2026. The program supports international research and training visits by graduate students and postdoctoral researchers to advance microbial ecology and collaboration with host laboratories.],
    short-detail: [Supported a July 2026 research visit to UFZ, Leipzig, through ISME's international microbial-ecology mobility program.],
    links: (("Program", "https://isme-microbes.org/public/scholar-fund/"), ("USP visit report", "https://saocarlos.usp.br/projeto-premiado-do-icmc-avanca-e-amplia-uso-de-inteligencia-artificial-em-estudos-de-dna-rna-e-proteinas/")), selected: true),
  (year: [2024], title: [FAPESP Doctoral Scholarship], currency: "BRL", amount: 453168,
    detail: [_Decoding the language of life: Towards protein classification and design through large language models_. São Paulo Research Foundation (FAPESP); competitive, peer-reviewed; grant \#2024/10958-1.],
    short-detail: [_Decoding the language of life: Towards protein classification and design through large language models_. São Paulo Research Foundation (FAPESP); competitive, peer-reviewed; grant \#2024/10958-1.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/221592/"),), selected: true),
  (year: [2024], title: [FAPESP Technical Training Scholarship], currency: "BRL", amount: 10553.20,
    detail: [_Democratization of machine learning in life sciences and annotation of protein families_. Grant \#2024/03304-5, April–October 2024.],
    short-detail: [_Democratization of machine learning in life sciences and annotation of protein families_. Grant \#2024/03304-5.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/216410/"),), selected: false),
  (year: [2024], title: [Prototypes for Humanity Travel Grant], currency: "USD", amount: 760,
    detail: [Travel support to present BioAutoML at Prototypes for Humanity in Dubai, November 2024. The project was selected for an international showcase of university innovations addressing social and environmental challenges, providing an opportunity to present accessible machine-learning tools for life-science research.],
    short-detail: [Supported presentation of BioAutoML at the international innovation showcase in Dubai.],
    links: (("Selected project", "https://www.prototypesforhumanity.com/prototypes/bioautoml"),), selected: false),
  (year: [2023], title: [FAPESP Scientific Initiation Scholarship], currency: "BRL", amount: 7920.99,
    detail: [_Machine learning applied to multiomics analysis for exploration of microbial communities_. Competitive, peer-reviewed; grant \#2023/00264-0, April–December 2023.],
    short-detail: [_Machine learning applied to multiomics analysis for exploration of microbial communities_. Competitive, peer-reviewed; grant \#2023/00264-0.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/208213/"),), selected: false),
  (year: [2023], title: [CNPq Scientific Initiation Scholarship], currency: "BRL", amount: 1500,
    detail: [_Automated machine learning for life sciences_. National Council for Scientific and Technological Development (CNPq); grant \#101243/2023-5.],
    short-detail: [_Automated machine learning for life sciences_. Grant \#101243/2023-5.],
    // TODO[AUDIT-01]: Add a public award-specific record for CNPq #101243/2023-5; the link below explains the scholarship category, not the individual award or amount.
    links: (("CNPq scholarship category", "https://www.gov.br/cnpq/pt-br/acesso-a-informacao/bolsas-e-auxilios/copy_of_modalidades/bolsas-modalidades"),), selected: false),
  (year: [2021 – 2022], title: [FAPESP Scientific Initiation Scholarship], currency: "BRL", amount: 7652.70,
    detail: [_Classification and analysis of bacterial non-coding RNA sequences using machine-learning techniques_. Competitive, peer-reviewed; grant \#2021/08561-8, September 2021–June 2022.],
    short-detail: [_Classification and analysis of bacterial non-coding RNA sequences using machine-learning techniques_. Competitive, peer-reviewed; grant \#2021/08561-8.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/198279/"),), selected: false),
)
#let eur-total = awards.map(a => a.amount * eur-rates.at(a.currency)).sum()
#let money(value) = {
  let parts = str(calc.round(value, digits: 2)).split(".")
  let digits = parts.first().clusters()
  let grouped = digits.enumerate().map(((i, d)) => {
    if i > 0 and calc.rem(digits.len() - i, 3) == 0 { "," + d } else { d }
  }).join()
  grouped + if parts.len() > 1 { "." + (parts.at(1) + "00").slice(0, 2) } else { "" }
}

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


// ========================================================================
// Honors and awards
// ========================================================================

#let honors(short: false) = [
= Honors and Awards
#entry[2026][
  *IRCAI Global Top 100 — Outstanding (2025 edition).* Team recognition for BioAutoML from the International Research Centre on Artificial Intelligence (IRCAI), under the auspices of UNESCO.
  #if not short [Recognizes accessible machine learning for life sciences supporting UN Sustainable Development Goals 3 (health) and 10 (reduced inequalities).]
  Contributing developer of BioAutoML; currently lead developer of BioAutoML-FAST.
  #link("https://ircai.org/top100/entry/bioautoml-democratizing-machine-learning-in-life-sciences/")[Official recognition].
]
#if not short [
  #entry[2026][
    *HIDA-sponsored Carpentries Instructor Training.* Selected for one of 15 annually sponsored places for Helmholtz researchers; estimated training value: USD 1,600.
    The program prepares researchers to teach practical computing and data-science workshops using evidence-based instruction, supporting reproducibility and open science. Participation leads toward Carpentries instructor certification.
    #link("https://www.helmholtz-hida.de/en/training/data-science-instructor-certification/")[HIDA program and selection details].
  ]
]
#entry[2024][
  *J. F. Marar Artificial Intelligence Prize for Undergraduate Research.* Winner for _BioDeepFuse: Empowering Researchers in Life Sciences with Deep Learning_; cash prize: *BRL 10,500*.
  #if short [
    Inaugural ICMC-USP award recognizing academic and social relevance, alignment with the UN Sustainable Development Goals, and academic performance.
  ] else [
    Inaugural award for ICMC-USP undergraduate AI research (2023 edition, presented in February 2024), selected unanimously by the committee on academic relevance, social relevance, alignment with the UN Sustainable Development Goals, and the student's academic performance.
    BioDeepFuse combines deep learning and handcrafted sequence features to make non-coding RNA classification more accessible to life-science researchers.
  ]
  #link("https://saocarlos.usp.br/projeto-para-empoderar-pesquisadores-em-ciencias-da-vida-vence-premio-j-f-marar-de-inteligencia-artificial-para-a-graduacao/")[USP award announcement].
]
#entry[2024][
  *Prototypes for Humanity.* BioAutoML selected among 100 projects from nearly 3,000 submissions worldwide.
  #if short [International showcase of university innovations addressing social and environmental challenges.] else [
    Presented in Dubai in November 2024, showcasing automated machine learning that enables life-science researchers to analyze biological sequences with less programming expertise. Travel support is reported in Research Funding and Fellowships.
  ]
  #link("https://www.prototypesforhumanity.com/prototypes/bioautoml")[Selected project].
]
]


// ========================================================================
// Publications
// ========================================================================

// Shared bibliographic entries for both CVs. Preserve published author order.
// TODO[PUB-01]: Confirm acceptance dates and add final year, DOI, volume, and article number for Dominique and AutoAI Hub when available.
// TODO[PUB-02]: Update BioAutoML-FAST when published; confirm equal-contribution markers against the final papers.
#let papers = (
  fast: [#strong[de Almeida, B. L.], Bonidia, R. P., Bole, M., Avila-Santos, A. P., Stadler, P. F., Nunes da Rocha, U., & de Carvalho, A. C. P. L. F. (2026). BioAutoML-FAST: an automated machine-learning platform for reusable and benchmarked biological sequence models. #emph[bioRxiv]. #strong[DOI:] #link("https://doi.org/10.64898/2026.04.18.719383", "10.64898/2026.04.18.719383"). #strong[Under revision at #emph[Bioinformatics] following peer review (major revision).]],
  small_proteins: [Duan, Y., Santos-Júnior, C. D., Schmidt, T. S., Fullam, A., #strong[de Almeida, B. L.], Zhu, C., ... & Coelho, L. P. (2024). A catalog of small proteins from the global microbiome. Nature Communications, 15(1), 7563. #strong[DOI:] #link("https://doi.org/10.1038/s41467-024-51894-6", "10.1038/s41467-024-51894-6").],
  deepfuse: [#strong[de Almeida, B. L.]#super[†], Avila Santos, A. P.#super[†], Bonidia, R. P., Stadler, P. F., Stefanic, P., Mandic-Mulec, I., ... & de Carvalho, A. C. (2024). BioDeepfuse: a hybrid deep learning approach with integrated feature extraction techniques for enhanced non-coding RNA classification. RNA Biology, 21(1), 410-421. #strong[DOI:] #link("https://doi.org/10.1080/15476286.2024.2329451", "10.1080/15476286.2024.2329451").],
  entropy: [Bonidia, R. P., Avila Santos, A. P., #strong[de Almeida, B. L.], Stadler, P. F., Nunes da Rocha, U., Sanches, D. S., & De Carvalho, A. C. (2022). Information theory for biological sequence classification: A novel feature extraction technique based on Tsallis entropy. Entropy, 24(10), 1398. #strong[DOI:] #link("https://doi.org/10.3390/e24101398", "10.3390/e24101398").],
  automl: [Bonidia, R. P., Santos, A. P. A., #strong[de Almeida, B. L.], Stadler, P. F., da Rocha, U. N., Sanches, D. S., & de Carvalho, A. C. (2022). BioAutoML: automated feature engineering and metalearning to predict noncoding RNAs in bacteria. Briefings in Bioinformatics, 23(4), bbac218. #strong[DOI:] #link("https://doi.org/10.1093/bib/bbac218", "10.1093/bib/bbac218").],
  dominique: [Tavares, D., Barreto, M. C. A., #strong[de Almeida, B. L. S.], Florentino, B. R., Tetzner, F., Goedert, G., Struchiner, C., Bonidia, R., & de Carvalho, A. Dominique: An AI-powered fact-checking chatbot for democratizing access to reliable information. Oxford Open Digital Health. #strong[Accepted for publication].],
  hub: [#strong[de Almeida, B. L. S.]#super[†], Bonidia, R.#super[†], Florentino, B.#super[†], Barreto, M. C. A.#super[†], Constantino, J. L. R.#super[†], Tavares da Silva, D.#super[†], Zwicker, G. G., Rocha, U., Goedert, G., Struchiner, C., & de Carvalho, A. AutoAI Hub: From data to society, democratizing machine learning for everyone. Oxford Open Digital Health. #strong[Accepted for publication].],
  bsb: [#strong[de Almeida, B. L. S.]#super[†], Queiroz, A. P.#super[†], Santos, A. P. A.#super[†], Bonidia, R. P., da Rocha, U. N., Sanches, D. S., & de Carvalho, A. C. P. D. L. F. (2021, November). Feature importance analysis of non-coding DNA/RNA sequences based on machine learning approaches. In Brazilian Symposium on Bioinformatics (pp. 81-92). Cham: Springer International Publishing. #strong[DOI:] #link("https://doi.org/10.1007/978-3-030-91814-9_8", "10.1007/978-3-030-91814-9_8").],
)

#let publications(short: false) = [
= Publications
#citation-metrics(json("../data/metrics.json"))
// TODO[MET-01]: Refresh citation counts and each source's actual retrieval date together; do not change dates merely because the CV was rebuilt.
#text(size: 9pt)[#super[†] Equal contribution.]
== Manuscripts Under Review
#cv-list(papers.fast)
== Published Journal Articles
#cv-list(..("small_proteins", "deepfuse", "entropy", "automl").map(k => papers.at(k)))
== Accepted Journal Articles
#cv-list(papers.hub, papers.dominique)
== Conference Proceedings
#cv-list(papers.bsb)
]


// ========================================================================
// Research software and resources
// ========================================================================

#let software(short: false) = [
= Research Software and Resources
#entry[BioAutoML-FAST][
  *Automated machine learning for biological sequences.* Lead developer; expanded sequence types, prediction tasks, and evaluation within the BioAutoML framework.
  #link("https://github.com/Bonidia/BioAutoML-FAST")[Code] ·
  #link("https://bioautoml.icmc.usp.br/")[Web application] ·
  #link("https://doi.org/10.64898/2026.04.18.719383")[Preprint].
  #if not short [Provides reusable trained models for genomics, transcriptomics, and proteomics.]
  // TODO[SW-01]: Specify your implementation/maintenance role, a stable release/model DOI, reproducibility assets, and verified independent reuse. Do not treat model counts or downloads as user counts.
]
#entry[BioAutoML][
  *Automated feature engineering and model selection.* Contributing developer.
  #if not short [Automates sequence-feature extraction and selection, algorithm recommendation, and hyperparameter tuning for biological sequence classification, including bacterial non-coding RNAs.]
  #link("https://github.com/Bonidia/BioAutoML")[Code] ·
  #link("https://doi.org/10.1093/bib/bbac218")[Paper].
]
#entry[BioDeepFuse][
  *Hybrid deep learning for non-coding RNA classification.* Co-first author of the methods paper.
  #if short [Combines neural networks with handcrafted sequence features.] else [Combines convolutional or bidirectional LSTM networks with handcrafted sequence features to capture complementary sequence patterns. Includes training and evaluation scripts, datasets, and experimental results for bacterial RNA classification.]
  #link("https://github.com/brenoslivio/BioDeepFuse")[Code] ·
  #link("https://doi.org/10.1080/15476286.2024.2329451")[Paper].
  // TODO[SW-02]: Add a stable archived release, your specific software contribution, and evidence of external reuse.
]
#entry[MAG2ENA][
  *Metagenome-assembled genome submission to the European Nucleotide Archive.* Lead developer; developed within NFDI4Microbiota.
  #if not short [Provides web and command-line workflows for metadata curation, validation, and genome submission using the MIMAG checklist, plus metadata updates for existing ENA records.]
  #link("https://github.com/NFDI4Microbiota/MAG2ENA")[Code] ·
  #link("https://web.app.ufz.de/mag2ena")[Web application].
]
]


// ========================================================================
// Invited talks and conference presentations
// ========================================================================

#let isme_program_url = "https://isme-microbes.org/media/documents/isme20-full-programme-overview3.pdf#page=29"
#let invited = [#strong[de Almeida, B. L.] Da bancada ao teclado: ferramentas gratuitas para a pesquisa científica \[From bench to keyboard: free tools for scientific research\]. #strong[Invited talk], 36th FisFar Summer Course, Federal University of Minas Gerais (UFMG), Brazil. January 2027. #emph[Scheduled.]]
#let isme_oral = [#strong[de Almeida, B. L.], Kamath, S., Santos, A. P. A., Bonidia, R. P., Espíndola-Hernández, P., Stadler, P. F., Wierckx, N., Borchert, E., Rother, D., Oliveira, A., de Carvalho, A. C. P. L. F., & Rocha, U. N. Combining protein language models with different architectures expands protein family annotation 14.2-fold across 16 million open reading frames from 3,802 environmental metagenomes. #strong[Oral presentation], 20th International Symposium on Microbial Ecology (ISME20), Auckland, New Zealand, 18 August 2026 (MS13, Computational Approaches in Microbial Ecology). #link(isme_program_url)[Conference program].]
// Titles and author order follow the supplied CV/website; source links verify the event records.
// Numerical results are retained as presentation titles, not independent achievement claims.
// Verified 2026-10-18: VAAM abstract SL-CM-01; BAGECO flash-talk abstract FT043.
// The user confirmed presenting the VAAM protein-language-model work in 2026.
// Helmholtz AI title/authors and 5 June 2025 presentation date come from the
// personal works/events pages; the official 2025 archive's program link is unavailable.
#let vaam_oral = [#strong[de Almeida, B. L. S.], Kamath, S., Santos, A. P. A., Bonidia, R. P., Espíndola-Hernández, P., Stadler, P. F., Wierckx, N., Borchert, E., Rother, D., Oliveira, A., de Carvalho, A. C. P. L. F., & Rocha, U. N. Different protein language models uncover 23.21% of the functional dark matter across 16 million open reading frames recovered from thousands of environmental metagenomes. #strong[Oral presentation], VAAM Annual Conference, Berlin, Germany, 22–25 March 2026 (SL-CM-01, Computational Microbiology). #link("https://vaam-kongress.de/fileadmin/vaam/2026/docs/2026/VAAM2026_Abstract_booklet.pdf")[Abstract book].]
#let helmholtz_oral = [#strong[de Almeida, B. L. S.], Kamath, S., Santos, A. P. A., Bonidia, R. P., Espíndola-Hernández, P., Stadler, P. F., Oliveira, A., de Carvalho, A. C. P. L. F., & Rocha, U. N. Unveiling protein domains and families in 183,044 novel orthologs exploring multiple protein language models and over 16 million open reading frames recovered from thousands of terrestrial metagenomes. #strong[Oral presentation], Helmholtz AI Conference 2025, Messe Karlsruhe, Rheinstetten, Germany, 5 June 2025. #link("https://haicon.cc/conference-2025/")[Conference archive]]
#let bageco_flash = [#strong[de Almeida, B. L.], Kamath, S., Santos, A. P. A., Bonidia, R. P., Espíndola-Hernández, P., Stadler, P. F., Oliveira, A., de Carvalho, A. C. P. L. F., & Rocha, U. N. Exploration of multiple protein language models and over 16 million open reading frames recovered from thousands of terrestrial metagenomes uncover protein domains and families in 13,486 previously unknown orthologs. In: 17th Symposium on Genetics and Bacterial Ecology (BAGECO 2025), 2025, Graz, Austria. #strong[Flash talk], 4 July 2025 (FT043). #link("https://bageco.org/fileadmin/bageco/2025/BAGECO2025_Abstractbooklet.pdf#page=257")[Abstract].]
#let oral_presentations = (isme_oral, vaam_oral, bageco_flash, helmholtz_oral)

#let abstracts = (
  [#strong[de Almeida, B. L.], Bonidia, R. P., Bole, M., Santos, A. P. A., Stadler, P. F., Rocha, U. N., & de Carvalho, A. C. P. L. F. From sequences to traits: An AI-driven AutoML framework for genome-resolved microbial ecology. In: 20th International Symposium on Microbial Ecology (ISME20), 2026, Auckland, New Zealand.],
  [Bonidia, R. P., Florentino, B. R., Barreto, M. C. A., #strong[de Almeida, B. L.], Constantino, J. L. R., Silva, D. T., Rocha, U. N., Goedert, G. T., Struchiner, C. J., & de Carvalho, A. C. P. L. F. AutoAI Hub: From Data to Society, Democratizing Machine Learning for Everyone. In: Human Genome Meeting 2026, 2026, Athens, Greece.],
  [Santos, A. P. A., #strong[de Almeida, B. L.], Bole, M., Kamath, S., & Rocha, U. N. A FAIR-by-Design and Standard-Compliant System for Automated Submission of Microbial Genomes to the European Nucleotide Archive. In: VAAM Annual Conference, 2026, Berlin, Germany.],
  [Bonidia, R. P., Santos, A. P. A., #strong[de Almeida, B. L.], Stadler, P. F., Rocha, U. N., Sanches, D. S., & de Carvalho, A. C. P. L. F. BioAutoML: End-to-End Machine Learning Package for Life Sciences. In: 10th FEMS Congress of European Microbiologists, 2023, Hamburg, Germany.],
)

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


// ========================================================================
// Professional development and community leadership
// ========================================================================

#let development() = [
== Selected Professional Development
#entry[2025][*Summer School in Trends in Multi-omics Data Analysis for Microbial Ecology and Biotechnology*, UFZ, Leipzig.]
#entry[2024][*15th Summer Course in Bioinformatics*, FMUSP, São Paulo.]
#entry[2020 – 2021][Data science specializations: University of Michigan (_Applied Data Science with Python_) and Johns Hopkins University (_Data Science_), Coursera.]
#entry[2020][_Nutrition and Health: Human Microbiome_, Wageningen University, edX.]
]

#let community() = [
== Community and Student Leadership
#entry[2018 – 2021][
  *Co-founder and coordinator — efestus*, University of São Paulo. Student organization addressing computing, data science, and technology ethics for social good. Funded participation in the TechShift Summit, Chapel Hill, USA.
  // TODO[SERVICE-01]: Add initiatives you organized, your responsibilities, and verified participation or outcomes.
]
#entry[2017 – 2019][*Software division member — Warthog Robotics*, University of São Paulo. Participated in robotics competitions and taught Git and object-oriented programming to new members.]
]


// ========================================================================
// Teaching and mentoring
// ========================================================================

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


// ========================================================================
// Academic service
// ========================================================================

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


// ========================================================================
// Technical skills
// ========================================================================

#let sequence-tools = [Biopython, BLAST, Prodigal, OrthoFinder, Anvi'o, HMMER, Infernal, DIAMOND, MMSeqs2.]

#let skills(short: false) = [
= Technical Skills
#if short [
  *Methods:* sequence representation, automated machine learning, metagenomic sequence analysis.
  *Tools:* Python, R, scikit-learn, TensorFlow, Git, Linux.
  *Sequence analysis:* #sequence-tools
  *Languages:* Portuguese (native), English (C1), German (A1.2).
] else [
  #entry[Methods][Biological sequence representation; handcrafted descriptors and learned embeddings; automated machine learning; non-coding RNA classification; protein annotation; metagenomic sequence analysis.]
  #entry[Programming][Python, R, Bash, Nix, SQL, Java, C, C++.]
  #entry[Modeling and data][Scikit-learn, TensorFlow, pandas, Polars, NumPy, SciPy, NetworkX.]
  #entry[Sequence analysis][#sequence-tools]
  #entry[Research tools][Git, Linux, Jupyter, R Markdown, #LaTeX, Typst, Matplotlib, Plotly, Streamlit.]
  #entry[Languages][Portuguese (native), English (C1), German (A1.2).]
]
// TODO[SKILL-01]: Add relevant workflow/HPC/container tools only if used in your research, with a project example. Confirm language levels and assessment dates if formally certified.
]


// ========================================================================
// Professional memberships
// ========================================================================

#let memberships(short: false) = [
#if not short [
  = Professional Memberships
  International Society for Microbial Ecology (ISME), since October 2025; Federation of European Microbiological Societies (FEMS), since November 2025.
]
]


// ========================================================================
// Document assembly: section order and page breaks
// ========================================================================

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
  publications(short: short)
  if not short { collaborations() }
  software(short: short)
  presentations(short: short)
  teaching(short: short)
  // Keep these compact sections intact when a page is nearly full.
  block(breakable: false, service(short: short))
  block(breakable: false, skills(short: short))
  memberships(short: short)
}
