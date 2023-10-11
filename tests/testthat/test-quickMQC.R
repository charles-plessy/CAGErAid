test_that("quickMQC works", {
  ce <- readRDS('~/R/ce_clean.rds')
  hs <- read.table(head = TRUE,
                   '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/multiqc/hisat2/multiqc_data/multiqc_hisat2.txt')
  qc <- read.table(head = TRUE,
                   sep = '\t',
                   '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/multiqc/hisat2/multiqc_data/multiqc_general_stats.txt')
  expect_equal(quickMQC(ce, guess_path = FALSE, hs, qc)$rdna[3], 17583282)
  expect_equal(quickMQC(ce)$rdna[3], 17583282)

})
