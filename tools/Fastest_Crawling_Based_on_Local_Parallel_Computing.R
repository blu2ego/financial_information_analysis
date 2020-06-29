# install.packages("rvest")
library(rvest)
library(stringr)
library(httr)
library(data.table)


tmp_time<-proc.time()

root_url <- "http://arxiv.org"
keyword_url <- "http://arxiv.org/find/all/1/all:+EXACT+text_mining/0/1/0/all/0/1"

### 각 키워드별 ###
###############
# paper index #
###############

search_url <- keyword_url
h <- read_html(search_url)

# 논문 갯수
tmp <- h %>% html_node("h3") %>% html_text()
tmp <- strsplit(tmp,"\\(")[[1]][2]
tmp <- strsplit(tmp,"\\)")[[1]][1]
tmp <- gsub("of ","",tmp)
tmp <- gsub(" total","",tmp)
total_number <- as.numeric(tmp)

# 페이지번호별
skip <- seq(0,total_number,by = 25)

# abstract NUM
abs_no <- c()
for(page in 1:length(skip))
{# page <- 2;
  skip_no <- skip[page]
  # URL 에서 skip이 의미하는 것은 이하까지 안보고 시작하겠다는 의미임
  search_url_page <- paste0(search_url,"?skip=",skip_no)
  h2 <- read_html(search_url_page)
  selectorname <- ".list-identifier"
  # <PDF랑 이상한것이 다 섞여서 나오는데 Pattern은 /뒤의 주소는 다 같다는 것이다.>
  index_tmp2 <- h2 %>% html_nodes(".list-identifier") %>% html_nodes("a") %>% html_attr("href")
  index_URL <- index_tmp2[grep("/abs/",index_tmp2)]
  abs_no <- c(abs_no,index_URL)
  print(paste0(page,"page_complete"))
} # for page
# abs_no = 논문 인덱스

(proc.time()-tmp_time)[3]

#######################################################################################
# 가져올 126개의 URL들
Total_URL<-paste0(root_url,abs_no)
#######################################################################################

#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#
# Crawler 속도의 핵심!
# 병렬 처리!

library(parallel)

# 컴퓨터의 Core 갯수를 심어줌
nCores <- detectCores()

# Slave 생성
cluster <- makeCluster(nCores)

# 담을 Raw_Source 생성후 전체 Job에 돌아가게 할당함
Raw_Source <- list()
clusterExport(cluster,"Raw_Source")

# Total_URL 객체 생성후 전체 Job에 돌아가게 할당함
clusterExport(cluster,"Total_URL")

# Cluster에 전체 Library 할당함
clusterEvalQ(cluster,library("httr"))

Crawl2<-function(x){Raw <- GET(x)
        return(Raw)}

clusterExport(cluster,"Crawl2")

results <- parLapply(cluster, Total_URL[1:126], Crawl2)

# 병렬처리 닫아준다.
stopCluster(cluster)

(proc.time()-tmp_time)[3]

###########################################


Append_List<-list()

for (iz in 1:length(results)){

    # iz=1
    test<-results[[iz]]
    h3<-(content(test,"parsed", encoding = "UTF-8"))

    # title
    title<- h3 %>% html_nodes(xpath = '//*[@id="abs"]/div[2]/h1/text()') %>% html_text(trim=T)

    # authors
    authors<- h3 %>% html_nodes(xpath = '//*[@id="abs"]/div[2]/div[2]/a') %>% html_text(trim=T)
    authors<-paste(authors,collapse = ",")

    # submit dates

    t<-h3 %>%  html_nodes("div.submission-history")%>% html_text(trim = T)
    submit_dates<-unlist(strsplit(t,split = "] "))[length(strsplit(t,split = "] ")[[1]])]
    # abstract
    raw_abstract<-h3 %>%  html_nodes(xpath = '//*[@id="abs"]/div[2]/blockquote/text()') %>% html_text(trim=T)
    Abstract<-gsub("\n","",raw_abstract[length(raw_abstract)])
  
    # subject
    raw_subject<-h3 %>%  html_nodes(xpath = '//*[@id="abs"]/div[2]/div[4]/table[1]/tr') %>% html_text(trim=T)
    raw_subject<-raw_subject[grep("Subjects",raw_subject)] 
    raw_subject<-gsub("\n","",raw_subject)
    raw_subject<-gsub("Subjects:","",raw_subject)
    Append_List[[iz]]<-data.frame(Title=title,Authors=authors,Subject=raw_subject,Abstract=Abstract,Last_Submission_Date=submit_dates)
    print(iz)
    }


Finish <- data.frame(rbindlist(Append_List))

View(Finish)

print((proc.time()-tmp_time)[3])

#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################
#######################################################################################

