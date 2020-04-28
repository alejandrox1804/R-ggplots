
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

dat %>% # dataframe con una variable de fechas (x), una variable continua (y) y una variable categórica (color)
ggplot(aes(x = date, y = y, color = color)) +
    geom_text(aes(label = LABEL),family = 'Arial',fontface = 'bold') +
    geom_point(size = 28, alpha = 0.15) +
    scale_x_date(date_labels = '%d - %B',
                 breaks = seq(date('2020-01-01'),date('2020-04-08'),7)) +
    scale_y_continuous(limits = c(20,45)) +
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
    xlab('Date label')
