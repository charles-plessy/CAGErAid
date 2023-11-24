#' Imports QC data
#'
#' @description Imports Hisat2 QC (multiqc_hisat2.txt) and general QC data (multiqc_general_stats.txt) and writes it into the CAGEexp object
#'
#'
#' @param ce CAGEexp object
#'
#' @return CAGEexp object
#' @importFrom CAGEr sampleLabels
#' @importFrom CAGEr librarySizes
#' @importFrom utils read.table
#'
#' @examples
#' \dontrun{
#' quickMQC(ce)
#' }
#'
#' @export
quickMQC <-  function(ce) {
  data <- ce$inputFiles |> dirname() |> unique()
  readtypes <- ce$reads |> unique()
  for (i in 1:length(readtypes)) {

    hisat <- data[i] |>
      sub(pattern = 'hisat2', replacement = 'multiqc/hisat2/multiqc_data/multiqc_hisat2.txt') |>
      utils::read.table(header = TRUE, sep = '\t')
    rownames(hisat) <- make.names(hisat$Sample)
    hisat <-
      hisat[ce$sampleLabels[grepl(readtypes[i], ce$reads)], ]
    ce$paired_aligned_one[grepl(readtypes[i], ce$reads)] <-
      hisat$paired_aligned_one
    ce$paired_aligned_multi[grepl(readtypes[i], ce$reads)] <-
      hisat$paired_aligned_multi
    ce$paired_total[grepl(readtypes[i], ce$reads)] <-
      hisat$paired_total

    qc <- data[i] |>
      sub(pattern = 'hisat2', replacement = 'multiqc/hisat2/multiqc_data/multiqc_general_stats.txt') |>
      utils::read.table(header = TRUE, sep = '\t')
    rownames(qc) <- make.names(qc$Sample)
    qc2 <- qc[paste0(rownames(hisat), '_2'), ]
    ce$realLibrarySizes[grepl(readtypes[i], ce$reads)] <-
      qc2$FastQC..raw._mqc.generalstats.fastqc_raw.total_sequences
    ce$extracted[grepl(readtypes[i], ce$reads)]  <-
      qc2$FastQC..trimmed._mqc.generalstats.fastqc_trimmed.total_sequences
    ce$rdna[grepl(readtypes[i], ce$reads)] <-
      ce$extracted[grepl(readtypes[i], ce$reads)] - ce$paired_total[grepl(readtypes[i], ce$reads)]
  }
  ce
}
