library(tidyverse)
library(ggridges)
library(extrafont)

loadfonts(device = "win")

colors_pal <- c('#17406D','#0F6FC6','#009DD9','#176A7B','#0BD0D9',
                '#10CF9B','#5FF3CB','#A5C249','#C8DA92','#CC0066',
                '#FE001A','#FA5F00','#FEA300')

tibble(x = as.factor(c(rep('cat_1',500),rep('cat_2',500),rep('cat_3',500),rep('cat_4',500))),
       y = c(rnorm(500,mean = 0.20,sd = 0.1),rnorm(500,mean = 0.40,sd = 0.07),
             rnorm(500,mean = 0.60,sd = 0.05),rnorm(500,mean = 0.80,sd = 0.03))) %>%
    group_by(x) %>%
    arrange(x,y) %>%
    mutate(median_lab = if_else(abs(median(y)/y - 1) == min(abs(median(y)/y - 1)),
                                   paste0('Median: ',as.character(round(100*median(y),digits = 1)),' %'),
                                   '')) %>% ungroup() %>%
    ggplot(aes(x = x,y = y,fill = x)) +
    geom_violin(color = 'white',alpha = 0.35,size = 0.05,width = 0.7) +
    geom_boxplot(width = 0.25,alpha = 0.1,color = colors_pal[1],size = 0.6) +
    geom_text(aes(label = median_lab),hjust = 0.6,vjust = -3,color = '#000f1c',fontface = 'bold',family = 'Century Gothic') +
    coord_flip() +
    scale_fill_manual(values = colors_pal[c(4,6,5,8)]) +
    scale_color_manual(values = colors_pal[c(4,6,5,8)]) +
    scale_y_continuous(labels = scales::percent_format(accuracy = 1),
                       limits = c(0,1.0),
                       breaks = seq(0,1.0,0.1)) +
    scale_x_discrete(labels = c('label1','label2','label3','label4')) +
    theme(panel.background = element_blank(),
          panel.grid = element_blank(),
          axis.ticks = element_blank(),
          axis.text.x = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.text.y = element_text(face = 'bold',color = '#000f1c',size = 12),
          axis.title.y = element_blank(),
          axis.title.x = element_text(face = 'bold',color = '#000f1c'),
          legend.position = 'none',
          text = element_text(family = 'Century Gothic',color = '#000f1c'),
          plot.title = element_text(hjust = 0.5,face = 'bold',color = '#000f1c')) +
    ylab('\nTitle axis y') +
    ggtitle('Title')
