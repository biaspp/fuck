library(readr)
library(tidyverse)
library(ggpubr)
library(rstatix)
library(dplyr)
library(jmv)
library(readr)
library(ggplot2)
library(dplyr)
library(broom)
library(tidymodels)
library(vip)
library(readxl)
library(readxl)
fuck <- read_excel("fuck.xlsx")
fuck %>%
  group_by(dlugosc, grupa ) %>%
  get_summary_stats(Count, type = "common")

boxplot(Count ~ dlugosc * grupa, data = fuck)
bxp <- ggboxplot(
  fuck, x = "grupa", y = "Count",
  fill = "dlugosc", palette = "jco"
)
bxp

#outliers
fuck %>%
  group_by(dlugosc, grupa) %>%
  identify_outliers(Count)

#normalnosc
fuck %>%
  group_by(dlugosc, grupa) %>%
  shapiro_test(Count)

ggqqplot(fuck, "Count", ggtheme = theme_bw()) +
  facet_grid(dlugosc ~ grupa)

model  <- lm(Count ~ dlugosc * grupa, data = fuck)
ggqqplot(residuals(model))
residuals(model) %>% shapiro_test()
fuck %>% levene_test(Count ~ dlugosc*grupa)

res.aov <- fuck %>% anova_test(Count ~ dlugosc*grupa, type = 3, effect.size = "pes")
res.aov

res.aov <- fuck %>% anova_test(Count ~ dlugosc*grupa, white.adjust = TRUE, type = 3, effect.size = "pes")
res.aov

fuck %>%
  group_by(dlugosc) %>%
  anova_test(Count ~ grupa, error = model, effect.size = "pes")
brp <- fuck %>% ggbarplot(x = "dlugosc", y = "Count", add = "mean_ci", 
                       fill = "grupa", palette = c("#e07a5f", "#81b29a", "#f2cc8f"),
                       position = position_dodge(0.8))

pwc <- pwc %>% add_xy_position(x = "dlugosc")

brp + 
  stat_pvalue_manual(pwc) +
  labs(
    subtitle = get_test_label(res.aov, detailed = TRUE),
    caption = get_pwc_label(pwc)
  )

ggboxplot(fuck, x = "grupa", y = "Count")



