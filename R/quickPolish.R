#' Polish CAGEexp data
#' @description
#' Fixes sample names and adds metadata. Use before [quickMQC()].
#'
#'
#' @param ce CAGEexp object
#' @param reads Barcelona, Okinawa or Osaka reads
#'
#' @return CAGEexp object
#' @importFrom CAGEr sampleLabels
#' @examples
#' \dontrun{
#' quickPolish(ce, reads = 'bar')
#' }
#' @export
quickPolish <- function(ce, reads = c('bar', 'oki', 'osa')) {
  version <- '3.12'
  if (reads == 'bar'){
    ce$SLfound  <- grepl('SL', CAGEr::sampleLabels(ce))
    ce$SLfactor <- ce$SLfound |>
      factor(labels = c('SL not found', 'SL found'))
    ce$sampleType <- 'Adult'
    ce$sampleType[grepl('Rep', CAGEr::sampleLabels(ce))] <- 'Embry'
    # remove X from sample name and remove 'names' attribute
    ce$RNA <- CAGEr::sampleLabels(ce) |>
      sub(pattern = '_SL.*|_no.*', replacement = '') |>
      sub(pattern = '^X', replacement = '') |>
      unname()
    ce$Description <-
      paste0('Oikopleura dioica (Barcelona) CAGE library prepared by DNAFORM in 2022 from the RNA sample ',
             ce$RNA, '. ',
             ifelse(ce$SLfound, 'A splice leader sequence was found and removed. ',
                    'no splice leader sequence was found. '),
             paste0('The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ', version, "."))
  }
  if (reads == 'oki') {
    ce$SLfound <- grepl("SL", CAGEr::sampleLabels(ce))
    ce$SLfactor <- ce$SLfound |>
      factor(labels = c('SL not found', 'SL found'))
    ce$sampleType[grepl("EB", CAGEr::sampleLabels(ce))] <- "EB"
    ce$sampleType[grepl("DE", CAGEr::sampleLabels(ce))] <- "DE"
    ce$RNA <-
      CAGEr::sampleLabels(ce) |>
      sub(pattern = '_SL.*|_no.*', replacement = '') |>
      sub(pattern = '^X', replacement = '') |>
      unname()
    ce$Description <-
      paste0('Oikopleura dioica (Okinawa) CAGE library prepared by DNAFORM in 2021 from the RNA sample ',
             ce$RNA, '. ',
             ifelse(ce$SLfound, "A splice leader sequence was found and removed. ",
                    "No splice leader sequence was found. "),
             paste0("The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ", version, "."))
  }
  if (reads == 'osa') {
    ce$SLfound <- grepl("SL", CAGEr::sampleLabels(ce))
    ce$SLfactor <- ce$SLfound |>
      factor(labels = c('SL not found', 'SL found'))
    ce$sampleType[grepl("EB", CAGEr::sampleLabels(ce))] <- "EB"
    ce$sampleType[grepl("DE", CAGEr::sampleLabels(ce))] <- "DE"
    ce$RNA <-
      CAGEr::sampleLabels(ce) |>
      sub(pattern = '_SL.*|_no.*', replacement = '') |>
      sub(pattern = '^X', replacement = '') |>
      unname()
    ce$Description <-
      paste0("Oikopleura dioica (Osaka) CAGE library prepared by DNAFORM in 2022 from the RNA sample ",
             ce$RNA, '. ',
             ifelse(ce$SLfound, "A splice leader sequence was found and removed. ",
                    "No splice leader sequence was found. "),
             paste0("The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ", version, "."))
  }
  ce
}
