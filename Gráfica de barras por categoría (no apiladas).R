
library(tidyverse)
library(lubridate)
library(extrafont)

loadfonts(device = "win")

colores_1 <- c('#008080','#002456')

colores_2 <- c('#31f48e','#07aa7b','#0bbeff','#0086ff','#01437d','#ff0040')

ggplot(aes(x = x,y = y, color = as.factor(year))) +
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

ggplot(aes(x = x,y = y,color = color)) +
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
    ylab('Eje y') +
    ggtitle('Título') +
    facet_wrap(~year,scales = 'free')

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

ggplot(aes(x = date,y = y, fill = cat_var,color = cat_var)) +
    geom_col(position = 'dodge',width = 4, alpha = 0.25) +
    scale_x_date(date_labels = '%d - %B',
                 breaks = seq(date('2020-01-01'),date('2020-04-08'),7)) +
    scale_y_continuous(breaks = seq(-0.08,0.14,0.02),
                       labels = scales::percent_format(accuracy = 1)) +
    scale_fill_manual(values = colores_1,labels = c('label 1',...'label n')) +
    scale_color_manual(values = colores_1,labels = c('label 1',...'label n')) +
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
    xlab('Date lab') + ylab('Eje y')
