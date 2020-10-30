library(dslabs)
library(tidyverse)    # includes readr
library(readxl)
#Ver y cambiar Working Directory
getwd()
setwd("HOla")

system.file("extdata",package = "dslabs")
path <- system.file("extdata", package="dslabs")
list.files(path)

filename <- "murders.csv"
fullpath <- file.path(path, filename)
fullpath

# copy file from dslabs package to your working directory
file.copy(fullpath, getwd())
file.exists(filename)

#Leer datos

#readr is the tidyverse library that includes functions for reading data stored in text file spreadsheets into R. Functions in the package include read_csv(), read_tsv(), read_delim() and more. These differ by the delimiter they use to split columns.
#The readxl package provides functions to read Microsoft Excel formatted files.
#The excel_sheets() function gives the names of the sheets in the Excel file. These names are passed to the sheet argument for the readxl functions read_excel(), read_xls() and read_xlsx().
#The read_lines() function shows the first few lines of a file in R.

read_lines("murders.csv", n_max = 3)
dat <- read_csv(filename)

#read using full path
dat <- read_csv(fullpath)
head(dat)

#Usando las funciones básicas de R y no Tidyverse. Todo se convierte en factor. Se usa StragnAsFactor=FALSE
# filename is defined in the previous video
# read.csv converts strings to factors
dat2 <- read.csv(filename)
class(dat2$abb)
class(dat2$region)

#Descargar datos de internet. Se crea un archvo temporal y luego de cargar los datos, se elimina
url <- "https://raw.githubusercontent.com/rafalab/dslabs/master/inst/extdata/murders.csv"
dat <- read_csv(url)
download.file(url, "murders.csv")
tempfile()
tmp_filename <- tempfile()
download.file(url, tmp_filename)
dat <- read_csv(tmp_filename)
file.remove(tmp_filename)

