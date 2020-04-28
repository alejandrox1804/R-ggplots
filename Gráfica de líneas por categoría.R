
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

dat %>% # dataframe con dos variables categóricas (x y var_cat) y una continua (y)
ggplot(aes(x = x,y = y, color = as.factor(var_cat))) +
    geom_line() + geom_point(size = 4,alpha = 0.5) +
    scale_x_continuous(breaks = seq(1,4,1),
                       labels = c('label 1',...,'label n')) +
    scale_color_manual(values = colores_2) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text = element_text(face = 'bold'),
          axis.title.y = element_text(face = 'bold'),
          axis.title.x = element_blank(),
          axis.ticks = element_blank(),
          text = element_text(family = 'Arial'),
          plot.title = element_text(hjust = 0.5,face = 'bold'),
          legend.title = element_blank(),
          legend.text = element_text(face = 'bold'),
          legend.position = c(0.6,0.8)) +
    ylab('Título eje y') +
    ggtitle('Título')
