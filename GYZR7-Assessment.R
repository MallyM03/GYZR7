##Part-1A##

##Set up##
Vaccine.1<-read.csv("Vaccine Coverage and Disease Burden - WHO (2017).csv")
summary(Vaccine.1)

if(!require("pacman")) {
  install.packages("pacman")
}
pacman::p_load(
  tidyverse,
  glue,
  gapminder,
  ggplot2,
  dplyr,
  purr
  
)

##Cleaning##

Vaccine.1$Entity<-factor(Vaccine.1$Entity)
l1<-levels(Vaccine.1$Entity)
Vaccine.1$Year<-factor(Vaccine.1$Year)
l2<-levels(Vaccine.1$Year)
table(colSums(is.na(Vaccine.1)))
glimpse(Vaccine.1)

summary(Vaccine.1)

datVaccine.2<-drop_na(Vaccine.1)
glimpse(Vaccine.2)
colSums(is.na(Vaccine.2))
summary(Vaccine.2)

##Part 1-B##

##Data Plot 1##

Vaccine.2[,15]<-Vaccine.2[,14]*(100/Vaccine.2[,13])
colnames(Vaccine.2)[15]<-"Total Population"
Vaccine.3<- Vaccine.2 %>% select(Entity,Year,Measles..MCV..immunization.coverage.among.1.year.olds..WHO.2017.,Number.of.confirmed.measles.cases..WHO.2017.,'Total Population')
Vaccine.3[,6]<-Vaccine.3[,5]*(Vaccine.3[,3]/100)
colnames(Vaccine.3)[6]<-"Total Number of Children Immunized (MCV)"

rename_columns <- function(data, new_names) {
  colnames(data) <- new_names
  return(data)
}

new_colnames<- c("Country","Years","Total Percent of Children Immunized (MCV)","Number of Measles Cases","Total Population","Total Number of Children Immunized (MCV)")
Vaccine.3<-rename_columns(Vaccine.3,new_colnames)

count_levels <- function(data, variable_name) {
  result <- table(data[[variable_name]])
  return(result)
}

count_levels_2(Vaccine.3,"Country")


Vaccine.GA<- subset.data.frame(Vaccine.3,Country %in% c("Georgia","Afghanistan"))
levels(Vaccine.GA$Country)
factor(Vaccine.GA$Country)



##Data Plot 2##
Vaccine.2014<-subset(Vaccine.2[1:12], Vaccine.2$Year=="2014" & Entity %in% c("Europe","South-East Asia","Africa"))
Vaccine.2014<-Vaccine.2014[,-c(3:7)]
new_colnames_2<-c("Entity","Year","Tetanus Cases","Polio Cases","Pertussis Cases","Measles Cases","Diphtheria Cases")
Vaccine.2014<-rename_columns(Vaccine.2014,new_colnames_2)

#Data Plot 3##
Vaccine.TB<- subset(Vaccine.2[,-c(4:12)], Vaccine.2$Entity %in% c("Iran","Ireland","Romania","India","Gambia","Costa Rica","Russia"))
Vaccine.TB[,6]<-Vaccine.TB[,5]*(100/Vaccine.TB[,4])
colnames(Vaccine.TB)[6]<-"Total Population"
Vaccine.TB[,7]<-Vaccine.TB[,6]*(Vaccine.TB[,3]/100)
new_colnames_3<- c("Country","Years","BCG vaccine among 1 year olds","Deaths due to TB per hundred people", "Estimated TB deaths","Total Population")
Vaccine.TB<-rename_columns(Vaccine.TB,new_colnames_3)
colnames(Vaccine.TB)[7]<-"Total Number of Children Immunized (BCG)"
Vaccine.TB$Year<-`levels<-`(Vaccine.TB$Year, c(2010,2011,2012,2013,2014))
droplevels.factor(Vaccine.TB$Year)


##Part 2-A##

##Plot 1##
library(ggplot2)
Vaccine.GA<- Vaccine.GA %>% arrange(Years)
ggplot(Vaccine.GA, aes(x =`Total Number of Children Immunized (MCV)`, y =`Number of Measles Cases`, color = Country)) +
  geom_point() +         
  geom_smooth(method = "lm") +  
  labs(title = "Immunization rates and Measles Rate contrast for Afghanistan and Georgia",
       x = "Immunization for 1 year olds 2010-14",
       y = "Measles Infection rate 2010-14",
       color = "Country") +  
  scale_x_continuous(breaks = seq(0, max(Vaccine.GA$`Total Number of Children Immunized (MCV)`), by = 2000)) +
  scale_y_continuous(breaks = seq(0, max(Vaccine.GA$`Number of Measles Cases`), by = 2000)) +
  theme_grey()+
  theme(plot.title=element_text(hjust=0.5))

##Plot 2##
create_bar_g <- function(data, x_col, y_cols) {
  plots <- list()
  for (y_col in y_cols) {
    p <- ggplot(data, aes(x = {{x_col}}, y = .data[[y_col]])) +
      geom_bar(stat = "identity", position = "dodge") +
      geom_text(aes(label = .data[[y_col]]), vjust = -0.5)+
      labs(title = glue("Bar Graph for {.data[[x_col]][1]} ({y_col})",.data) ,
           x = deparse(substitute("Parts of the World 2014")),
           y = y_col) 
    plots[[y_col]] <- p
  }
  return(plots)
}

y_cols <- colnames(Vaccine.2014)[3:7]

bar_graphs <- create_bar_g(Vaccine.2014, x_col = Vaccine.2014$Entity, y_cols = y_cols)
bar_graphs <- map(y_cols, ~ create_bar_g(Vaccine.2014, x_col = Vaccine.2014$Entity, y_col = .x))
walk(bar_graphs, print)

library(gridExtra)

b_list<-c(bar_graphs[[1]], bar_graphs[[2]],bar_graphs[[3]],bar_graphs[[4]],bar_graphs[[5]])
n <- length(b_list)
nCol <- floor(sqrt(n))
do.call("grid.arrange", c(b_list, ncol=nCol, top= "Cases of Infectious Diseases by Region-2014"))

##Plot 3##
Vaccine.TB$Years<-as.factor(Vaccine.TB$Years)
  
g <- ggplot(Vaccine.TB, aes('Estimated TB Deaths','Total Number of Children Immunized (BCG)' )) + 
  labs(subtitle="7 Countries over 5 years",
       title="Comparison of Immunization and TB Deaths 2010-14",size = "Years", 
       color = 'Country',x= "TB DEaths (Estimate)" ,y= "Total Number of Children Immunized (BCG)")+ 
  geom_jitter(aes(col=Vaccine.TB$Country, size= Vaccine.TB$Years)) + 
  geom_smooth(aes(col=Vaccine.TB$`Country`), method="lm")
 
print(g)  










