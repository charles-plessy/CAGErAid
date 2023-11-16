
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
#> CAGEr (a9d5ab24d... -> 18d72958c...) [GitHub]
#> Skipping 4 packages not available: SummarizedExperiment, S4Vectors, rtracklayer, BiocGenerics
#> Downloading GitHub repo charles-plessy/CAGEr@HEAD
#> S4Vectors    (0.38.2  -> 0.40.1) [CRAN]
#> GenomicRa... (1.52.1  -> 1.54.1) [CRAN]
#> stringi      (1.7.12  -> 1.8.1 ) [CRAN]
#> htmltools    (0.5.6.1 -> 0.5.7 ) [CRAN]
#> stringr      (1.5.0   -> 1.5.1 ) [CRAN]
#> rtracklayer  (1.60.1  -> 1.62.0) [CRAN]
#> Installing 6 packages: S4Vectors, GenomicRanges, stringi, htmltools, stringr, rtracklayer
#> Installing packages into '/tmp/RtmpyJo9bw/temp_libpath213fac5ccc0136'
#> (as 'lib' is unspecified)
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpNucZiA/remotes21ac956b5e7ba8/charles-plessy-CAGEr-18d7295/DESCRIPTION’ ... OK
#> * preparing ‘CAGEr’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * building ‘CAGEr_2.9.0.tar.gz’
#> Installing package into '/tmp/RtmpyJo9bw/temp_libpath213fac5ccc0136'
#> (as 'lib' is unspecified)
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/RtmpNucZiA/remotes21ac95241c6e04/a-klarkowska-CAGErAid-ebf3f89/DESCRIPTION’ ... OK
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
#>     ‘CAGErAid/inst/extdata/ce_clean.rds’
#> * building ‘CAGErAid_0.0.0.9000.tar.gz’
#> Installing package into '/tmp/RtmpyJo9bw/temp_libpath213fac5ccc0136'
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
  quickPolish() |> 
  quickMQC(guess_path = TRUE)
```

To easily annotate data, we can use `quickGFF()`.

``` r
gff_path <- system.file('extdata', 'Barcelona.gtf', package = 'CAGErAid')
gff <- quickGFF(gff_path, types = c('transcript', 'exon'))
ce <- CAGEr::annotateCTSS(ce, gff)
```
