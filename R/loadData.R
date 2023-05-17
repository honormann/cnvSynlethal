require(pryr)
require(dplyr)

# define rawData class
setClass("rawData", slots=list(tumor_exp = "data.frame",
                               tumor_cnv = "data.frame",
                               tumor_phe = "data.frame",
                               ccle_exp = "data.frame",
                               ccle_cnv = "data.frame",
                               ccle_eff = "data.frame",
                               ccle_phe = "data.frame",
                               gene_ann = "data.frame"))


# define load data method
setGeneric("LoadData",function(obj,...){
  standardGeneric("LoadData")
})

# define load data function
setMethod("LoadData","rawData",function(obj,...){

  print("load tumor data...")
  tumor_exp = readRDS("data/tcga_exp.rds")
  tumor_cnv = readRDS("data/tcga_cnv.rds")
  tumor_phe = readRDS("data/tcga_phe.rds")

  print("load cell line data...")
  ccle_exp = readRDS("data/ccle_exp.rds")
  ccle_cnv = readRDS("data/ccle_cnv.rds")
  ccle_eff = readRDS("data/ccle_eff.rds")
  ccle_phe = readRDS("data/ccle_phe.rds")

  gene_ann = readRDS("data/gene_ann.rds")

  obj@tumor_exp = tumor_exp %>% data.frame()
  obj@tumor_cnv = tumor_cnv %>% data.frame()
  obj@tumor_phe = tumor_phe %>% data.frame()
  obj@ccle_exp = ccle_exp %>% data.frame()
  obj@ccle_cnv = ccle_cnv %>% data.frame()
  obj@ccle_eff = ccle_eff %>% data.frame()
  obj@ccle_phe = ccle_phe %>% data.frame()
  obj@gene_ann = gene_ann %>% data.frame()

  colnames(obj@tumor_exp) = stringr::str_replace_all(colnames(obj@tumor_exp), "[.]", "-")
  colnames(obj@tumor_cnv) = stringr::str_replace_all(colnames(obj@tumor_cnv), "[.]", "-")
  colnames(obj@ccle_exp) = stringr::str_replace_all(colnames(obj@ccle_exp), "[.]", "-")
  colnames(obj@ccle_cnv) = stringr::str_replace_all(colnames(obj@ccle_cnv), "[.]", "-")
  colnames(obj@ccle_eff) = stringr::str_replace_all(colnames(obj@ccle_eff), "[.]", "-")

  return(obj)
})


