// Original-currency amounts are retained from the supplied CV. Public grant
// records establish the award/project; they do not necessarily publish its value.
// Audit notes and verification gaps: ../SOURCES.txt (reviewed 2026-10-18).
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
    detail: [Competitive, peer-reviewed scholarship from the São Paulo Research Foundation (FAPESP), grant \#2024/10958-1. Supports the project _Decoding the language of life: Towards protein classification and design through large language models_, investigating alignment-free sequence representations and machine learning for protein classification and design at ICMC-USP.],
    short-detail: [Competitive, peer-reviewed scholarship from the São Paulo Research Foundation (FAPESP), grant \#2024/10958-1, supporting biological sequence representations and protein classification and design.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/221592/"),), selected: true),
  (year: [2024], title: [FAPESP Technical Training Scholarship], currency: "BRL", amount: 10553.20,
    detail: [Grant \#2024/03304-5, April–October 2024. Funded _Democratization of machine learning in life sciences and annotation of protein families_, in collaboration with UFZ. The project develops accessible web applications for RNA classification and AutoML, and explores language models for protein-family annotation; linked to the CeMEAI research center at USP.],
    short-detail: [Supported accessible bioinformatics applications and protein-family annotation in collaboration with UFZ.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/216410/"),), selected: false),
  (year: [2024], title: [Prototypes for Humanity Travel Grant], currency: "USD", amount: 760,
    detail: [Travel support to present BioAutoML at Prototypes for Humanity in Dubai, November 2024. The project was selected for an international showcase of university innovations addressing social and environmental challenges, providing an opportunity to present accessible machine-learning tools for life-science research.],
    short-detail: [Supported presentation of BioAutoML at the international innovation showcase in Dubai.],
    links: (("Selected project", "https://www.prototypesforhumanity.com/prototypes/bioautoml"),), selected: false),
  (year: [2023], title: [FAPESP Scientific Initiation Scholarship], currency: "BRL", amount: 7920.99,
    detail: [Competitive, peer-reviewed scholarship; grant \#2023/00264-0, April–December 2023. Funded undergraduate research on _Machine learning applied to multiomics analysis for exploration of microbial communities_, examining how methods including BioAutoML can integrate omics data into analysis workflows for complex microbial communities.],
    short-detail: [Competitive, peer-reviewed scholarship supporting machine learning and multi-omics integration for microbial communities.],
    links: (("FAPESP grant record", "https://bv.fapesp.br/en/bolsas/208213/"),), selected: false),
  (year: [2023], title: [CNPq Scientific Initiation Scholarship], currency: "BRL", amount: 1500,
    detail: [National Council for Scientific and Technological Development, grant \#101243/2023-5. Supported undergraduate research on _Automated machine learning for life sciences_; scientific-initiation scholarships develop research skills through supervised participation in a scientific project.],
    short-detail: [Supported supervised undergraduate research on automated machine learning for life sciences.],
    // TODO[AUDIT-01]: Add a public award-specific record for CNPq #101243/2023-5; the link below explains the scholarship category, not the individual award or amount.
    links: (("CNPq scholarship category", "https://www.gov.br/cnpq/pt-br/acesso-a-informacao/bolsas-e-auxilios/copy_of_modalidades/bolsas-modalidades"),), selected: false),
  (year: [2021 – 2022], title: [FAPESP Scientific Initiation Scholarship], currency: "BRL", amount: 7652.70,
    detail: [Competitive, peer-reviewed scholarship; grant \#2021/08561-8, September 2021–June 2022. Funded _Classification and analysis of bacterial non-coding RNA sequences using machine-learning techniques_, combining mathematical sequence descriptors and predictive models to distinguish small non-coding RNAs and evaluate informative features.],
    short-detail: [Competitive, peer-reviewed scholarship supporting sequence descriptors and machine learning for bacterial non-coding RNA classification.],
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
