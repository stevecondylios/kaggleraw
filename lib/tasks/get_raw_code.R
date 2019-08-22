


library(rvest)
library(dplyr)
library(stringr)
library(jsonlite)

page_html <- read_html(link)

# R
# page_html <- read_html("https://www.kaggle.com/vrtjso/mercari-eda-more-info-than-you-can-imagine")

# python
# page_html <- read_html("https://www.kaggle.com/adityaecdrid/mnist-with-keras-for-beginners-99457")

glob <- page_html %>% 
  html_nodes(xpath = "//div[@data-component-name = 'KernelViewer']/following::script") %>% 
  .[1] %>% html_text %>% 
  strsplit(., "State.push\\(") %>% .[[1]] %>% .[2]  %>% 
  strsplit(., "\\);performance && performance.mark && performance.mark\\(\"KernelViewer.componentCouldBootstrap\"\\);") %>% 
  .[[1]] %>% .[1] %>% fromJSON

code <- glob$kernelRun$commit$source %>% fromJSON 

language <- code$metadata$language_info$name
list_indices_to_keep <- ifelse(code$cells$cell_type == "code", TRUE, FALSE)

code <- code$cells$source[list_indices_to_keep] %>% 
  lapply(function(x) { paste0(x, collapse="") }) %>% 
  paste0(., collapse="\n") 

# View
# code %>% paste0(., collapse="\n") %>% cat

code <- code %>% paste0(., collapse="\n")





