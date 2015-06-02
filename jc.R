require(dplyr)
require(tidyr)
require(knitr)
fileURL <- "https://data.openjerseycity.org/dataset/d18a7e84-d236-4510-a905-361d7153215f/resource/0c375385-c622-42a6-878b-b6a178d4182a/download/jerseycitypublicemployeeswithtitlesandhiredates20feb2014.csv"
download.file(fileURL, destfile = "./data/jcdata.csv", method = "curl" )
dateDownload <- date()
dateDownload
df_local <- tbl_df(read.csv("./data/jcdata.csv", stringsAsFactors = FALSE ))
# df_local$LOCD <- as.character(df_local$LOCD)
df_sep <- df_local %>% 
    separate(SALARY, c("D", "C"), sep = 1) %>% 
    separate(C, c("E", "G"), sep = ",", extra = "merge") %>% 
    unite(SALARY, E, G, sep = "") %>% 
    separate(LOCD, c("Dept", "J"), sep = "‐", extra = "merge") 
df_sep <- group_by(df_sep, Dept)
df_sep$SALARY <- as.numeric(df_sep$SALARY)
df_summ <- summarise(df_sep, Mean = mean(SALARY, na.rm = TRUE), Employees = n())
df_summ$Mean <- round(df_summ$Mean, digits = 0)
arrange(df_summ,desc(Mean))
