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
    cctrack_sl <- CAGEr::exportToTrack(ce, "consensusClusters", qLow = 0.1, qUp = 0.9)
    cctrack_sl@trackLine@description <- "CAGE Consensus Clusters for trans splicing sites"
    cctrack_sl@trackLine@name <- "sl"
    # Flat AG
    cctrack_sl$itemRgb <- ifelse(CAGEr::flagByUpstreamSequences(SummarizedExperiment::rowRanges(CAGEr::consensusClustersSE(ce))$dominant_ctss, "AG"), "black", "grey")

    cctrack_sl[cctrack_sl$itemRgb == "black"] |> BiocGenerics::score() |> S4Vectors::decode() |> log10() |> graphics::hist(br=100)
    cctrack_sl[cctrack_sl$itemRgb == "grey"]  |> BiocGenerics::score() |> S4Vectors::decode() |> log10() |> graphics::hist(br=100)

    cctrack_sl
  }
  else {
    cctrack_no <- CAGEr::exportToTrack(ce, "consensusClusters", qLow = 0.1, qUp = 0.9)
    cctrack_no@trackLine@description <- "CAGE Consensus Clusters for transcription start sites"
    cctrack_no@trackLine@name <- "TSS"
    # Flat the clusters of width 1.
    cctrack_no$itemRgb <- ifelse(BiocGenerics::width(cctrack_no) > 1, "black", "grey")

    cctrack_no
  }

}
