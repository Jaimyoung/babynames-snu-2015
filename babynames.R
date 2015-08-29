library(ggplot2)
library(dplyr)
library(data.table)

#-------------------
# 1. 자료 추출

data = fread("onefile.txt", header=FALSE, data.table = FALSE)
head(data)
str(data)
names(data) = c('year', 'name', 'gender', 'n')


#-------------------
# 2. 기본적인 분석

# 매 해 가장 인기있던 이름
d1 = data %>%
  group_by(year, gender) %>%
  top_n(1, n)
ggplot(d1, aes(year, n, label=name, color=name)) +
  geom_point() + geom_text() + ggtitle("Most Popular Baby Names")

ggplot(filter(d1, year %% 5 ==0), aes(year, n, label=name, color=name)) +
  geom_point() + geom_text() + ggtitle("Most Popular Baby Names")

ggplot(filter(d1, year %% 10 ==0),
       aes(year, n, label=name, color=gender, group = gender)) +
  geom_point() + geom_line() +
  geom_text() + ggtitle("Most Popular Baby Names")

# 매 해 남아/여아 이름 갯수
d2 = data %>%
  group_by(year, gender) %>%
  summarize(n_names = n())
ggplot(d2, aes(year, n_names, col=gender)) + geom_point() +
  ggtitle("Number of Different Baby Names")


# 매 해 인구수
d3 = data %>% group_by(year, gender) %>% summarize(pop = sum(n))
ggplot(d3, aes(year, pop, col=gender)) + geom_point()

# 인구수당 이름 갯수
(d4 = as.data.table(merge(d3, d2)))
d4 = d4 %>% mutate(names_per_pop = n_names / pop)
ggplot(d4, aes(year, names_per_pop, col=gender)) + geom_point()


