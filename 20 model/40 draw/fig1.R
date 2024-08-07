library(readxl)
library(tidyverse)
library(magrittr)
library(ggtext)
library(grid)
library(showtext)
library(shadowtext)
library(ggnewscale)

# 讀資料 ----
## 先預處理
fig1 <- read_excel("30 output/fig1.xlsx", 
                    sheet = "fig1") %>% 
  transform( 
    var = factor(var,levels = c("睡眠問題", "正面情緒", "負面情緒"))
  )

figx <- fig1 %>% 
  filter( var == "睡眠問題")
figy <- fig1 %>% 
  filter( var == "正面情緒")
figz <- fig1 %>% 
  filter( var == "負面情緒")

# First, define colors. ----
BROWN <- "#AD8C97"
BROWN_DARKER <- "#7d3a46"
GREEN <- "#2FC1D3"
BLUE <- "#076FA1"
GREY <- "#C7C9CB"
GREY_DARKER <- "#5C5B5D"
RED <- "#E3120B"
YELLOW <- "#FFB800"

line_labels <- data.frame(
  labels = c("睡眠問題(1-5分)", "正面情緒(1-4分)", "負面情緒(1-5分)"),
  x = c(13, 13, 13),
  y = c(1.565, 3.05, 1.87),
  color = c(RED, YELLOW, BLUE)
)

labelsx <- line_labels %>% 
  filter( labels == "睡眠問題")
labelsy <- line_labels %>% 
  filter( labels == "正面情緒")
labelsz <- line_labels %>% 
  filter( labels == "負面情緒")

# 睡眠問題line ----
## Basic line chart ----
plt1 <- ggplot(figx, aes(year, mean)) +
  geom_line(aes(color = var), size = 2.4) +
  geom_ribbon(aes(ymin = low, ymax = high), 
              alpha = 0.1, fill = RED,  
              color = "black", linetype = "dotted")+
  geom_point(
    aes(fill = var), 
    size = 5, 
    pch = 21, 
    color = "white", 
    stroke = 1 
  ) +
  # Set values for the color and the fill
  scale_color_manual(values = RED) +
  scale_fill_manual(values = RED) + 
  # Do not include any legend
  theme(legend.position = "none")

plt1

## Customize layout----
plt1 <- plt1 + 
  scale_x_continuous(
    limits = c(12.5, 31),
    expand = c(0, 0), # The horizontal axis does not extend to either side
    breaks = c(13, 14, 15, 18, 22, 24, 27, 30),  # Set custom break locations
    labels = c("13歲", "14歲", "15歲", "18歲", "22歲", "24歲", "27歲", "30歲")
  ) +
  scale_y_continuous(
    limits = c(1.3, 1.6),
    breaks = seq(1.3, 1.6, by = 0.1), 
    expand = c(0, 0)
  ) + 
  theme(
    # Set background color to white
    panel.background = element_rect(fill = "white"),
    # Remove all grid lines
    panel.grid = element_blank(),
    # But add grid lines for the vertical axis, customizing color and size 
    panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
    # Remove tick marks on the vertical axis by setting their length to 0
    axis.ticks.length.y = unit(0, "mm"), 
    # But keep tick marks on horizontal axis
    axis.ticks.length.x = unit(2, "mm"),
    # Remove the title for both axes
    axis.title = element_blank(),
    # Only the bottom line of the vertical axis is painted in black
    axis.line.x.bottom = element_line(color = "black"),
    # Remove labels from the vertical axis
    axis.text.y = element_blank(),
    # But customize labels for the horizontal axis
    axis.text.x = element_markdown(size = 18, face = "bold")
  )   

plt1

## Add labels for the horizontal lines
plt1 <- plt1 + 
  geom_text(
    data = data.frame(x = 31, y = seq(1.3, 1.6, by = 0.1)),
    aes(x, y, label = y),
    hjust = 1, # Align to the right
    vjust = 0, # Align to the bottom
    nudge_y = 1 * 0.005, # The pad is equal to 1% of the vertical range (32 - 0)
    size = 6
  )

plt1

ggsave("30 output/figx.png", 
       plot = plt1, width = 10, height = 4, dpi = 300)

#--------------------------------------------------
# 正面情緒line ----
## Basic line chart ----
plt2 <- ggplot(figy, aes(year, mean)) +
  geom_line(aes(color = var), size = 2.4) +
  geom_ribbon(aes(ymin = low, ymax = high), 
              alpha = 0.1, fill = YELLOW,  
              color = "black", linetype = "dotted")+
  geom_point(
    aes(fill = var), 
    size = 5, 
    pch = 21, 
    color = "white", 
    stroke = 1 
  ) +
  # Set values for the color and the fill
  scale_color_manual(values = YELLOW) +
  scale_fill_manual(values = YELLOW) + 
  # Do not include any legend
  theme(legend.position = "none")

