test_that("mqcGenstat works", {
  ce <- readRDS('~/R/ce_clean.rds')
  hs <- read.table(head = TRUE,
                   '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/multiqc/hisat2/multiqc_data/multiqc_hisat2.txt')
  ce <- mqcHisat2(ce, hs)
  qc <- read.table(head = TRUE,
                   sep = '\t',
                   '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/multiqc/hisat2/multiqc_data/multiqc_general_stats.txt')
  expect_equal(mqcGenstats(ce, qc)$rdna[3], 17583282)
})
