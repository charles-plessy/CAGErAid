#' Transforms a CAGEexp object into a CAGEfightR-friendly object
#' @description
#' Transforms a CAGEexp object into a `RangedSummarizedExperiment` object, which can be used with various `CAGEfightR` functions.
#' The output is similar to that of [`CAGEfightR::quantifyCTSSs()`].
#'
#' @param ce a CAGEexp object
#'
#' @return A `RangedSummarizedExperiment` object
#' @importFrom CAGEr CTSStagCountSE
#' @importFrom SummarizedExperiment colData
#' @importFrom SummarizedExperiment rowRanges
#' @importFrom SummarizedExperiment assays
#' @importFrom S4Vectors List
#' @importFrom MultiAssayExperiment assay
#'
#' @examples
#' \dontrun{
#' asCAGEfightR(ce)
#' }
#'
#' @export
asCAGEfightR <- function(ce) {
  se <- CAGEr::CTSStagCountSE(ce)
  SummarizedExperiment::colData(se) <- SummarizedExperiment::colData(ce)
  SummarizedExperiment::rowRanges(se) <- as(SummarizedExperiment::rowRanges(se), "StitchedGPos")
  SummarizedExperiment::colData(se)$Name <- SummarizedExperiment::colData(se)$sampleLabels
  SummarizedExperiment::assays(se) <- S4Vectors::List(counts=as(as.matrix(S4Vectors::as.data.frame(MultiAssayExperiment::assay(se))), "dgCMatrix"))
  se
}
