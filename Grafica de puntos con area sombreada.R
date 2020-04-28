library(tidyverse)
library(extrafont)

loadfonts(device = "win")

colors_pal <- c('#17406D','#0F6FC6','#009DD9','#176A7B','#0BD0D9',
                '#10CF9B','#5FF3CB','#A5C249','#C8DA92','#CC0066',
                '#FE001A','#FA5F00','#FEA300')

dat <- # Algún data frame con dos variables continuas (x y y) y una categórica (color)

ggplot(dat,aes(x = x,y = y,color = color)) +
    geom_point(size = 1.5,alpha = 0.1,shape = 16) +
    geom_point(aes(fill = DIST),stroke = 2,shape = 16,alpha = 0.45) +
    geom_text(aes(label = LABEL_80),hjust = 1.0,vjust = -0.2,color = '#000f1c',fontface = 'bold',family = 'Century Gothic',size = 2.8) +
    annotate('rect',xmin = 1,xmax = 0.8,ymin = 0,ymax = 1,alpha = 0.1) +
    scale_x_reverse(labels = scales::percent_format(accuracy = 1),
                    breaks = seq(1,0,-0.1)) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                       limits = c(0,1.0),
                       breaks = seq(0,1.0,0.1)) +
    scale_color_manual(values = colors_pal[c(4,6,5,8)],
                       labels = c('label 1',...,'label n')) +
    scale_fill_manual(values = colors_pal[c(4,6,5,8)],
                      labels = c('label 1',...,'label n')) +
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
    ylab('Título eje x') +
    xlab('Título eje y') +
    ggtitle('Título')
