
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
devtools::install_github('a-klarkowska/CAGErAid') |> suppressMessages()
#> 
#> ── R CMD build ─────────────────────────────────────────────────────────────────
#> * checking for file ‘/tmp/Rtmp8dksXo/remotesf116ec0193eb/a-klarkowska-CAGErAid-812903c/DESCRIPTION’ ... OK
#> * preparing ‘CAGErAid’:
#> * checking DESCRIPTION meta-information ... OK
#> * checking for LF line-endings in source and make files and shell scripts
#> * checking for empty or unneeded directories
#> * looking to see if a ‘data/datalist’ file should be added
#>   NB: this package now depends on R (>= 3.5.0)
#>   WARNING: Added dependency on R >= 3.5.0 because serialized objects in
#>   serialize/load version 3 cannot be read in older versions of R.
#>   File(s) containing such objects:
#>     ‘CAGErAid/data/ce_clean.rds’
#> * building ‘CAGErAid_0.0.0.9000.tar.gz’
```

## Polishing data

After cross-aligning CAGE reads to the Barcelona, Osaka and Okinawa
genomes, we can use
[`getCTSS()`](https://rdrr.io/bioc/CAGEr/man/getCTSS.html) on a CAGEexp
object. For details on how to load the data, see [this
vignette](vignettes/loading.Rmd). To add metadata, use `quickPolish()`
and `quickMQC()`.

``` r

library(CAGErAid) |> suppressPackageStartupMessages()

# load CAGEexp object - Barcelona reads aligned to Barcelona genome
ce <- readRDS('data/ce_clean.rds')
SummarizedExperiment::colData(ce)
#> DataFrame with 4 rows and 4 columns
#>                      inputFiles sampleLabels inputFilesType librarySizes
#>                     <character>  <character>    <character>    <integer>
#> X14FE_no /bucket/LuscombeU/li..     X14FE_no   bamPairedEnd     27248236
#> X14FE_SL /bucket/LuscombeU/li..     X14FE_SL   bamPairedEnd     90180130
#> X29FE_no /bucket/LuscombeU/li..     X29FE_no   bamPairedEnd     24550939
#> X29FE_SL /bucket/LuscombeU/li..     X29FE_SL   bamPairedEnd     79057679
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
SummarizedExperiment::colData(ce)
#> DataFrame with 4 rows and 15 columns
#>                      inputFiles sampleLabels inputFilesType librarySizes
#>                     <character>  <character>    <character>    <integer>
#> X14FE_no /bucket/LuscombeU/li..     X14FE_no   bamPairedEnd     27248236
#> X14FE_SL /bucket/LuscombeU/li..     X14FE_SL   bamPairedEnd     90180130
#> X29FE_no /bucket/LuscombeU/li..     X29FE_no   bamPairedEnd     24550939
#> X29FE_SL /bucket/LuscombeU/li..     X29FE_SL   bamPairedEnd     79057679
#>            SLfound     SLfactor  sampleType         RNA            Description
#>          <logical>     <factor> <character> <character>            <character>
#> X14FE_no     FALSE SL not found       Adult        14FE Oikopleura dioica (B..
#> X14FE_SL      TRUE SL found           Adult        14FE Oikopleura dioica (B..
#> X29FE_no     FALSE SL not found       Adult        29FE Oikopleura dioica (B..
#> X29FE_SL      TRUE SL found           Adult        29FE Oikopleura dioica (B..
#>          paired_aligned_one paired_aligned_multi paired_total realLibrarySizes
#>                   <integer>            <integer>    <integer>        <numeric>
#> X14FE_no           27248236               382171     34825962         65516433
#> X14FE_SL           90180130               493855     98228663         98308339
#> X29FE_no           24550939               329981     31714001         49299303
#> X29FE_SL           79057679               361543     85417205         85506080
#>          extracted      rdna
#>          <numeric> <numeric>
#> X14FE_no  65512902  30686940
#> X14FE_SL  98241634     12971
#> X29FE_no  49297283  17583282
#> X29FE_SL  85428741     11536
```

To easily annotate data, we can use `quickGFF()`.

``` r

gff <- quickGFF('data/Barcelona.gtf', types = c('transcript', 'exon'))
ce <- CAGEr::annotateCTSS(ce, gff)
```
