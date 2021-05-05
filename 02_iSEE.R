## ----"cargar_librerias_iSEE"-------------------------------------------------------------------------------------------------------
## Carguemos las librerías que vamos a usar para esta parte del mini curso

## Infraestructura
library("SummarizedExperiment")
library("SingleCellExperiment")
## library("SpatialExperiment") ## A partir de Bioconductor 3.13
## que estará disponible a finales de mayo 2021

## Para descargar y procesar datos
library("scRNAseq")
library("scater")
library("Rtsne")
library("recount3")

## Para visualizar los datos
library("iSEE")


## ----"datos_scRNAseq", message = FALSE---------------------------------------------------------------------------------------------
## Descarguemos datos de ejemplo de scRNA-seq del proyecto de
## Tasic et al 2016
sce <- ReprocessedAllenData(assays = "tophat_counts")
sce


## ----"procesar_datos"--------------------------------------------------------------------------------------------------------------
## Normalizamos los datos
sce <- logNormCounts(sce, exprs_values = "tophat_counts")

## Obtenemos dimensiones reducidas usando primero un análisis de componentes
## principales y luego con tSNE
set.seed(1000)
sce <- runPCA(sce)
sce <- runTSNE(sce)

## Ahora tenemos datos de PCA y TSNE en nuestro objeto de R
reducedDimNames(sce)

## Podemos ahora calcular unas variables a lo largo de nuestros genes
## tal como la expresión media del gene en las células
## y la varianza
rowData(sce)$mean_log <- rowMeans(logcounts(sce))
rowData(sce)$var_log <- apply(logcounts(sce), 1, var)
rowData(sce)


## ----'recount3_quick_example', message = FALSE-------------------------------------------------------------------------------------
## Revisemos todos los proyectos con datos de humano en recount3
human_projects <- available_projects()

## Veamos cuantos proyectos hay
nrow(human_projects)

## Encuentra tu proyecto de interés. Aquí usaremos
## SRP009615 de ejemplo
proj_info <- subset(
    human_projects,
    project == "SRP009615" & project_type == "data_sources"
)
## Crea un objetio de tipo RangedSummarizedExperiment (RSE)
## con la información a nivel de genes
rse_gene_SRP009615 <- create_rse(proj_info)
## Explora el objeto RSE
rse_gene_SRP009615


## ----"tranform_counts"-------------------------------------------------------------------------------------------------------------
## Convirtamos las cuentas por nucleotido a cuentas por lectura
## usando compute_read_counts().
## Para otras transformaciones como RPKM y TPM, revisa transform_counts().
assay(rse_gene_SRP009615, "counts") <- compute_read_counts(rse_gene_SRP009615)


## ----"expand_attributes"-----------------------------------------------------------------------------------------------------------
## Para este estudio en específico, hagamos más fácil de usar la
## información del experimento
rse_gene_SRP009615 <- expand_sra_attributes(rse_gene_SRP009615)
colData(rse_gene_SRP009615)[
    ,
    grepl("^sra_attribute", colnames(colData(rse_gene_SRP009615)))
]


## ----"explora_sce_con_iSEE"--------------------------------------------------------------------------------------------------------
if (interactive()) {
    iSEE(sce, appTitle = "Aprendiendo a usar iSEE")
}


## ----"explora_rse_gene_SRP009615"--------------------------------------------------------------------------------------------------
if (interactive()) {
    iSEE(rse_gene_SRP009615, appTitle = "iSEE con datos de recount3")
}

