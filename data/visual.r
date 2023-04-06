df <- df_06_04_2023

head(df,2)


p1 <- ggplot(df,  aes(x=sub_enabler , y=value)) + geom_col(fill="aquamarine3")
p2 <- p1 + coord_flip() + facet_wrap(~ Company, ncol=4)
p3 <- p2 + labs(x="Enabler" , y="Score")
p4 <- p3 + theme_linedraw()
p4
p4 + scale_fill_gradient(low = "aquamarine1", high = "aquamarine3")


df <- uni_enabler_score

colnames(df)[4] <- "uni_criterin_score"

head(df,3)

##########################
p1 <-ggplot(df, aes(x=Enabler , y=uni_criterin_score))
p2 <- p1 + geom_col(fill="aquamarine3") + scale_x_discrete(limits = unique(df$Enabler), increasing = TRUE)
p3 <- p2 + coord_flip() + facet_wrap(~Company)   


p4 <- p3 + theme_linedraw() 
p5 <- p4 + labs(y="Uni enabler score")
p5 
