library(ggplot2)
library(readxl)
df_A <- read_excel("C:/Users/alexn/Downloads/df_A.xlsx")
df_B <- read_excel("C:/Users/alexn/Downloads/df_B.xlsx")
df_C <- read_excel("C:/Users/alexn/Downloads/df_C.xlsx")
df_sim <- read_excel("C:/Users/alexn/Downloads/df_sim.xlsx")
library(ggplot2)
library(readxl)
df_A <- read_excel("C:/Users/alexn/Downloads/df_A.xlsx")
df_B <- read_excel("C:/Users/alexn/Downloads/df_B.xlsx")
df_C <- read_excel("C:/Users/alexn/Downloads/df_C.xlsx")
df_sim <- read_excel("C:/Users/alexn/Downloads/df_sim.xlsx")

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

# Manually reorder the factor levels
sub_enabler <- factor(sub_enabler, levels = sub_enabler)

# A ###############
model_A <- lm(y ~ ., df_A)
co_A <- model_A$coefficients
co_A <- co_A * -1
Company <- rep("Company A", 27)
df_A <- data.frame(sub_enabler, Company = Company, value = co_A[2:28])
head(df_A, 4)

# B ###############
model_B <- lm(y ~ ., df_B)
co_B <- model_B$coefficients
co_B <- co_B * -1
Company <- rep("Company B", 27)
df_B <- data.frame(sub_enabler, Company = Company, value = co_B[2:28])
head(df_B, 4)

# C ###############
model_C <- lm(y ~ ., df_C)
co_C <- model_C$coefficients
co_C <- co_C * -1
Company <- rep("Company C", 27)
df_C <- data.frame(sub_enabler, Company = Company, value = co_C[2:28])
head(df_C, 4)

# S ###############
df_S <- df_sim
model_S <- lm(y ~ ., df_S)
co_S <- model_S$coefficients
co_S <- co_S * -1
Company <- rep("Startup", 27)
df_S <- data.frame(sub_enabler, Company = Company, value = co_S[2:28])
head(df_S, 4)

df <- rbind(df_A, df_B, df_C, df_S)

ggplot(data = df, aes(x = sub_enabler, y = value)) +
  geom_col(fill = "green4") +
  coord_flip() +
  theme_classic() +
  facet_wrap(~Company, ncol = 4) +
  theme(axis.text.y = element_text(family = "Times New Roman", size = 12)) + theme_bw() + labs(x = "Enablers", y = "")
