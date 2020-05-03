# dart api 소개 페이지에서 동작한 호출 링크 사례

api.key <- readLines("~/projects/financial_information_analysis/data_crawling/resources/dart_api_key.txt")

kospi_crp_cd_raw <- scan("~/projects/financial_information_analysis/data_crawling/resources/corp_code.csv", skip = 1)

# 거래소 코드는 원래 6자리 기본이나 corp_code.csv에 입력된 값들 중 이 코드의 앞자리가 0이 있는 경우, 자릿수가 맞지 않아 자릿수가 안맞는 값들에 대해
# 그 값의 앞자리에 0을 채워넣으면서 6자리로 맞춰야 함. 거래소 코드(corp_code.csv)를 신뢰성 있게 구축하는 방법도 생각해 볼만 함.
kospi_crp_cd_filled <- sprintf("%06d", kospi_crp_cd_raw) 

# 여러 번에 걸쳐 요청을 보내야 하므로, 이를 위한 요청 주소를 반복문을 이용하여 다량으로 만들어야 하는데, 반복문의 속도를 위해 빈(empty) 객체를 만들어 둠
report_list_request_url <- c()

# A001에 대해 request url을 생성하기 위해 for 구문을 활용하며, 이를 txt 파일로 저장
for (i in 1:length(kospi_crp_cd_filled)){
  start_dt <- "19990101"
  bsn_tp <- "A001" # 보고서 코드, list로 for문 돌려 입력할 것
  page_set <- "1000000" # 정확히 무슨 의미인지는 모르겠으나 일단 큰 수로 지정
  crp_cd <- kospi_crp_cd_filled[i]
  report_list_request_url[i] <- paste0("http://dart.fss.or.kr/api/search.json?auth=", api.key, "&crp_cd=", crp_cd, "&start_dt=", 
                                       start_dt, "&bsn_tp=", bsn_tp, "&page_set=", page_set)
  cat(report_list_request_url[i], file = paste0("~/projects/financial_information_analysis/data/br/dart/request_url/")) # bsn_tp 등

}



library(jsonlite) # fromJSON() 함수를 사용하기 위해 jsonlite 패키지를 로딩
raw_report_list <- list()
aggregated_report_list <- list()

for (i in 1:length(report_list_request_url)) {
  Sys.sleep(runif(1)+runif(1)+33)
  raw_report_list[[i]] <- fromJSON(report_list_request_url[i])
  Sys.sleep(runif(2)+runif(2)+79)
  aggregated_report_list[[i]] <- raw_report_list[[i]]$list
  Sys.sleep(runif(3)+runif(3)+51)
}

# 알아내야 할 주소
# http://dart.fss.or.kr/pdf/download/pdf.do?rcp_no=20191227000382&dcm_no=7010187
# rcp_no와 dcm_no를 알아내야 함

rcp_no <- report_list$list$rcp_no[i]
report_url <- paste0("http://dart.fss.or.kr/dsaf001/main.do?rcpNo=", rcp_no[i])
library(httr) # GET() 함수를 사용하기 위해 httr 패키지를 로딩
req <- GET(report_url)

library(rvest) # read_html() 함수를 사용하기 위해 rvest 패키지를 로딩
library(stringr) # str_split() 함수를 사용하기 위해 stringr 패키지를 로딩
library(readr) # parse_number() 함수를 사용하기 위해 readr 패키지를 로딩

req <- read_html(req) %>% 
  html_node(xpath = '//*[@id="north"]/div[2]/ul/li[1]/a')

req <- req %>% 
  html_attr('onclick')

dcm <- str_split(req, ' ')[[1]][2] %>% 
  readr::parse_number()


rcp_no <- '20180402005019'
dcm_no <- 6060273

download_br <- paste0("http://dart.fss.or.kr/pdf/download/pdf.do?", "rcp_no=", rcp_no, "&dcm_no=", dcm_no)

br <- download.file(url = download_br, destfile = "/Users/muoe7/Downloads/br.pdf")

query.base = list(
  rcp_no = '20180402005019',
  dcm_no = dcm,
  lang = 'ko'
)