plt2

## Customize layout----
plt2 <- plt2 + 
  scale_x_continuous(
    limits = c(12.5, 31),
    expand = c(0, 0), # The horizontal axis does not extend to either side
    breaks = c(13, 14, 15, 18, 22, 24, 27, 30),  # Set custom break locations
    labels = c("13歲", "14歲", "15歲", "18歲", "22歲", "24歲", "27歲", "30歲")
  ) +
  scale_y_continuous(
    limits = c(2.8, 3.03),
    breaks = seq(2.8, 3, by = 0.1), 
    expand = c(0, 0)
  ) + 
  theme(
    # Set background color to white
    panel.background = element_rect(fill = "white"),
    # Remove all grid lines
    panel.grid = element_blank(),
    # But add grid lines for the vertical axis, customizing color and size 
    panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
    # Remove tick marks on the vertical axis by setting their length to 0
    axis.ticks.length.y = unit(0, "mm"), 
    # But keep tick marks on horizontal axis
    axis.ticks.length.x = unit(2, "mm"),
    # Remove the title for both axes
    axis.title = element_blank(),
    # Only the bottom line of the vertical axis is painted in black
    axis.line.x.bottom = element_line(color = "black"),
    # Remove labels from the vertical axis
    axis.text.y = element_blank(),
    # But customize labels for the horizontal axis
    axis.text.x = element_markdown(size = 18, face = "bold")
  )   

plt2

## Add labels for the horizontal lines
plt2 <- plt2 + 
  geom_text(
    data = data.frame(x = 31, y = seq(2.8, 3, by = 0.1)),
    aes(x, y, label = y),
    hjust = 1, # Align to the right
    vjust = 0, # Align to the bottom
    nudge_y = 1 * 0.005, # The pad is equal to 1% of the vertical range (32 - 0)
    size = 6
  )

plt2

ggsave("30 output/figy.png", 
       plot = plt2, width = 10, height = 4, dpi = 300)
#--------------------------------------------------
# 負面情緒line ----
## Basic line chart ----
plt3 <- ggplot(figz, aes(year, mean)) +
  geom_line(aes(color = var), size = 2.4) +
  geom_ribbon(aes(ymin = low, ymax = high), 
              alpha = 0.1, fill = BLUE,  
              color = "black", linetype = "dotted")+
  geom_point(
    aes(fill = var), 
    size = 5, 
    pch = 21, 
    color = "white", 
    stroke = 1 
  ) +
  # Set values for the color and the fill
  scale_color_manual(values = BLUE) +
  scale_fill_manual(values = BLUE) + 
  # Do not include any legend
  theme(legend.position = "none")

plt3

## Customize layout----
plt3 <- plt3 + 
  scale_x_continuous(
    limits = c(12.5, 31),
    expand = c(0, 0), # The horizontal axis does not extend to either side
    breaks = c(13, 14, 15, 18, 22, 24, 27, 30),  # Set custom break locations
    labels = c("13歲", "14歲", "15歲", "18歲", "22歲", "24歲", "27歲", "30歲")
  ) +
  scale_y_continuous(
    limits = c(1.4, 1.9),
    breaks = seq(1.4, 1.9, by = 0.1), 
    expand = c(0, 0)
  ) + 
  theme(
    # Set background color to white
    panel.background = element_rect(fill = "white"),
    # Remove all grid lines
    panel.grid = element_blank(),
    # But add grid lines for the vertical axis, customizing color and size 
    panel.grid.major.y = element_line(color = "#A8BAC4", size = 0.3),
    # Remove tick marks on the vertical axis by setting their length to 0
    axis.ticks.length.y = unit(0, "mm"), 
    # But keep tick marks on horizontal axis
    axis.ticks.length.x = unit(2, "mm"),
    # Remove the title for both axes
    axis.title = element_blank(),
    # Only the bottom line of the vertical axis is painted in black
    axis.line.x.bottom = element_line(color = "black"),
    # Remove labels from the vertical axis
    axis.text.y = element_blank(),
    # But customize labels for the horizontal axis
    axis.text.x = element_markdown(size = 18, face = "bold")
  )   

plt3

## Add labels for the horizontal lines
plt3 <- plt3 + 
  geom_text(
    data = data.frame(x = 31, y = seq(1.4, 1.9, by = 0.1)),
    aes(x, y, label = y),
    hjust = 1, # Align to the right
    vjust = 0, # Align to the bottom
    nudge_y = 1 * 0.005, # The pad is equal to 1% of the vertical range (32 - 0)
    size = 6
  )

plt3

ggsave("30 output/figz.png", 
       plot = plt3, width = 10, height = 4, dpi = 300)
