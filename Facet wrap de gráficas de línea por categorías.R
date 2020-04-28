
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

    dat$cat_1[i] <- (1 + runif(1,-0.0025,0.0035))*dat$cat_1[i - 1]
    dat$cat_2[i] <- (1 + runif(1,-0.0025,0.0035))*dat$cat_2[i - 1]
}

dat %>%
    gather('color','y',-date) %>%
    group_by(month(date),year(date),color) %>%
    summarise(y = mean(y)) %>%
    ggplot(aes(x = `month(date)`,y = y,color = color)) +
    geom_line() + geom_point() +
    scale_x_continuous(breaks = seq(1,12,1),
                       labels = str_sub(c('Enero','Febrero','Marzo','Abril','Mayo','Junio',
                                          'Julio','Agosto','Septiembre','Octubre','Noviembre','Diciembre'),1,3)) +
    scale_color_manual(values = colores_1) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.text.x = element_text(angle = 90,face = 'bold'),
          axis.text.y = element_text(face = 'bold'),
          axis.title.y = element_text(face = 'bold'),
          axis.title.x = element_blank(),
          axis.ticks = element_blank(),
          text = element_text(family = 'Arial'),
          plot.title = element_text(hjust = 0.5,face = 'bold'),
          legend.title = element_blank(),
          legend.text = element_text(face = 'bold'),
          legend.position = 'bottom') +
    ylab('Eje y\n') +
    ggtitle('Título') +
    facet_wrap(~`year(date)`,scales = 'free')
