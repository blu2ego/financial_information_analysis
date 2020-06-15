library(xml2)
library(tidyverse)
tmp <- tempfile()
download.file("https://opendart.fss.or.kr/api/corpCode.xml?crtfc_key=1fde365f255f62f4b7699e1a0c01eb09386426e0", tmp)
corp_code <- read_xml(unz(tmp, "CORPCODE.xml"))  

