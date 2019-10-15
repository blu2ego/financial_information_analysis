# init

api.key <- readLines("~/R/dart_analysis/dart-analysis/api-key.txt")
start.date = '19990101'
ticker = '005930'

url <- paste0("http://dart.fss.or.kr/api/search.json?auth=",api.key,"&crp_cd=",ticker,"&start_dt=",start.date,"&bsn_tp=A001")

library(jsonlite) # fromJSON() 함수를 사용하기 위해 jsonlite 패키지를 로딩
data <- fromJSON(url)

data.df <- data$list
data.df.rcp <- data.df$rcp_no

library(magrittr) # %>% 연산자를 사용하기 위해 magrittr 패키지를 로딩
data.df %>% 
  head()

url.business.report <- "http://dart.fss.or.kr/dsaf001/main.do?rcpNo=20180402005019"

library(httr) # GET() 함수를 사용하기 위해 httr 패키지를 로딩
req <- GET(url.business.report)

library(rvest) # read_html() 함수를 사용하기 위해 rvest 패키지를 로딩
req <- read_html(req) %>% 
  html_node(xpath = '//*[@id="north"]/div[2]/ul/li[1]/a')

library(stringr) # str_split() 함수를 사용하기 위해 stringr 패키지를 로딩
req <- req %>% 
  html_attr('onclick')

library(readr) # parse_number() 함수를 사용하기 위해 readr 패키지를 로딩
dcm <- str_split(req, ' ')[[1]][2] %>% 
  readr::parse_number()


rcp_no <- '20180402005019'
dcm_no <- dcm

download_br <- paste0("http://dart.fss.or.kr/pdf/download/pdf.do?", "rcp_no=", rcp_no, "&dcm_no=", dcm_no)

download_br

br <- download.file(url = download_br, destfile = "~/R/dart_analysis/dart_data/br.pdf")