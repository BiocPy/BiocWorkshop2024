install.packages(c("BiocManager"), repos='http://cran.us.r-project.org')
library(BiocManager)
BiocManager::install(
    c("scRNAseq", "celldex", "SingleR", "scuttle", "reticulate", 
    "rmarkdown", "knitr", "downlit", "xml2", "ggplot2", "edgeR", 
    "AnnotationHub", "TxDb.Hsapiens.UCSC.hg38.refGene"))