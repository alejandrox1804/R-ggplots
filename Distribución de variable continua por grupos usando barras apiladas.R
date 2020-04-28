library(tidyverse)
library(ggridges)
library(extrafont)

colors_pal <- c('#17406D','#0F6FC6','#009DD9','#176A7B','#0BD0D9',
                '#10CF9B','#5FF3CB','#A5C249','#C8DA92','#CC0066',
                '#FE001A','#FA5F00','#FEA300')

loadfonts(device = 'win')

tibble(x = c(rnorm(500,mean = 0.25,sd = 0.15),rnorm(500,mean = 0.50,sd = 0.15),
             rnorm(500,mean = 0.65,sd = 0.10),rnorm(500,mean = 0.80,sd = 0.10))) %>%
    mutate(x = abs(x),
           x = if_else(x > 1,1,x),
           x = cut(x,breaks = c(0,0.4,seq(0.5,1,0.1)),include.lowest = TRUE),
           cat_1 = runif(n(),1000,25000),
           cat_2 = runif(n(),1000,25000),
           cat_3 = runif(n(),1000,25000),
           cat_4 = runif(n(),1000,25000),
           cat_5 = runif(n(),1000,25000)) %>%
    gather('fill','val',-x) %>%
    group_by(x,fill) %>%
    summarise(y = sum(val)) %>% ungroup() %>%
    group_by(x) %>%
    mutate(y = y/sum(y),
           aux_lab = cumsum(y) - y/2) %>%
    ggplot(aes(x = x,y = y,fill = fill)) +
    geom_col(width = 1,alpha = 0.5) +
    geom_text(aes(y = aux_lab,label = scales::percent(y)),
              color = '#000f1c',fontface = 'bold',family = 'Century Gothic') +
    scale_fill_manual(values = colors_pal[c(4,7,8,5,3)]) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                       limits = c(0,1.0),
                       breaks = seq(0,1.0,0.1)) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.text.x = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.text.y = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.title.y = element_text(face = 'bold',color = '#000f1c'),
          axis.title.x = element_text(face = 'bold',color = '#000f1c'),
          legend.title = element_blank(),
          legend.text = element_text(face = 'bold',color = '#000f1c'),
          text = element_text(family = 'Century Gothic',color = '#000f1c'),
          plot.title = element_text(hjust = 0.5,face = 'bold',color = '#000f1c')) +
    xlab('\nTítulo eje x') +
    ylab('Título eje y\n') +
    ggtitle('Título')

