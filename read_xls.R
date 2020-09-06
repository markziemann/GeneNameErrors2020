library(readxl)    

read_excel_allsheets <- function(filename, tibble = FALSE) {
    # I prefer straight data.frames
    # but if you like tidyverse tibbles (the default with read_excel)
    # then just pass tibble = TRUE
    sheets <- readxl::excel_sheets(filename)
    x <- lapply(sheets, function(X)
      readxl::read_excel(filename, sheet = X, col_types="text"))  
      if(!tibble) x <- lapply(x, as.data.frame)
      names(x) <- sheets
      x
}

args = commandArgs(trailingOnly=TRUE)

myxls=args[1]

mysheets <- read_excel_allsheets(myxls)

lapply(1:length(mysheets), function(x) {
  write.table(mysheets[[x]], file=paste(myxls,".txt.",x,sep=""), sep="\t", quote=FALSE)
})



