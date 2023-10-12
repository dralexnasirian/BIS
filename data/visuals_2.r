library(readr)
library(dplyr)
library(ggplot2)

uni_enabler_score <- read_csv("C:/Users/alexn/Downloads/uni_enabler_score.csv")

df<- uni_enabler_score

head(df,2)


p1 <- ggplot(df,  aes(x=sub_enabler , y=value)) + geom_col(fill="aquamarine3")
p2 <- p1 + coord_flip() + facet_wrap(~ Company, ncol=4)
p3 <- p2 + labs(x="Enabler" , y="Score")
p4 <- p3 + theme_linedraw()
p4
p4 + scale_fill_gradient(low = "aquamarine1", high = "aquamarine3")
############################
sub_enabler <- c("Top management support", 
                 "Incorporating User's input", 
                 "BIM-enabled vision", 
                 "Implementation plan", 
                 "Stakeholder analysis", 
                 "BIM policy", 
                 "Risk analysis", 
                 "Collegial help", 
                 "BIM expertise", 
                 "Individual competency assessment", 
                 "Learning-by-doing",
                 "Learning-from-past",
                 "Community of practice", 
                 "Existence of change agents", 
                 "User involvement", 
                 "Open communication", 
                 "BIM-based KM system", 
                 "Use of communication technology", 
                 "Inter-organization linkage", 
                 "Cross-functional cooperation",
                 "Rewards and recognition", 
                 "User training and education", 
                 "Supportive supervisor", 
                 "Management readiness for change", 
                 "External benchmarking tools/metrics", 
                 "Capability and maturity assessment", 
                 "Benefit assessment tools")

df <- uni_enabler_score

colnames(df)[4] <- "uni_criterin_score"

head(df,3)



df <- df %>%
  mutate(Enabler = ifelse(Enabler == "Learning from past", "Learning-from-past", Enabler),
         Enabler = ifelse(Enabler == "Learning by doing", "Learning-by-doing", Enabler),
         Enabler = ifelse(Enabler == "Inter-organization linkage", "Inter-organizational linkage", Enabler),
         Enabler = ifelse(Enabler == "Existance of change agent", "Existence of change agents", Enabler))


##########################
p1 <- ggplot(df, aes(x = Enabler, y = uni_criterin_score))
p2 <- p1 + geom_col(fill = "green4") 
p3 <- p2 + coord_flip() + facet_wrap(~Company)

p4 <- p3 + theme_bw() + 
  theme(axis.text.x = element_text(family = "Times New Roman", size = 12),
        axis.text.y = element_text(family = "Times New Roman", size = 12))

p5 <- p4 + labs(y = "Uni enabler score")
p6 <- p5 + scale_x_discrete(limits = sub_enabler)

p6
