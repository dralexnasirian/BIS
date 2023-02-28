library(ggplot2)

sub_enabler <- c("Management supprt" , "User input" , "Vision" , "Implementation plan" , "Stake holder analysis" , "BIM policy" , 
                "Risk analysis" , "Collegial help" , "BIM expertise" , "Competency assessment" , "Learning by doing" , 
                "Community of practice" , "Learning from past" , "Change agent" , "User involvement" , "Open communication" , 
                "KM system" , "Technology" , "Organization linkage" , "Cross-functional cooperation",
                "Reward" , "User training" , "Supportive supervisor" , "Management readiness", 
                "Benchmarking tools" , "Maturity assessment" , "Benefit assessment")

sub_enabler

# A ###############
model_A<- lm(y~. , df_A)
co_A <- model_A$coefficients
co_A <- co_A*-1
Company <- rep("Company A",27)
df_A <- data.frame(sub_enabler=sub_enabler, Company = Company , value=co_A[2:28])
head(df_A,4)

# B ###############
model_B <- lm(y~. , df_B )
co_B <- model_B$coefficients
co_B <- co_B*-1
Company <- rep("Company B",27)
df_B <- data.frame(sub_enabler=sub_enabler, Company = Company , value=co_B[2:28])
head(df_B,4)

# C ###############
model_C <- lm(y~. , df_C )
co_C <- model_C$coefficients
co_C <- co_C*-1
Company <- rep("Company C",27)
df_C <- data.frame(sub_enabler=sub_enabler, Company = Company , value=co_C[2:28])
head(df_C,4)

# S ###############
df_S <- df_sim
model_S <- lm(y~. , df_S )
co_S <- model_S$coefficients
co_S <- co_S*-1
Company <- rep("Company S",27)
df_S <- data.frame(sub_enabler=sub_enabler, Company = Company , value=co_S[2:28])
head(df_C,4)


#ggplot(data = df_B , aes(x=sub_enabler , y=value) ) + geom_col() + coord_flip() + theme_classic()

df <- rbind(df_A , df_B , df_C ,df_S)

ggplot(data = df , aes(x=sub_enabler , y=value ) ) + geom_col() + coord_flip() + theme_classic()+facet_wrap(~Company , ncol=4)

head(df_A,1)
