#' Imports QC data
#'
#' @description Imports Hisat2 QC (multiqc_hisat2.txt) and general QC data (multiqc_general_stats.txt) and writes it into the CAGEexp object
#'
#'
#' @param ce CAGEexp object
#' @param hisat table with multiqc_hisat2.txt data
#' @param qc table with multiqc_general_stats.txt data
#' @param check_multimap boolean, checks if all reads have been removed by the pipeline
#' @param guess_path boolean, if TRUE, checks if the multiqc_hisat2.txt and multiqc_general_stats.txt paths can be inferred from the input files in the CAGEexp object
#'
#' @return CAGEexp object
#' @importFrom CAGEr sampleLabels
#' @importFrom CAGEr librarySizes
#' @importFrom utils read.table
#'
#' @examples
#' \dontrun{
#' quickMQC(ce, guess_path = FALSE, hisat, qc, check_multimap = TRUE)
#' }
#'
#' @export
quickMQC <- function(ce, guess_path = TRUE, hisat = NULL, qc = NULL, check_multimap = FALSE) {

  if (guess_path == TRUE) {
    data <- ce$inputFiles |> dirname() |> unique()
    if (length(data) != 1)
      stop('No unique path for all files found! Provide paths to files.')
    hisat <-
      data |>
      sub(pattern = "hisat2", replacement = "multiqc/hisat2/multiqc_data/multiqc_hisat2.txt") |>
      utils::read.table(header = TRUE)
    qc <-
      data |>
      sub(pattern = "hisat2", replacement = "multiqc/hisat2/multiqc_data/multiqc_general_stats.txt") |>
      utils::read.table(header = TRUE, sep = '\t')
  }
  else {if (is.null(hisat) == TRUE | is.null(qc) == TRUE) stop('Provide paths to files!')}

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

  rownames(qc) <- make.names(qc$Sample)
  qc2 <- qc[paste0(CAGEr::sampleLabels(ce), '_2'), ]
  ce$realLibrarySizes <-
    qc2$FastQC..raw._mqc.generalstats.fastqc_raw.total_sequences
  ce$extracted  <-
    qc2$FastQC..trimmed._mqc.generalstats.fastqc_trimmed.total_sequences
  ce$rdna <- ce$extracted - ce$paired_total
  ce
}
