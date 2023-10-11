#' Imports general QC data (multiqc_general_stats.txt) and writes it into the CAGEexp object
#' Should be ran after quickStats and mqcHisat2
#'
#' @param ce CAGEexp object
#' @param qc table with multiqc_general_stats.txt data
#'
#' @return CAGEexp object
#' @importFrom CAGEr sampleLabels
#'
#' @examples
#' \dontrun{
#' mqcGenstats(ce, qc)
#' }
#'
#' @export
mqcGenstats <- function(ce, qc) {
  rownames(qc) <- make.names(qc$Sample)
  qc2.df <- qc[paste0(CAGEr::sampleLabels(ce), '_2'), ]
  ce$realLibrarySizes <-
    qc2.df$FastQC..raw._mqc.generalstats.fastqc_raw.total_sequences
  ce$extracted  <-
    qc2.df$FastQC..trimmed._mqc.generalstats.fastqc_trimmed.total_sequences
  ce$rdna <- ce$extracted - ce$paired_total
  ce
}
