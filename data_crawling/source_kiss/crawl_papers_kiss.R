library(RSelenium)
library(rvest)

remDr<-remoteDriver(remoteServerAddr="localhost", port=4445L, browserName="chrome")
remDr$open()

remDr$navigate("https://kiss.kstudy.com/")

login_popup <- remDr$findElement(using="xpath", value="//*[@id="btn-login-in"]")
login_popup <- remDr$findElement(using="id", value="btn-login-in")
login_popup$clickElement()

login_id$sendKeysToElement("")
login_pw$sendKeysToElement("")

login_btn <- remDr$findElement(using = "xpath", value = "//*[@id="header"]/div[3]/div[3]/div[1]/form[1]/div/div/div[2]/button")

txt_pw<-remDr$findElement(using="id",value="loginPw")

login_btn<-remDr$findElement(using="class",value="btn_login") #로그인 버튼도 id/pw와 비슷하게 class='~~~~"입력





txt_id$setElementAttribute("value","★★★★★") # ★에 아이디 입력

txt_pw$setElementAttribute("value","★★★★★") # ★에 비밀번호 입력

login_btn$clickElement()





url_item<-remDr$getPageSource()[[1]] #페이지 소스 읽어오기

url_item<-read_html(url_item, encoding="UTF-8") #url에서 html파일을 읽어오고 저장한다.

item<- url_item %>% html_nodes("strong.txt_vellip.tit_top") %>% html_text() #최근 글 목록을 불러온다.

item
