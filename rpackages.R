install.packages(c("reticulate", "rmarkdown", "knitr", "BiocManager", "downlit", "xml2"), repos='http://cran.us.r-project.org')
library(BiocManager)
BiocManager::install(c("scRNAseq", "celldex", "SingleR", "scuttle"))