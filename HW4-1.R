# Code for HW#4 using mainly shell commands

convert_count = function(x){
  data.frame(matrix(unlist(strsplit(x, " ")), nrow = 4, byrow = T))
}

flight_count = function (file, origin=TRUE){
  my_command = sprintf("cut -f %i -d , %s | egrep '(SMF|OAK|SFO|LAX)' | sort | uniq -c", 18-origin, file)
  countings = system(command = my_command, intern = TRUE)
  countings = convert_count(countings)
  return(countings)
}

Sys.setlocale(locale="C")
count_Ori = system(command = "cut -f 17 -d , 1987.csv | egrep '(SMF|OAK|SFO|LAX)' | sort | uniq -c",intern = TRUE)
count_Des = system(command = "cut -f 18 -d , 1987.csv | egrep '(SMF|OAK|SFO|LAX)' | sort | uniq -c",intern = TRUE)
count_Ori = convert_count(count_Ori)
count_Des = convert_count(count_Des)

summary_delay = function(airport, filename = "2008.csv"){
  my_command = sprintf("egrep '(%s)' %s | cut -f 15 -d ,", airport, filename)
  list_delay = as.numeric(system(command = my_command, intern = TRUE))
#  list_delay = list_delay[!is.na(list_delay)]
  summary = list(average_delay = mean(list_delay, na.rm = TRUE), 
                 standard_deviation = sd(list_delay, na.rm = TRUE))
  return(summary)
}  
