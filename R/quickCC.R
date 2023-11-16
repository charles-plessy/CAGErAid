#' Aggregates tag clusters into consensus clusters
#' @description Quickly aggregates CTSSs into consensus clusters from data from samples with or without splice leader detected with established parameters.
#' For finding tag clusters, use [quickTC()].
#'
#' The method for clustering CTSSs in samples without SL detected is distclu, and with - paraclu. By default, the algorithm uses 4 cores.
#'
#' The function annotates found consensus clusters with the use of a GFF file. For easy processing of gff files use [quickGFF()].
#'
#' @param ce CAGEexp object
#' @param sl_found boolean, whether data contains samples with or without SL sequences
#' @param gff GFF file
#'
#' @return CAGEexp object
#' @importFrom CAGEr normalizeTagCount
#' @importFrom CAGEr clusterCTSS
#' @importFrom CAGEr cumulativeCTSSdistribution
#' @importFrom CAGEr quantilePositions
#' @importFrom CAGEr aggregateTagClusters
#' @importFrom CAGEr annotateConsensusClusters
#'
#'
#' @examples
#' \dontrun{
#' quickCC(ce, sl_found = TRUE, gff)
#' }
#' @export
quickCC <- function(ce, sl_found, gff) {
  if (sl_found == FALSE) {
    ce <- ce |>
      CAGEr::clusterCTSS( method = "distclu",
                          nrPassThreshold = 1, # Default.  We do not have replicates for all time points
                          threshold = 1,
                          thresholdIsTpm = TRUE,
                          useMulticore = TRUE, # Deigo
                          nrCores = 4)    |>
      CAGEr::aggregateTagClusters() |>
      CAGEr::cumulativeCTSSdistribution(clusters = "consensusClusters") |>
      CAGEr::quantilePositions(clusters = "consensusClusters") |>
      CAGEr::annotateConsensusClusters(gff)
  }
  else {
    ce <- ce |>
      CAGEr::clusterCTSS(
        method = "paraclu",
        nrPassThreshold = 1,
        threshold = 1,   # it allows low-score CTSS supported in other samples.
        removeSingletons = TRUE,
        keepSingletonsAbove = 1,
        maxLength = 10L, # Keep them sharp
        useMulticore = TRUE, # Deigo
        nrCores = 4) |>
      CAGEr::aggregateTagClusters(
        maxDist = 10L,
        tpmThreshold = 10,
        excludeSignalBelowThreshold = FALSE
      ) |>  # See also the score distribution
      CAGEr::cumulativeCTSSdistribution(clusters = "consensusClusters") |>
      CAGEr::quantilePositions(clusters = "consensusClusters") |>
      CAGEr::annotateConsensusClusters(gff, up = 100, down = 0)
  }
  ce
}
