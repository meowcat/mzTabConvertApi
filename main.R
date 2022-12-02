library(plumber)
library(tidyverse)


source("parser.R")
options_plumber(maxRequestSize = 10* 1000 * 1000)
plumber::plumb("plumber.R") %>% pr_run()
