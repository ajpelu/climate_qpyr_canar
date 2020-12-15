
# Read and combine data downloaded from SOS Iecolab 

library(tidyverse)
library(here)

files <- list.files(here::here("data/raw/sos"), pattern = "*.csv", full.names = TRUE)
data <- files %>% 
  map(read_delim, delim = ";") %>%    
  reduce(rbind) %>% 
  write_csv(here::here("data/"), "sos_data.csv")