require(pryr)
require(dplyr)

# define gene class
setClass("GeneB", slots=list(Gene = "vector",
                             Gene_ann = "data.frame",
                             tumor_exp = "data.frame",
                             tumor_cnv = "data.frame",
                             tumor_meta = "data.frame",
                             cell_exp = "data.frame",
                             cell_cnv = "data.frame",
                             cell_dep = "data.frame",
                             cell_meta = "data.frame"))

# define load B gene information method
setGeneric("LoadDataB",function(obj,...){
  standardGeneric("LoadDataB")
})

# define load B gene information function
setMethod("LoadDataB","GeneB",function(raw_obj, objA, obj, percent = 0.8,...){

  ccle_exp = raw_obj@ccle_exp
  ccle_cnv = raw_obj@ccle_cnv
  ccle_eff = raw_obj@ccle_eff
  ccle_phe = raw_obj@ccle_phe

  tumor_exp = raw_obj@tumor_exp
  tumor_cnv = raw_obj@tumor_cnv
  tumor_phe = raw_obj@tumor_phe

  GeneA_loss_tumor = subset(objA@tumor_omic, cnv<0) %>% select("id")
  GeneB_loss = tumor_cnv[,GeneA_loss_tumor$id]
  GeneB_loss = (GeneB_loss < 0)
  GeneB_loss = apply(GeneB_loss, 1, sum)
  GeneB_sets = GeneB_loss[which(GeneB_loss > length(GeneA_loss_tumor$id)*percent)]
  obj@Gene = names(GeneB_sets)
  obj@Gene_ann = gene_ann[obj@Gene,]

  obj@tumor_exp = tumor_exp[obj@Gene,]
  obj@tumor_cnv = tumor_cnv[obj@Gene,]
  obj@tumor_meta = tumor_phe
  obj@cell_exp = ccle_exp[obj@Gene,] %>% data.frame()
  obj@cell_cnv = ccle_cnv[obj@Gene,] %>% data.frame()
  obj@cell_dep = ccle_eff[obj@Gene,] %>% data.frame()
  obj@cell_meta = ccle_phe

  return(obj)
})
