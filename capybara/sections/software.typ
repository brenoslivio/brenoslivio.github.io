#import "../layout/style.typ": entry

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
  *Metagenome-assembled genome submission to the European Nucleotide Archive.* First co-author; developed within NFDI4Microbiota.
  #if not short [Provides web and command-line workflows for metadata curation, validation, and genome submission using the MIMAG checklist, plus metadata updates for existing ENA records.]
  #link("https://github.com/NFDI4Microbiota/MAG2ENA")[Code] ·
  #link("https://web.app.ufz.de/mag2ena")[Web application].
]
]
