#' Function implementing the scope parameter of the \link{mapStats} function
#' Credit: Charles Plessy
#' Note: had to remove .checkLibsDataFrame, as it couldn't be imported from CAGEr
#'
#' @param libs A data frame containing metadata describing samples in sequence libraries
#'
#' @return Returns a list with three elements: `libs` contains a modified
#' version of the input data frame where columns have been reorganised as needed,
#' `colums` contains the names of the columns to use for plotting and
#' provides the order of the stacked bars of the `plotAnnot` function,
#' `total` indicates the total counts used for normalising the data.
#'
#'
#' @export
msScope_nfcore_rnaseq <- function(libs) {
  libs$rDNA           <- libs$rdna
  libs$Unmapped       <-
    libs$paired_total - libs$paired_aligned_one - libs$paired_aligned_multi
  libs$Multimapped    <- libs$paired_aligned_multi
  libs$UniquelyMapped <- libs$paired_aligned_one
  libs$Discarded      <- libs$realLibrarySizes - libs$extracted
  list(
    libs = libs,
    columns = c(
      'Discarded',
      'rDNA',
      'Unmapped',
      'Multimapped',
      'UniquelyMapped'
    ),
    total = libs$realLibrarySizes
  )
}
