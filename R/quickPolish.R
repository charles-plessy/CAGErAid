#' Polish CAGEexp data
#' @description
#' Fixes sample names and adds metadata. Use before [quickMQC()].
#'
#' @param ce CAGEexp object
#'
#' @return CAGEexp object
#' @importFrom CAGEr sampleLabels
#' @examples
#' \dontrun{
#' quickPolish(ce)
#' }
#' @export
quickPolish <- function(ce) {
  v <- '3.12'
  samples_bar <- c("FE14_no", "FE14_SL", "FE29_no", "FE29_SL", "MA41_no", "MA41_SL", 'X14FE_no', 'X14FE_SL', 'X29FE_no', 'X29FE_SL', 'X41MA_no', 'X41MA_SL', 'D1D4_no', 'D1D4_SL', 'D4D5_no', 'D4D5_SL', 'Rep1_no', 'Rep1_SL', 'Rep2_no', 'Rep2_SL', 'Rep3_no', 'Rep3_SL', 'Rep4_no', 'Rep4_SL')
  samples_oki <- c('DE1_no_T1', 'DE1_SL_T1', 'DE2_no_T1', 'DE2_SL_T1', 'EB1_no_T1', 'EB1_SL_T1', 'EB2_no_T1', 'EB2_SL_T1', 'EB3_no_T1', 'EB3_SL_T1')
  samples_osa <- c('D2_T1_no_T1', 'D2_T1_SL_T1', 'DE1_T1_no_T1', 'DE1_T1_SL_T1', 'DE2_T1_no_T1', 'DE2_T1_SL_T1', 'EB1_T1_no_T1', 'EB1_T1_SL_T1', 'EB2_T1_no_T1', 'EB2_T1_SL_T1', 'EB3_T1_no_T1', 'EB3_T1_SL_T1')
  ce$reads[CAGEr::sampleLabels(ce) %in% samples_bar] <- 'Bar'
  ce$reads[CAGEr::sampleLabels(ce) %in% samples_oki] <- 'Oki'
  ce$reads[CAGEr::sampleLabels(ce) %in% samples_osa] <- 'Osa'

  ce$SLfound <- grepl("SL", CAGEr::sampleLabels(ce))
  ce$SLfactor <- ce$SLfound |>
    factor(labels = c('SL not found', 'SL found'))

  ce$sampleType <- 'Adult'
  ce$sampleType[grepl('Rep', CAGEr::sampleLabels(ce))] <- 'Embry'
  ce$sampleType[grepl('EB', CAGEr::sampleLabels(ce))] <- 'Embry'
  ce$sampleType[grepl('D2', CAGEr::sampleLabels(ce))] <- 'JuvD2'

  ce$RNA <-
    CAGEr::sampleLabels(ce) |>
    sub(pattern = '_SL.*|_no.*', replacement = '') |>
    sub(pattern = '^X', replacement = '') |>
    unname()

  ce$Description[CAGEr::sampleLabels(ce) %in% samples_bar] <-
    paste0('Oikopleura dioica (Barcelona) CAGE library prepared by DNAFORM in 2022 from the RNA sample ',
           ce$RNA[CAGEr::sampleLabels(ce) %in% samples_bar], '. ',
           ifelse(ce$SLfound[CAGEr::sampleLabels(ce) %in% samples_bar], 'A splice leader sequence was found and removed. ',
                  'no splice leader sequence was found. '),
           paste0('The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ', v, "."))

  ce$Description[CAGEr::sampleLabels(ce) %in% samples_oki] <-
    paste0('Oikopleura dioica (Okinawa) CAGE library prepared by DNAFORM in 2021 from the RNA sample ',
           ce$RNA[CAGEr::sampleLabels(ce) %in% samples_oki], '. ',
           ifelse(ce$SLfound[CAGEr::sampleLabels(ce) %in% samples_oki], "A splice leader sequence was found and removed. ",
                  "No splice leader sequence was found. "),
           paste0("The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ", v, "."))

  ce$Description[CAGEr::sampleLabels(ce) %in% samples_osa] <-
    paste0("Oikopleura dioica (Osaka) CAGE library prepared by DNAFORM in 2022 from the RNA sample ",
           ce$RNA[CAGEr::sampleLabels(ce) %in% samples_osa], '. ',
           ifelse(ce$SLfound[CAGEr::sampleLabels(ce) %in% samples_osa], "A splice leader sequence was found and removed. ",
                  "No splice leader sequence was found. "),
           paste0("The reads where then aligned with HISAT2 using the nf-core RNA-seq pipeline version ", v, "."))

  ce
}
