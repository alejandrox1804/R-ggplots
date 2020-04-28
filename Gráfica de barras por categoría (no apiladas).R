
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

dat <- tibble(date = c(seq(date('2014-01-01'),date('2019-12-31'),1))) %>%
    mutate(cat_1 = 10,
           cat_2 = 1)

for (i in 2:nrow(dat)) {

    dat$cat_1[i] <- (1 + runif(1,-0.0050,0.0055))*dat$cat_1[i - 1]
    dat$cat_2[i] <- (1 + runif(1,-0.0060,0.0060))*dat$cat_2[i - 1]
}

dat %>%
    gather('color','y',-date) %>%
    mutate(week = week(date),
           year = year(date)) %>%
    group_by(week,year,color) %>%
    summarise(y = mean(y)) %>% ungroup() %>%
    mutate(date = date('2019-01-01') + (week - 1)*7) %>%
    group_by(color) %>%
    mutate(delta = y/lag(y) - 1) %>%
    filter(year == 2019,week <= 15) %>%
    ggplot(aes(x = date,y = delta, fill = color,color = color)) +
    geom_col(position = 'dodge',width = 4, alpha = 0.25) +
    scale_x_date(date_labels = '%d - %B',
                 breaks = seq(date('2019-01-01'),date('2019-04-09'),7)) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1)) +
    scale_fill_manual(values = colores_1) +
    scale_color_manual(values = colores_1) +
    theme(legend.position = 'bottom',
          panel.background = element_blank(),
          panel.grid.major.y = element_line(color = '#153232',size = 0.1,linetype = 'dotted'),
          panel.grid.minor.y = element_line(color = '#c2d6d6',size = 0.1,linetype = 'dotted'),
          axis.text.x = element_text(angle = 0,face = 'bold'),
          axis.text.y = element_text(face = 'bold'),
          axis.ticks = element_blank(),
          axis.title.y = element_text(face = 'bold'),
          axis.title.x = element_text(face = 'bold'),
          text = element_text(family = 'Arial'),
          plot.title = element_text(hjust = 0.5,face = 'bold'),
          legend.title = element_blank()) +
    ggtitle('Título') +
    xlab('\nDate lab') + ylab('Eje y\n')
