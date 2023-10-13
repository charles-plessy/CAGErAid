test_that("mqcHisat2 works", {
  ce <- readRDS('~/R/ce_clean.rds')
  hs <- read.table(head = TRUE,
                   '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/multiqc/hisat2/multiqc_data/multiqc_hisat2.txt')
  expect_equal(mqcHisat2(ce, hs)$paired_aligned_one[1], 27248236)
})
