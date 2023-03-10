library(tidyverse)
library(ggpubr)
library(rstatix)
library(janitor)
library(DT)

library(readxl)
fuck <- read_excel("fuck.xlsx")

fuck <- clean_names(fuck)

# założenia
# w miarę równoliczne grupy
table(fuck$grupa)

fuck <- fuck %>%
  mutate(grupa = factor(grupa))

# homogeniczne wariancje (p < 0,001)
levene_test(count ~ grupa, data = fuck)

# normalność rozkładu
ggqqplot(fuck, "count", facet.by = "grupa")

fuck %>%
  group_by(grupa) %>%
  shapiro_test(count)

# outlierzy
fuck %>%
  group_by(grupa) %>%
  identify_outliers(count)

# anova między osobami
res.aov <- fuck %>% anova_test(count ~ grupa, effect.size = "pes")
get_anova_table(res.aov)

# post hoc
pwc <- fuck %>% pairwise_t_test(count ~ grupa, p.adjust.method = "bonferroni")
pwc


pwc <- pwc %>% add_xy_position(x = "grupa", fun = "mean_ci")
pwc
# statystyki opisowe
fuck %>%
  group_by(grupa) %>%
  get_summary_stats(count, type = "mean_sd")

# visualizations
brp <- ggbarplot(fuck, x = "grupa", y = "count", add = "mean_ci", 
                 fill = "grupa", palette = c("#e07a5f", "#81b29a", "#f2cc8f"))
brp + 
  stat_pvalue_manual(pwc, hide.ns = TRUE) +
  labs(
    subtitle = get_test_label(res.aov, detailed = TRUE),
    caption = get_pwc_label(pwc)
  ) + 
  ylab("f***") +
  xlab("Grupa filmu")

library(report)
aov_model <- aov(count ~ grupa, data = fuck)
report(aov_model)
report_statistics(aov_model)

#przedzialy ufnosci
library(agricolae)
plot(TukeyHSD(aov_model, conf.level=.95) )
tukey.test2 <- HSD.test(aov_model, trt = 'grupa')
tukey.test2
means <- tapply(fuck$count, fuck$grupa, mean)
trt1.ctrl.diff <- means[2] - means[1]
trt2.ctrl.diff <- means[3] - means[1]
trt2.trt1.diff <- means[3] - means[2]

trt1.ctrl.diff.upper <- trt1.ctrl.diff + q.value * sqrt(mse / 2 * (2 / n))
trt1.ctrl.diff.lower <- trt1.ctrl.diff - q.value * sqrt(mse / 2 * (2 / n))

trt2.ctrl.diff.upper <- trt2.ctrl.diff + q.value * sqrt(mse / 2 * (2 / n))
trt2.ctrl.diff.lower <- trt2.ctrl.diff - q.value * sqrt(mse / 2 * (2 / n))

trt2.trt1.diff.upper <- trt2.trt1.diff + q.value * sqrt(mse / 2 * (2 / n))
trt2.trt1.diff.lower <- trt2.trt1.diff - q.value * sqrt(mse / 2 * (2 / n))
