
<!-- README.md is generated from README.Rmd. Please edit that file -->

# CAGErAid

<!-- badges: start -->
<!-- badges: end -->

The goal of CAGErAid is to assist in using
[CAGEr](https://rdrr.io/bioc/CAGEr/) for analysis of CAGE data for
cross-alignments between Barcelona, Osaka and Okinawa samples of
Oikopleura dioica, with and without splice leader sequences.

## Installation

You can install the development version of CAGErAid from
[GitHub](https://github.com/) with:

``` r
# install.packages("devtools")
devtools::install_github('a-klarkowska/CAGErAid') |> suppressPackageStartupMessages()
#> Downloading GitHub repo a-klarkowska/CAGErAid@HEAD
#> CAGEr (0c79a3a59... -> 18d72958c...) [GitHub]
#> Skipping 4 packages not available: SummarizedExperiment, S4Vectors, rtracklayer, BiocGenerics
#> Downloading GitHub repo charles-plessy/CAGEr@HEAD
#> zlibbioc     (1.46.0    -> 1.48.0   ) [CRAN]
#> XVector      (0.40.0    -> 0.42.0   ) [CRAN]
#> SparseArray  (NA        -> 1.2.0    ) [CRAN]
#> S4Arrays     (1.0.6     -> 1.2.0    ) [CRAN]
#> IRanges      (2.34.1    -> 2.36.0   ) [CRAN]
#> S4Vectors    (0.38.2    -> 0.40.1   ) [CRAN]
#> MatrixGen... (1.12.3    -> 1.14.0   ) [CRAN]
#> BiocGenerics (0.46.0    -> 0.48.1   ) [CRAN]
#> GenomeInf... (1.2.10    -> 1.2.11   ) [CRAN]
#> RCurl        (1.98-1.12 -> 1.98-1.13) [CRAN]
#> GenomeInfoDb (1.36.4    -> 1.38.0   ) [CRAN]
#> XML          (3.99-0.14 -> 3.99-0.15) [CRAN]
#> DelayedArray (0.26.7    -> 0.28.0   ) [CRAN]
#> Biobase      (2.60.0    -> 2.62.0   ) [CRAN]
#> Rhtslib      (2.2.0     -> 2.4.0    ) [CRAN]
#> BiocParallel (1.34.2    -> 1.36.0   ) [CRAN]
#> Rsamtools    (2.16.0    -> 2.18.0   ) [CRAN]
#> Biostrings   (2.68.1    -> 2.70.1   ) [CRAN]
#> Summarize... (1.30.2    -> 1.32.0   ) [CRAN]
#> GenomicRa... (1.52.1    -> 1.54.1   ) [CRAN]
#> rlang        (1.1.1     -> 1.1.2    ) [CRAN]
#> xfun         (0.40      -> 0.41     ) [CRAN]
#> evaluate     (0.22      -> 0.23     ) [CRAN]
#> RcppEigen    (0.3.3.9.3 -> 0.3.3.9.4) [CRAN]
#> knitr        (1.44      -> 1.45     ) [CRAN]
#> htmltools    (0.5.6.1   -> 0.5.7    ) [CRAN]
#> htmlTable    (2.4.1     -> 2.4.2    ) [CRAN]
#> ProtGenerics (1.32.0    -> 1.34.0   ) [CRAN]
#> Annotatio... (1.24.0    -> 1.26.0   ) [CRAN]
#> VariantAn... (1.46.0    -> 1.48.0   ) [CRAN]
#> BiocFileC... (2.8.0     -> 2.10.1   ) [CRAN]
#> KEGGREST     (1.40.1    -> 1.42.0   ) [CRAN]
#> RSQLite      (2.3.1     -> 2.3.3    ) [CRAN]
#> BiocIO       (1.10.0    -> 1.12.0   ) [CRAN]
#> GenomicAl... (1.36.0    -> 1.38.0   ) [CRAN]
#> biovizBase   (1.48.0    -> 1.50.0   ) [CRAN]
#> BSgenome     (1.68.0    -> 1.70.1   ) [CRAN]
#> ensembldb    (2.24.1    -> 2.26.0   ) [CRAN]
#> GenomicFe... (1.52.2    -> 1.54.1   ) [CRAN]
#> Annotatio... (1.62.2    -> 1.64.1   ) [CRAN]
#> biomaRt      (2.56.1    -> 2.58.0   ) [CRAN]
#> withr        (2.5.1     -> 2.5.2    ) [CRAN]
#> Gviz         (1.44.2    -> 1.46.0   ) [CRAN]
#> rtracklayer  (1.60.1    -> 1.62.0   ) [CRAN]
#> Interacti... (1.28.1    -> 1.30.0   ) [CRAN]
#> sparseMat... (1.12.2    -> 1.14.0   ) [CRAN]
#> GenomicIn... (1.34.0    -> 1.36.0   ) [CRAN]
#> GenomicFiles (1.36.0    -> 1.38.0   ) [CRAN]
#> BiocBaseU... (1.2.0     -> 1.4.0    ) [CRAN]
#> DelayedMa... (1.22.6    -> 1.24.0   ) [CRAN]
#> CAGEfightR   (1.20.0    -> 1.22.0   ) [CRAN]
#> MultiAssa... (1.26.0    -> 1.28.0   ) [CRAN]
#> Installing 52 packages: zlibbioc, XVector, SparseArray, S4Arrays, IRanges, S4Vectors, MatrixGenerics, BiocGenerics, GenomeInfoDbData, RCurl, GenomeInfoDb, XML, DelayedArray, Biobase, Rhtslib, BiocParallel, Rsamtools, Biostrings, SummarizedExperiment, GenomicRanges, rlang, xfun, evaluate, RcppEigen, knitr, htmltools, htmlTable, ProtGenerics, AnnotationFilter, VariantAnnotation, BiocFileCache, KEGGREST, RSQLite, BiocIO, GenomicAlignments, biovizBase, BSgenome, ensembldb, GenomicFeatures, AnnotationDbi, biomaRt, withr, Gviz, rtracklayer, InteractionSet, sparseMatrixStats, GenomicInteractions, GenomicFiles, BiocBaseUtils, DelayedMatrixStats, CAGEfightR, MultiAssayExperiment
#> Installing packages into '/tmp/Rtmp0sA0qG/temp_libpath36f1c49b9f5d4'
#> (as 'lib' is unspecified)
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpTegZqm/remotes3792a5646176ce/charles-plessy-CAGEr-18d7295/DESCRIPTION’ ... OK
#> * preparing ‘CAGEr’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘CAGEr_2.9.0.tar.gz’
#> Installing package into '/tmp/Rtmp0sA0qG/temp_libpath36f1c49b9f5d4'
#> (as 'lib' is unspecified)
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpTegZqm/remotes3792a57e9163a3/a-klarkowska-CAGErAid-afdddd4/DESCRIPTION’ ... OK
#> * preparing ‘CAGErAid’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> Removed empty directory ‘CAGErAid/vignettes’
#> * looking to see if a ‘data/datalist’ file should be added
#>   NB: this package now depends on R (>= 3.5.0)
#>   WARNING: Added dependency on R >= 3.5.0 because serialized objects in
#>   serialize/load version 3 cannot be read in older versions of R.
#>   File(s) containing such objects:
#>     ‘CAGErAid/data/ce_clean.rds’ ‘CAGErAid/inst/extdata/ce_clean.rds’
#> * building ‘CAGErAid_0.0.0.9000.tar.gz’
#> Installing package into '/tmp/Rtmp0sA0qG/temp_libpath36f1c49b9f5d4'
#> (as 'lib' is unspecified)
```

## Polishing data

After cross-aligning CAGE reads to the Barcelona, Osaka and Okinawa
genomes, we can use
[`getCTSS()`](https://rdrr.io/bioc/CAGEr/man/getCTSS.html) on a CAGEexp
object. For details on how to load the data, see [this
vignette](vignettes/loading.Rmd).

``` r
library(CAGErAid) |> suppressPackageStartupMessages()

# load CAGEexp object - Barcelona reads aligned to Barcelona genome
ce_path <- system.file("extdata", "ce_clean.rds", package="CAGErAid")
ce <- readRDS(ce_path)
```

The CAGEexp file could use some polishing on the sample names and a
little more information on the samples themselves. To do that, we can
use `quickPolish()`. To add metadata from the nf-core RNAseq pipeline
QC, we call `quickMQC()`.

``` r
ce <- ce |> 
  quickPolish(reads = 'bar') |> 
  quickMQC(guess_path = TRUE)
```

To easily annotate data, we can use `quickGFF()`.

``` r
gff_path <- system.file('extdata', 'Barcelona.gtf', package = 'CAGErAid')
gff <- quickGFF(gff_path, types = c('transcript', 'exon'))
ce <- CAGEr::annotateCTSS(ce, gff)
```
