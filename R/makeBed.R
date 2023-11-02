#' Exports clusters from CAGEexp object
#' @description Exports clusters from CAGEexp objects containing splice leader or splice leader removed data to black and white bed tracks.
#' For clusters, call \link[CAGErAid]{quickClustersSL} or \link[CAGErAid]{quickClustersNO}.
#'
#' @param ce CAGEexp object
#' @param sl_found boolean, whether splice leader has been found in data
#'
#' @return tracks in bed format
#' @importFrom CAGEr exportToTrack
#' @importFrom CAGEr flagByUpstreamSequences
#' @importFrom SummarizedExperiment rowRanges
#' @importFrom CAGEr consensusClustersSE
#' @importFrom BiocGenerics score
#' @importFrom S4Vectors decode
#' @importFrom graphics hist
#' @importFrom rtracklayer export.bed
#' @importFrom BiocGenerics width
#'
#'
#' @examples
#' \dontrun{
#' makeBed(ce, sl_found = TRUE)
#' }
#' @export
makeBed <- function(ce, sl_found){
  # with SL
  if (sl_found == TRUE) {
    scores <- BiocGenerics::score(CAGEr::consensusClustersGR(ce))
    cctrack <- CAGEr::consensusClustersGR(ce, qL=.1, qU=.9, returnInterquantileWidth = TRUE) |>
      CAGEr::exportToTrack(qL=.1, qU=.9)
    cctrack$score <- scores
    cctrack@trackLine@description <- "CAGE Consensus Clusters for trans splicing sites"
    cctrack@trackLine@name <- "sl"
    # Flat AG
    cctrack$itemRgb <- ifelse(CAGEr::flagByUpstreamSequences(SummarizedExperiment::rowRanges(CAGEr::consensusClustersSE(ce))$dominant_ctss, "AG"), "black", "grey")
    cctrack
  }
  else {
    scores <- BiocGenerics::score(CAGEr::consensusClustersGR(ce))
    cctrack <- CAGEr::consensusClustersGR(ce, qL=.1, qU=.9, returnInterquantileWidth = TRUE) |>
      CAGEr::exportToTrack(qL=.1, qU=.9)
    cctrack$score <- scores
    cctrack@trackLine@description <- "CAGE Consensus Clusters for transcription start sites"
    cctrack@trackLine@name <- "TSS"
    # Flat the clusters of width 1.
    cctrack$itemRgb <- ifelse(BiocGenerics::width(cctrack) > 1, "black", "grey")
    cctrack
  }

}
