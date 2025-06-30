library(tidyverse)

cols <- cols_only(
  Area = col_double(), Feret = col_double(), MinFeret = col_double(),
  AR = col_double(), Round = col_double(), Solidity = col_double(),
  L_BlackBackground = col_double(), a_BlackBackground = col_double(),
  b_BlackBackground = col_double(), L_GreenBackground = col_double(),
  a_GreenBackground = col_double(), b_GreenBackground = col_double(),
  Color_sd = col_double()
)

paths <- list.files("data", full.names = T)
paths <- paths |> set_names(basename)
files <- map(paths, \(path) read_csv(path, col_types = cols))
data <- list_rbind(files, names_to = "file")
data <- data |> janitor::clean_names()
data <- data |> separate_wider_delim(file, "_", names = c("project", NA))
