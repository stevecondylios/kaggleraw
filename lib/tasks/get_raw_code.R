


library(rvest)
library(dplyr)
library(stringr)
library(jsonlite)

page_html <- read_html(link)

# R
# page_html <- read_html("https://www.kaggle.com/vrtjso/mercari-eda-more-info-than-you-can-imagine")

# rmarkdown
# page_html <- read_html("https://www.kaggle.com/captcalculator/a-very-extensive-mercari-exploratory-analysis")

# python
# page_html <- read_html("https://www.kaggle.com/adityaecdrid/mnist-with-keras-for-beginners-99457")

glob <- page_html %>% 
  html_nodes(xpath = "//div[@data-component-name = 'KernelViewer']/following::script") %>% 
  .[1] %>% html_text %>% 
  strsplit(., "State.push\\(") %>% .[[1]] %>% .[2]  %>% 
  strsplit(., "\\);performance && performance.mark && performance.mark\\(\"KernelViewer.componentCouldBootstrap\"\\);") %>% 
  .[[1]] %>% .[1] %>% fromJSON


if(glob$kernelRun$language == "rmarkdown") {
  
  language <- "rmarkdown"
  code <- glob$kernelRun$commit$source %>% 
    paste0(., collapse="\n") 
  }else{
    print("Not R markdown")
    source_code <- glob$kernelRun$commit$source %>% fromJSON 
  
    language <- source_code$metadata$language_info$name
    list_indices_to_keep <- ifelse(source_code$cells$cell_type == "code", TRUE, FALSE)
  
    code <- source_code$cells$source[list_indices_to_keep] %>% 
      lapply(function(x) { paste0(x, collapse="") }) %>% 
      paste0(., collapse="\n") 
  
}


# View
# code %>% paste0(., collapse="\n") %>% cat

# Adding an addition line break (doesn't work for some reason)
code <- code %>% paste0(., collapse="\n")



