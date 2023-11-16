#' Calculates tag clusters with set parameters
#' @description Quickly calculates tag clusters from CTSSs in data from samples with or without splice leader detected with established parameters.
#' For finding consensus clusters, use [quickCC()].
#'
#' The method for clustering CTSSs in samples without SL detected is distclu, and with - paraclu. By default, the algorithm uses 4 cores.
#'
#'
#' @param ce CAGEexp object
#' @param sl_found boolean, whether data contains samples with or without SL sequences
#'
#' @return CAGEexp object
#' @importFrom CAGEr normalizeTagCount
#' @importFrom CAGEr clusterCTSS
#' @importFrom CAGEr cumulativeCTSSdistribution
#' @importFrom CAGEr quantilePositions
#'
#'
#' @examples
#' \dontrun{
#' quickTC(ce, sl_found = TRUE)
#' }
#' @export
quickTC <- function(ce, sl_found) {
  if (sl_found == FALSE) {
    ce <- ce |>
      CAGEr::normalizeTagCount(method = 'powerLaw') |>
      CAGEr::clusterCTSS(method = "distclu"
                         , nrPassThreshold = 1
                         , threshold = 1
                         , thresholdIsTpm = TRUE) |>
      CAGEr::cumulativeCTSSdistribution() |>
      CAGEr::quantilePositions()
  }
  else {
    ce <- ce |>
      CAGEr::normalizeTagCount(method = 'simpleTpm') |>
      CAGEr::clusterCTSS(
        method = "paraclu",
        nrPassThreshold = 1,
        threshold = 1,   # it allows low-score CTSS supported in other samples.
        removeSingletons = TRUE,
        keepSingletonsAbove = 1,
        maxLength = 10L, # Keep them sharp
        useMulticore = TRUE, # Deigo
        nrCores = 4) |>
      CAGEr::cumulativeCTSSdistribution() |>
      CAGEr::quantilePositions()
  }
  ce
}
