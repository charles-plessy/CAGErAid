test_that("GFF gets imported and processed correctly", {
  gff_path <- '/bucket/LuscombeU/live/CharlesPlessy/CAGE/2022-11-09_Barcelona_Oik/AlignWithRNAseqPipelinePE_BAR/Bar2_p4.gm.gtf'
  expect_equal(quickGFF(gff_path, 'transcript')[1000]$gene_id, "g930")
})
