library(tidyverse)
library(cluster)
library(factoextra)
library(dplyr)
library(readxl)

# import data
wine_seg <- read_excel('D:/S2/Analisis Data Lanjut/wine/Wine-segmentation.xlsx', sheet = 'Sheet2')
head(wine_seg)
dim(wine_seg)
str(wine_seg)
summary(wine_seg)
wine1 <- scale(wine_seg)
head(wine_seg)

# finding the k optimum
fviz_nbclust(wine1, kmeans, method = "silhouette")

# cluster k-means
set.seed(123)
kmeans_wine1 <- kmeans(wine1, 3, nstart = 25)
print(kmeans_wine1)

fviz_cluster(kmeans_wine1, data = wine1)

clust_win  = wine_seg %>%
              mutate(Cluster = kmeans_wine1$cluster) %>%
              group_by(Cluster) %>%
              summarise_all("mean")
clust_win
library(writexl)
write_xlsx(clust_win,"D:/S2/Analisis Data Lanjut/wine/Wine-clust.xlsx")
