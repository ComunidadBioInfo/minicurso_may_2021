## ----install, eval = FALSE---------------------------------------------------------------------------------------------------------
## ## Para instalar paquetes
## if (!requireNamespace("remotes", quietly = TRUE)) {
##       install.packages("remotes")
##   }
## 
## ## Sección plotly
## remotes::install_cran("palmerpenguins")
## remotes::install_cran("ggplot2")
## remotes::install_cran("plotly")
## 
## ## Sección iSEE
## remotes::install_cran("BiocManager")
## BiocManager::version)()
## # El anterior comando debe mostrar que estás usando la versión 3.12
## BiocManager::install("iSEE")
## BiocManager::install("scRNAseq")
## BiocManager::install("scater")
## BiocManager::install("Rtsne")
## BiocManager::install("recount3")


## ----session_packages, eval = TRUE, message = FALSE--------------------------------------------------------------------------------
## Load the package at the top of your script
library("sessioninfo")

## plotly
library("palmerpenguins")
library("ggplot2")
library("plotly")

## iSEE
library("iSEE")
library("scRNAseq")
library("scater")
library("Rtsne")
library("recount3")


## ----session_info------------------------------------------------------------------------------------------------------------------
## Reproducibility information
options(width = 120)
session_info()
proc.time()

