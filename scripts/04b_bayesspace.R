library(BayesSpace)
library(SingleCellExperiment)
library(scran)
library(scater)
library(Matrix) 
library(mclust)
set.seed(1)

dir <- "../data/processed"
counts <- readMM(file.path(dir, "counts.mtx"))
genes <- read.csv(file.path(dir, "genes.csv"))
meta <- read.csv(file.path(dir, "metadata.csv"))

rownames(counts) <- genes$gene
colnames(counts) <- meta$barcode


sce <- SingleCellExperiment(
    assays = list(counts = counts),
    colData = meta
)
colData(sce)$row <- meta$array_row
colData(sce)$col <- meta$array_col

sce <- spatialPreprocess(sce, platform="Visium", n.PCs=15)
sce <- spatialCluster(sce, q=7, platform="Visium", nrep=50000, gamma=2, save.chain=FALSE)

results <- data.frame(
    barcode = colnames(sce),
    bayesspace_cluster = colData(sce)$spatial.cluster
)
write.csv(results, "../results/bayesspace_clusters.csv", row.names=FALSE)
cat("BayesSpace done\n")