# import a webpage into R
library(rvest)
url <- "https://en.wikipedia.org/wiki/Murder_in_the_United_States_by_state"
h <- read_html(url)
class(h)
h

tab <- h %>% html_nodes("table")
tab
tab <- tab[[2]]

tab <- tab %>% html_table
class(tab)

tab <- tab %>% setNames(c("state", "population", "total", "murders", "gun_murders", "gun_ownership", "total_rate", "murder_rate", "gun_murder_rate"))
head(tab)

#Ejemplo
#For the guacamole recipe page, we already have done this and determined that we need the following selectors:
  
h <- read_html("http://www.foodnetwork.com/recipes/alton-brown/guacamole-recipe-1940609")
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
#You can see how complex the selectors are. In any case we are now ready to extract what we want and create a list:
  
guacamole <- list(recipe, prep_time, ingredients)
guacamole
#Since recipe pages from this website follow this general layout, we can use this code to create a function that extracts this information:
  
get_recipe <- function(url){
h <- read_html(url)
recipe <- h %>% html_node(".o-AssetTitle__a-HeadlineText") %>% html_text()
prep_time <- h %>% html_node(".m-RecipeInfo__a-Description--Total") %>% html_text()
ingredients <- h %>% html_nodes(".o-Ingredients__a-Ingredient") %>% html_text()
return(list(recipe = recipe, prep_time = prep_time, ingredients = ingredients))
} 
#and then use it on any of their webpages:
  
get_recipe("http://www.foodnetwork.com/recipes/food-network-kitchen/pancakes-recipe-1913844")
#There are several other powerful tools provided by rvest. For example, the functions html_form(), set_values(), and submit_form() permit you to query a webpage from R. This is a more advanced topic not covered here.

#Ejercicio
url <- "https://web.archive.org/web/20181024132313/http://www.stevetheump.com/Payrolls.htm"
h <- read_html(url)
nodes <- html_nodes(h, "table")
tail(nodes)
length(nodes)

html_text(nodes[[8]])
html_table(nodes[[20]])
tab_1 <- html_table(nodes[[10]])
tab_2 <- html_table(nodes[[19]])

url <- "https://en.wikipedia.org/w/index.php?title=Opinion_polling_for_the_United_Kingdom_European_Union_membership_referendum&oldid=896735054"
h <- read_html(url)
nodes <- html_nodes(h, "table")
ncol(head(html_table(nodes[[5]],fill = TRUE)))
