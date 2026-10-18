#import "../layout/style.typ": entry
#import "@preview/metalogo:1.2.0": LaTeX

#let skills(short: false) = [
= Technical Skills
#if short [
  *Methods:* sequence representation, automated machine learning, metagenomic sequence analysis.
  *Tools:* Python, R, scikit-learn, TensorFlow, Biopython, BLAST, HMMER, Git, Linux.
  *Languages:* Portuguese (native), English (C1), German (A1.2).
] else [
  #entry[Methods][Biological sequence representation; handcrafted descriptors and learned embeddings; automated machine learning; non-coding RNA classification; protein annotation; metagenomic sequence analysis.]
  #entry[Programming][Python, R, Bash, Nix, SQL, Java, C, C++.]
  #entry[Modeling and data][Scikit-learn, TensorFlow, pandas, Polars, NumPy, SciPy, NetworkX.]
  #entry[Sequence analysis][Biopython, BLAST, Prodigal, OrthoFinder, Anvi'o, HMMER, EMBOSS, Infernal, DIAMOND, MMSeqs2.]
  #entry[Research tools][Git, Linux, Jupyter, R Markdown, #LaTeX, Typst, Matplotlib, Plotly, Streamlit.]
  #entry[Languages][Portuguese (native), English (C1), German (A1.2).]
]
// TODO[SKILL-01]: Add relevant workflow/HPC/container tools only if used in your research, with a project example. Confirm language levels and assessment dates if formally certified.
]
