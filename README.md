
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
#> CAGEr (0c79a3a59... -> 052116f7c...) [GitHub]
#> zlibbioc     (1.46.0 -> 1.48.0) [CRAN]
#> XVector      (0.40.0 -> 0.42.0) [CRAN]
#> SparseArray  (NA     -> 1.2.0 ) [CRAN]
#> S4Arrays     (1.0.6  -> 1.2.0 ) [CRAN]
#> IRanges      (2.34.1 -> 2.36.0) [CRAN]
#> S4Vectors    (0.38.2 -> 0.40.0) [CRAN]
#> MatrixGen... (1.12.3 -> 1.14.0) [CRAN]
#> BiocGenerics (0.46.0 -> 0.48.0) [CRAN]
#> GenomeInf... (1.2.10 -> 1.2.11) [CRAN]
#> GenomeInfoDb (1.36.4 -> 1.38.0) [CRAN]
#> DelayedArray (0.26.7 -> 0.28.0) [CRAN]
#> Biobase      (2.60.0 -> 2.62.0) [CRAN]
#> Rhtslib      (2.2.0  -> 2.4.0 ) [CRAN]
#> BiocParallel (1.34.2 -> 1.36.0) [CRAN]
#> Rsamtools    (2.16.0 -> 2.18.0) [CRAN]
#> Biostrings   (2.68.1 -> 2.70.0) [CRAN]
#> Summarize... (1.30.2 -> 1.32.0) [CRAN]
#> GenomicRa... (1.52.1 -> 1.54.0) [CRAN]
#> vctrs        (0.6.3  -> 0.6.4 ) [CRAN]
#> utf8         (1.2.3  -> 1.2.4 ) [CRAN]
#> checkmate    (2.2.0  -> 2.3.0 ) [CRAN]
#> ProtGenerics (1.32.0 -> 1.34.0) [CRAN]
#> Annotatio... (1.24.0 -> 1.26.0) [CRAN]
#> VariantAn... (1.46.0 -> 1.48.0) [CRAN]
#> BiocFileC... (2.8.0  -> 2.10.0) [CRAN]
#> KEGGREST     (1.40.1 -> 1.42.0) [CRAN]
#> BiocIO       (1.10.0 -> 1.12.0) [CRAN]
#> GenomicAl... (1.36.0 -> 1.38.0) [CRAN]
#> biovizBase   (1.48.0 -> 1.50.0) [CRAN]
#> BSgenome     (1.68.0 -> 1.70.0) [CRAN]
#> ensembldb    (2.24.1 -> 2.26.0) [CRAN]
#> GenomicFe... (1.52.2 -> 1.54.0) [CRAN]
#> Annotatio... (1.62.2 -> 1.64.0) [CRAN]
#> biomaRt      (2.56.1 -> 2.58.0) [CRAN]
#> Gviz         (1.44.2 -> 1.46.0) [CRAN]
#> rtracklayer  (1.60.1 -> 1.62.0) [CRAN]
#> Interacti... (1.28.1 -> 1.30.0) [CRAN]
#> sparseMat... (1.12.2 -> 1.14.0) [CRAN]
#> GenomicIn... (1.34.0 -> 1.36.0) [CRAN]
#> GenomicFiles (1.36.0 -> 1.38.0) [CRAN]
#> BiocBaseU... (1.2.0  -> 1.4.0 ) [CRAN]
#> DelayedMa... (1.22.6 -> 1.24.0) [CRAN]
#> CAGEfightR   (1.20.0 -> 1.22.0) [CRAN]
#> MultiAssa... (1.26.0 -> 1.28.0) [CRAN]
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpvebMt3/remotesd8b8a4c7f2f61/charles-plessy-CAGEr-052116f/DESCRIPTION’ ... OK
#> * preparing ‘CAGEr’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘CAGEr_2.7.2.tar.gz’
#> 
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpvebMt3/remotesd8b8a4becde2/a-klarkowska-CAGErAid-e4d60da/DESCRIPTION’ ... OK
#> * preparing ‘CAGErAid’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * looking to see if a ‘data/datalist’ file should be added
#>   NB: this package now depends on R (>= 3.5.0)
#>   WARNING: Added dependency on R >= 3.5.0 because serialized objects in
#>   serialize/load version 3 cannot be read in older versions of R.
#>   File(s) containing such objects:
#>     ‘CAGErAid/data/ce_clean.rds’ ‘CAGErAid/inst/extdata/ce_clean.rds’
#> * building ‘CAGErAid_0.0.0.9000.tar.gz’
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
  quickMQC(guess_path = TRUE, check_multimap = TRUE)
#> [1] "Multimapped reads have been removed by the pipeline"
```

To easily annotate data, we can use `quickGFF()`.

``` r
gff_path <- system.file('extdata', 'Barcelona.gtf', package = 'CAGErAid')
gff <- quickGFF(gff_path, types = c('transcript', 'exon'))
ce <- CAGEr::annotateCTSS(ce, gff)
```
