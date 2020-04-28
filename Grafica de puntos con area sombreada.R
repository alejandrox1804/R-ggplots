library(tidyverse)
library(extrafont)

loadfonts(device = "win")

colors_pal <- c('#17406D','#0F6FC6','#009DD9','#176A7B','#0BD0D9',
                '#10CF9B','#5FF3CB','#A5C249','#C8DA92','#CC0066',
                '#FE001A','#FA5F00','#FEA300')

tibble(color = as.factor(c(rep('cat_1',500),rep('cat_2',500),rep('cat_3',500),rep('cat_4',500))),
       x = c(rnorm(500,mean = 0.50,sd = 0.25),rnorm(500,mean = 0.60,sd = 0.20),
             rnorm(500,mean = 0.70,sd = 0.15),rnorm(500,mean = 0.75,sd = 0.10))) %>%
    mutate(x = abs(x),
           x = if_else(x > 1,1,x)) %>%
    arrange(color,-x) %>%
    group_by(color) %>%
    mutate(y = 1:n()/n()) %>% ungroup() %>%
    mutate(label_80 = if_else(abs(x/0.8 - 1) == min(abs(x/0.8 - 1)),
                              paste0('Abcde 80% fghij:\n',as.character(round(100*y,digits = 1)),' %'),
                              '')) %>%
    ggplot(aes(x = x,y = y,color = color)) +
    geom_point(size = 1.5,alpha = 0.1,shape = 16) +
    geom_point(aes(fill = color),stroke = 2,shape = 16,alpha = 0.45) +
    geom_text(aes(label = label_80),hjust = 1.0,vjust = -0.2,color = '#000f1c',fontface = 'bold',family = 'Century Gothic',size = 2.8) +
    annotate('rect',xmin = 1,xmax = 0.8,ymin = 0,ymax = 1,alpha = 0.1) +
    scale_x_reverse(labels = scales::percent_format(accuracy = 1),
                    breaks = seq(1,0,-0.1)) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                       limits = c(0,1.0),
                       breaks = seq(0,1.0,0.1)) +
    scale_color_manual(values = colors_pal[c(4,6,5,8)],
                       labels = c('label 1','label 2','label 3','label 4')) +
    scale_fill_manual(values = colors_pal[c(4,6,5,8)],
                      labels = c('label 1','label 2','label 3','label 4')) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.text.x = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.text.y = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.title.x = element_text(face = 'bold',color = '#000f1c'),
          axis.title.y = element_text(face = 'bold',color = '#000f1c'),
          legend.position = c(0.7,0.35),
          legend.title = element_blank(),
          legend.text = element_text(face = 'bold',size = 14,color = '#000f1c'),
          text = element_text(family = 'Century Gothic',color = '#000f1c'),
          plot.title = element_text(hjust = 0.5,face = 'bold',color = '#000f1c')) +
    ylab('Título eje y') +
    xlab('Título eje x') +
    ggtitle('Título')
