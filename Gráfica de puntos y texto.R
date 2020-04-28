
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

dat <- tibble(date = c(seq(date('2014-01-01'),date('2019-12-31'),1))) %>%
    mutate(cat_1 = 10,
           cat_2 = 10.35)

for (i in 2:nrow(dat)) {

    dat$cat_1[i] <- (1 + runif(1,-0.0040,0.0060))*dat$cat_1[i - 1]
    dat$cat_2[i] <- (1 + runif(1,-0.0040,0.0060))*dat$cat_2[i - 1]
}

dat %>%
    gather('color','y',-date) %>%
    mutate(week = week(date),
           year = year(date)) %>%
    group_by(week,year,color) %>%
    summarise(y = mean(y)) %>%
    filter(year == 2019,week <= 15) %>%
    mutate(date = date('2019-01-01') + (week - 1)*7) %>%
    mutate(label = paste(color,': $\n',round(y,digits = 2))) %>%
    ggplot(aes(x = date, y = y, color = color)) +
    geom_text(aes(label = label),family = 'Arial',fontface = 'bold') +
    geom_point(size = 28, alpha = 0.15) +
    scale_x_date(date_labels = '%d - %B',
                 breaks = seq(date('2019-01-01'),date('2020-04-09'),7)) +
    scale_color_manual(values = colores_1) +
    theme(legend.position = 'none',
          panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text.x = element_text(angle = 0,face = 'bold'),
          axis.text.y = element_blank(),
          axis.ticks = element_blank(),
          axis.title.y = element_blank(),
          axis.title.x = element_text(face = 'bold'),
          text = element_text(family = 'Arial'),
          plot.title = element_text(hjust = 0.5,face = 'bold')) +
    ggtitle('Título') +
    xlab('\nDate label')
