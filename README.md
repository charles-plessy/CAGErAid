
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
#> CAGEr (a9d5ab24d... -> 18d72958c...) [GitHub]
#> S4Vectors    (0.38.2  -> 0.40.2) [CRAN]
#> GenomicRa... (1.52.1  -> 1.54.1) [CRAN]
#> stringi      (1.7.12  -> 1.8.2 ) [CRAN]
#> tinytex      (0.48    -> 0.49  ) [CRAN]
#> bslib        (0.5.1   -> 0.6.0 ) [CRAN]
#> htmlwidgets  (1.6.2   -> 1.6.3 ) [CRAN]
#> deldir       (1.0-9   -> 2.0-2 ) [CRAN]
#> htmltools    (0.5.6.1 -> 0.5.7 ) [CRAN]
#> VariantAn... (1.48.0  -> 1.48.1) [CRAN]
#> Gviz         (1.46.0  -> 1.46.1) [CRAN]
#> dplyr        (1.1.3   -> 1.1.4 ) [CRAN]
#> stringr      (1.5.0   -> 1.5.1 ) [CRAN]
#> rtracklayer  (1.60.1  -> 1.62.0) [CRAN]
#> gtools       (3.9.4   -> 3.9.5 ) [CRAN]
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpZp4R1K/remotes198ebd681e38b1/charles-plessy-CAGEr-18d7295/DESCRIPTION’ ... OK
#> * preparing ‘CAGEr’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘CAGEr_2.9.0.tar.gz’
#> 
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpZp4R1K/remotes198ebd2c26c46d/a-klarkowska-CAGErAid-e14de76/DESCRIPTION’ ... OK
#> * preparing ‘CAGErAid’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * looking to see if a ‘data/datalist’ file should be added
#>   NB: this package now depends on R (>= 3.5.0)
#>   WARNING: Added dependency on R >= 3.5.0 because serialized objects in
#>   serialize/load version 3 cannot be read in older versions of R.
#>   File(s) containing such objects:
#>     ‘CAGErAid/inst/extdata/ce_clean.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OKItoOSA.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OKItoOSA_SL.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OKItoOSA_no.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OKItoOSA_polished.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OSAtoOSA.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OSAtoOSA_SL.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OSAtoOSA_no.rds’
#>     ‘CAGErAid/inst/extdata/example_CAGEexp/OSAtoOSA_polished.rds’
#> * building ‘CAGErAid_0.0.0.9000.tar.gz’
```

## Polishing data

After cross-aligning CAGE reads to the Barcelona, Osaka and Okinawa
genomes, we can use
[`getCTSS()`](https://rdrr.io/bioc/CAGEr/man/getCTSS.html) on a CAGEexp
object. For details on how to load the data, see [this
vignette](vignettes/loading_polishing.Rmd).

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
  quickPolish() |> 
  quickMQC()
```

To easily annotate data, we can use `quickGFF()`.

``` r
gff_path <- system.file('extdata', 'Barcelona.gtf', package = 'CAGErAid')
gff <- quickGFF(gff_path, types = c('transcript', 'exon'))
ce <- CAGEr::annotateCTSS(ce, gff)
```

For more details on the cross-alignments analysis workflow, consult the
vignettes on [loading the data, polishing it and basic stats
analysis](vignettes/loading_polishing.Rmd), and clustering of
[SL-containing samples](vignettes/clustering_sl.Rmd) and [samples
without SL](vignettes/clustering_no.Rmd).
