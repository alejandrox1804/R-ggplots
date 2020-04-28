
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

dat <- tibble(date = c(seq(date('2014-01-01'),date('2019-12-31'),1))) %>%
    mutate(cat_1 = 10,
           cat_2 = 12)

for (i in 2:nrow(dat)) {

    dat$cat_1[i] <- (1 + runif(1,-0.0070,0.0090))*dat$cat_1[i - 1]
    dat$cat_2[i] <- (1 + runif(1,-0.0070,0.0090))*dat$cat_2[i - 1]
}

dat %>%
    gather('color','y',-date) %>%
    group_by(month(date),year(date),color) %>%
    summarise(y = mean(y)) %>%
    filter(color == 'cat_1') %>%
    ggplot(aes(x = `month(date)`,y = y, color = as.factor(`year(date)`))) +
    geom_line() + geom_point(size = 4,alpha = 0.5) +
    scale_x_continuous(breaks = seq(1,12,1),
                       labels = c('Enero','Febrero','Marzo','Abril','Mayo','Junio',
                                  'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre')) +
    scale_color_manual(values = colores_2) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text.y = element_text(face = 'bold'),
          axis.text.x = element_text(face = 'bold',angle = 90),
          axis.title.y = element_text(face = 'bold'),
          axis.title.x = element_blank(),
          axis.ticks = element_blank(),
          text = element_text(family = 'Arial'),
          plot.title = element_text(hjust = 0.5,face = 'bold'),
          legend.title = element_blank(),
          legend.text = element_text(face = 'bold'),
          legend.position = c(0.6,0.8)) +
    ylab('Título eje y\n') +
    ggtitle('Título')
