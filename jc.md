



This report was automatically generated with the R package **knitr**
(version 1.10.5).


```r
## This is a test this is the seonc
require(dplyr)
require(tidyr)
require(knitr)
fileURL <- "https://data.openjerseycity.org/dataset/d18a7e84-d236-4510-a905-361d7153215f/resource/0c375385-c622-42a6-878b-b6a178d4182a/download/jerseycitypublicemployeeswithtitlesandhiredates20feb2014.csv"
download.file(fileURL, destfile = "./data/jcdata.csv", method = "curl" )
dateDownload <- date()
dateDownload
```

```
## [1] "Fri Jun  5 19:00:24 2015"
```

```r
df_local <- tbl_df(read.csv("./data/jcdata.csv", stringsAsFactors = FALSE ))
# df_local$LOCD <- as.character(df_local$LOCD)
df_sep <- df_local %>% 
    separate(SALARY, c("D", "C"), sep = 1) %>% 
    separate(C, c("E", "G"), sep = ",", extra = "merge") %>% 
    unite(SALARY, E, G, sep = "") %>% 
    separate(LOCD, c("Dept", "J"), sep = "‐", extra = "merge") 
df_sep <- group_by(df_sep, Dept)
df_sep$SALARY <- as.numeric(df_sep$SALARY)
```

```
## Warning: NAs introduced by coercion
```

```r
df_summ <- summarise(df_sep, Mean = mean(SALARY, na.rm = TRUE), Employees = n())
df_summ$Mean <- round(df_summ$Mean, digits = 0)
arrange(df_summ,desc(Mean))
```

```
## Source: local data frame [13 x 3]
## 
##            Dept   Mean Employees
## 1  FIRE DEPT    101229       612
## 2  POLICE DEPT   77635      1190
## 3  MAYORS OFC    77344        15
## 4  TAX ASSESSOR  63504        15
## 5  LAW DEPT      58719        49
## 6  HSG/ECO DEV   57391        91
## 7  CDBG          54697        14
## 8  BUSN ADMIN    53110       221
## 9  PUBLIC WKS    46164       170
## 10 HLT/HUM SVC   45225       111
## 11 CLRK/COUNCL   41500        34
## 12 GRANTS/HHS    40952        20
## 13 RECREATION    22893       255
```

```r
require(dplyr)
require(ggplot2)
require(RColorBrewer)
tbl_df(df_summ)
```

```
## Source: local data frame [13 x 3]
## 
##            Dept   Mean Employees
## 1  BUSN ADMIN    53110       221
## 2  CDBG          54697        14
## 3  CLRK/COUNCL   41500        34
## 4  FIRE DEPT    101229       612
## 5  GRANTS/HHS    40952        20
## 6  HLT/HUM SVC   45225       111
## 7  HSG/ECO DEV   57391        91
## 8  LAW DEPT      58719        49
## 9  MAYORS OFC    77344        15
## 10 POLICE DEPT   77635      1190
## 11 PUBLIC WKS    46164       170
## 12 RECREATION    22893       255
## 13 TAX ASSESSOR  63504        15
```

```r
p1 <- ggplot(data=df_summ, aes(x=reorder(Dept, Mean),y=Mean, fill = Dept)) +
    geom_bar(stat="identity") +
    coord_flip() +
    labs(title="JC Average Salary\n 2014") +
    theme(legend.position="none") +
    xlab("Department") +
    ylab("Average Salary")
g <- arrangeGrob(p1, sub = textGrob("Footnote: For details see: https://github.com/tbruning/JC_Salary", x = 0, hjust = -0.1, vjust=0.1, gp = gpar(fontface = "italic", fontsize = 12)))
```

```
## Error in eval(expr, envir, enclos): could not find function "arrangeGrob"
```

```r
df_summ <- summarise(df_sep, Mean = median(SALARY, na.rm = TRUE), Employees = n())
p2 <- ggplot(data=df_summ, aes(x=reorder(Dept, Mean),y=Mean, fill = Dept)) +
    geom_bar(stat="identity") +
    coord_flip() +
    labs(title="JC Average Salary\n 2014") +
    theme(legend.position="none") +
    xlab("Department") +
    ylab("Average Salary")
grid.arrange(p1, p2, ncol = 2)
```

```
## Error in eval(expr, envir, enclos): could not find function "grid.arrange"
```

```r
g
```

```
## Error in eval(expr, envir, enclos): object 'g' not found
```

The R session information (including the OS info, R version and all
packages used):


```r
sessionInfo()
```

```
## R version 3.2.0 (2015-04-16)
## Platform: x86_64-pc-linux-gnu (64-bit)
## Running under: Ubuntu 14.04.2 LTS
## 
## locale:
##  [1] LC_CTYPE=en_US.UTF-8 LC_NUMERIC=C         LC_TIME=C           
##  [4] LC_COLLATE=C         LC_MONETARY=C        LC_MESSAGES=C       
##  [7] LC_PAPER=C           LC_NAME=C            LC_ADDRESS=C        
## [10] LC_TELEPHONE=C       LC_MEASUREMENT=C     LC_IDENTIFICATION=C 
## 
## attached base packages:
## [1] stats     graphics  grDevices utils     datasets  methods   base     
## 
## other attached packages:
## [1] RColorBrewer_1.1-2 ggplot2_1.0.1      tidyr_0.2.0       
## [4] dplyr_0.4.1        knitr_1.10.5      
## 
## loaded via a namespace (and not attached):
##  [1] Rcpp_0.11.6      slidify_0.4.5    whisker_0.3-2    magrittr_1.5    
##  [5] MASS_7.3-40      munsell_0.4.2    colorspace_1.2-6 highr_0.5       
##  [9] stringr_0.6.2    plyr_1.8.2       tools_3.2.0      parallel_3.2.0  
## [13] grid_3.2.0       gtable_0.1.2     DBI_0.3.1        htmltools_0.2.6 
## [17] yaml_2.1.13      lazyeval_0.1.10  assertthat_0.1   digest_0.6.8    
## [21] formatR_1.2      reshape2_1.4.1   evaluate_0.7     rmarkdown_0.6.1 
## [25] stringi_0.4-1    scales_0.2.4     markdown_0.7.7   proto_0.3-10
```

```r
Sys.time()
```

```
## [1] "2015-06-05 19:00:24 EDT"
```

