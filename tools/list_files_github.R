# github에 있는 파일들을 조회

library(httr)

# GET /repos/:owner/:repo/git/trees/:tree_sha
req <- GET("https://api.github.com/repos/blu2ego/financial-information-analysis/git/trees/master?recursive=1")
stop_for_status(req)
filelist <- unlist(lapply(content(req)$tree, "[", "path"), use.names = F)
data_list <- grep("data/dart/br/", filelist, value = TRUE, fixed = TRUE)


