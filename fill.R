require(dplyr)
require(ggplot2)
require(RColorBrewer)
tbl_df(df_summ)

ggplot(data=df_summ, aes(x=reorder(Dept, Mean),y=Mean, fill = Dept)) +
    geom_bar(stat="identity") +
    coord_flip() +
    scale_fill_brewer(palette="BrBG") +
    xlab("Department") +
    ylab("Mean Salary")


