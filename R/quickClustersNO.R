#' Quickly clusters CTSSs in data from samples without splice leader detected with established parameters.
#' For clustering CTSSs in samples with splice leader found, use \link[CAGErAid]{quickClustersSL}.
#'
#' The method for clustering CTSSs is distclu, and by default the algorithm uses 4 cores.
#'
#' Optional aggregating tags is possible with aggregate = TRUE, at which the user needs to provide a GFF file.
#' For easy processing of gff files use \link[CAGErAid]{quickGFF}.
#'
#' @param ce CAGEexp object
#' @param aggregate whether to return consensus clusters
#' @param gff GFF file
#'
#' @return CAGEexp object
#' @importFrom CAGEr normalizeTagCount
#' @importFrom CAGEr clusterCTSS
#' @importFrom CAGEr cumulativeCTSSdistribution
#' @importFrom CAGEr quantilePositions
#' @importFrom CAGEr aggregateTagClusters
#' @importFrom CAGEr annotateConsensusClusters
#' @export
#'
#' @examples
#' \dontrun{
#' quickClustersNO(ce, aggregate = TRUE, gff)
#' }
quickClustersNO <- function(ce, aggregate = FALSE, gff = NULL) {
  if (aggregate == FALSE) {
    ce <- ce |>
      CAGEr::normalizeTagCount(method = 'simpleTpm') |>
      CAGEr::clusterCTSS(method = "distclu"
                   , nrPassThreshold = 1 # Default.  We do not have replicates for all time points
                   , threshold = 1, thresholdIsTpm = TRUE)    |>
      CAGEr::cumulativeCTSSdistribution()                          |>
      CAGEr::quantilePositions()
  }
  if (aggregate == TRUE & is.null(gff) == FALSE) {
    ce <- ce |>
      CAGEr::normalizeTagCount(method = 'simpleTpm') |>
      CAGEr::clusterCTSS( method = "distclu"
                          , nrPassThreshold = 1 # Default.  We do not have replicates for all time points
                          , threshold = 1, thresholdIsTpm = TRUE)    |>
      CAGEr::aggregateTagClusters() |>
      CAGEr::cumulativeCTSSdistribution(clusters = "consensusClusters") |>
      CAGEr::quantilePositions(clusters = "consensusClusters") |>
      CAGEr::annotateConsensusClusters(gff)
  }
  else if (aggregate == TRUE & is.null(gff) == TRUE) {
    print('Missing GFF, skipping aggregating CAGE tags. Supply GFF.')
  }
  ce
}
