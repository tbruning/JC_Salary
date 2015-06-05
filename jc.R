## This is a test this is the seonc
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
<<<<<<< HEAD
require(dplyr)
require(ggplot2)
require(RColorBrewer)
tbl_df(df_summ)

p1 <- ggplot(data=df_summ, aes(x=reorder(Dept, Mean),y=Mean, fill = Dept)) +
    geom_bar(stat="identity") +
    coord_flip() +
    labs(title="JC Average Salary\n 2014") +
    theme(legend.position="none") +
    xlab("Department") +
    ylab("Average Salary")
g <-arrangeGrob(p1, sub = textGrob("Footnote: For details see: https://github.com/tbruning/JC_Salary/jc.html", x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 12)))

df_summ <- summarise(df_sep, Mean = median(SALARY, na.rm = TRUE), Employees = n())
p2 <- ggplot(data=df_summ, aes(x=reorder(Dept, Mean),y=Mean, fill = Dept)) +
    geom_bar(stat="identity") +
    coord_flip() +
    labs(title="JC Average Salary\n 2014") +
    theme(legend.position="none") +
    xlab("Department") +
    ylab("Average Salary")
grid.arrange(p1, p2, ncol = 2)
g
=======
>>>>>>> 34b875ae81e5a813a169d1d84fd1a5887916c49c
