require(pryr)
require(dplyr)

# define gene class
setClass("GeneA", slots=list(Gene = "character",
                             Gene_ann = "data.frame",
                             tumor_omic = "data.frame",
                             tumor_meta = "data.frame",
                             cell_omic = "data.frame",
                             cell_meta = "data.frame"))



# define load A gene information method
setGeneric("LoadDataA",function(obj,...){
  standardGeneric("LoadDataA")
})

# define load A gene information function
setMethod("LoadDataA","GeneA",function(raw_obj, obj, gene = "TP53", ...){

  # -------------testing------------
  obj@Gene = gene
  obj@Gene_ann = raw_obj@gene_ann[obj@Gene,]

  # -------------tumor information----------------
  gene_ann = raw_obj@gene_ann

  tumor_exp = raw_obj@tumor_exp
  tumor_cnv = raw_obj@tumor_cnv
  tumor_phe = raw_obj@tumor_phe

  tumor_omic = data.frame(id = tumor_phe$sample)
  subexp = t(tumor_exp[obj@Gene,])[,1]
  tumor_omic$exp =subexp
  subcnv = t(tumor_cnv[obj@Gene,])
  # row.names(subcnv) = stringr::str_replace_all(row.names(subcnv), "[.]", "-")
  tumor_omic$cnv = subcnv[,1][match(tumor_omic$id, row.names(subcnv))]
  tumor_phe = as.data.frame(tumor_phe)

  obj@tumor_omic = tumor_omic
  obj@tumor_meta = tumor_phe

  # -------------cell information----------------
  ccle_exp = raw_obj@ccle_exp
  ccle_cnv = raw_obj@ccle_cnv
  ccle_eff = raw_obj@ccle_eff
  ccle_phe = raw_obj@ccle_phe

  cell_omic = data.frame(id = ccle_phe$ModelID)
  subexp = t(ccle_exp[obj@Gene,])[,1]
  cell_omic$exp =subexp
  subcnv = data.frame(ccle_cnv[obj@Gene,])
  cell_omic$cnv = subcnv[,1][match(cell_omic$id, row.names(subcnv))]
  subeff = data.frame(ccle_eff[obj@Gene,])
  cell_omic$eff = subeff[,1][match(cell_omic$id, row.names(subeff))]
  ccle_phe = as.data.frame(ccle_phe)

  obj@cell_omic = cell_omic
  obj@cell_meta = ccle_phe

  return(obj)
})
