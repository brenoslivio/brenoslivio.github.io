#import "../layout/style.typ": entry

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
