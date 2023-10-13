#' Quickly imports and processes a GFF object as a character vector for use in annotating CAGEexp objects
#'
#' @param gff_path path to a GFF file
#' @param types types of features of interest
#'
#' @return GRanges object with selected features
#' @importFrom rtracklayer import
#'
#' @examples
#' \dontrun{
#' quickGFF('barcelona.gff', types = c('intron', 'exon'))
#' }
#' @export
quickGFF <-
  function(gff_path,
           types = c('transcript', 'intron', 'exon')) {
    gff <- rtracklayer::import(gff_path)
    gff$type <- as.character(gff$type)
    gff <- gff[gff$type %in% types]
    gff$gene_name <- gff$gene_id
    gff
  }
