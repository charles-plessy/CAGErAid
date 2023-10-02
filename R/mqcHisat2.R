#' Imports Hisat2 QC data (multiqc_hisat2.txt) and writes it into the CAGEexp object
#'
#' @param ce CAGEexp object
#' @param hisat table with multiqc_hisat2.txt data
#' @param check_multimap optional; checks if all reads have been removed by the pipeline
#'
#' @return CAGEexp object
#'
#' @importFrom CAGEr sampleLabels
#' @importFrom CAGEr librarySizes
#' @importFrom utils read.table
#' @export
#'
#' @examples
#' \dontrun{
#' mqcHisat2(ce, hisat, check_multimap = TRUE)
#' }
#'
mqcHisat2 <- function(ce, hisat, check_multimap = FALSE) {
  rownames(hisat) <- make.names(hisat$Sample)
  hisat <- hisat[CAGEr::sampleLabels(ce), ]
  if (check_multimap == TRUE) {
    if (all(CAGEr::librarySizes(ce) == hisat$paired_aligned_one)) {
      print('Multimapped reads have been removed by the pipeline')
    }
    else
      print('Multimapped reads have not been removed by the pipeline')
  }
  ce$paired_aligned_one   <- hisat$paired_aligned_one
  ce$paired_aligned_multi <- hisat$paired_aligned_multi
  ce$paired_total         <- hisat$paired_total
  ce
}
