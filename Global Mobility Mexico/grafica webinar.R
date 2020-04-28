install.packages('colorRamps')
install.packages('scales')

library(tidyverse)
library(lubridate)

data <- read.csv('Global Mobility Mexico/Global_Mobility_Report_google.csv') %>%
    filter(country_region == 'Mexico') %>%
    mutate(date = dmy(date))

data_color_order <- data %>%
    filter(sub_region_1 != '',
           date == max(date)) %>%
    arrange(-retail_and_recreation_percent_change_from_baseline) %>%
    select(sub_region_1,retail_and_recreation_percent_change_from_baseline) %>%
    mutate(ORDER = 1:n()) %>%
    select(-retail_and_recreation_percent_change_from_baseline) %>%
    arrange(sub_region_1)

data$sub_region_1 <- factor(data$sub_region_1,levels = c(as.character(arrange(data_color_order,ORDER)$sub_region_1),
                                                         ''))

ggplot() +
    geom_point(data = filter(data,sub_region_1 != ''),
               aes(x = date, y = retail_and_recreation_percent_change_from_baseline,color = sub_region_1)) +
    scale_color_manual(values = colorRamps::blue2green(32)[data_color_order$ORDER]) +
    geom_point(data = filter(data,sub_region_1 == ''),
               aes(x = date, y = retail_and_recreation_percent_change_from_baseline),
               color = 'red',shape = 18,size = 4, alpha = 0.6) +
    scale_x_date(date_breaks = '2 days',
                 labels = scales::date_format('%d - %B')) +
    scale_y_continuous(breaks = seq(-90,30,10)) +
    theme(axis.text.x = element_text(angle = 90),
          axis.ticks = element_blank()) +
    xlab('\nFecha') +
    ylab('Retail and recreation percent change from baseline\n') +
    labs(color = 'T?tulo de la leyenda')
