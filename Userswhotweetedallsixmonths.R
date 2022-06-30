setwd("/Users/robertmoncrief/Documents/Twitter Data 2020/x2go")

library(stringr)
library(dplyr)
library(plyr)

# Reading in each dataframe
march <- read.csv("03-2020/df_March.csv")
april <- read.csv("04-2020/df_April.csv")
may <- read.csv("05-2020/df_May.csv")
june <- read.csv("06-2020/df_June.csv")
july <- read.csv("07-2020/df_july.csv")
august <- read.csv("08-2020/df_August.csv")

# Binding all the datframe together creating the all variable
all <- rbind(march, april, may, june, july, august)

# Creating the March user ID variable
march_ids <- march$user_id_str

# This section creates a data frame that returns true of false depending on if the user tweeted in that month
wanted <- march_ids %in% april$user_id_str
wanted <- data.frame(wanted)
wanted$may <- march_ids %in% may$user_id_str
wanted$june <- march_ids %in% june$user_id_str
wanted$july <- march_ids %in% july$user_id_str
wanted$august <- march_ids %in% august$user_id_str

colnames(wanted) <- c("april", "may", "june", "july", "august")


wanted$march_ids <- march_ids
# Subsetting the new dataframe to only include TRUE values across all 6 months
wanted <- subset(wanted, april != FALSE & may != FALSE & june != FALSE & july != FALSE & august != FALSE)

# creating the wanted_ids variable. (These are the users that have tweeted all 6 months)
wanted_ids <- wanted$march_ids

# Creating a work dataframe  
all4 <- data.frame(all$user_id_str)
all4$text <- all$text

# Creating two functions which return the count of the keywords.
getCount <- function(data, keyword) {
  wcount <- str_count(str_to_lower(all4$text), keyword)
  return(data.frame(data, wcount))
}

getCount2 <- function(data,keyword) {
  wcount <- str_count(str_to_lower(all4$text), keyword)
  return(data.frame(wcount))
}

# Construction of a new dataframe 
test <- getCount(all4, "scamdemic")
colnames(test) <- c("User_ID_Str", "text", "Scamdemic")
test$Plandemic <- getCount2(all4, "plandemic")
test$Scaredemic <- getCount2(all4, "scaredemic")
test$NoCovidVaccine <- getCount2(all4, "nocovidvaccine")
test$FilmYourHospital <- getCount2(all4, "filmyourhospital")
test$fiveGCoronavirus <- getCount2(all4, "5gcoronavirus")
test$FireFauci <- getCount2(all4, "firefauci")
test$ExposeBillGates <- getCount2(all4, "exposebillgates")
test$hoaxvirus <- getCount2(all4, "hoaxvirus")
test$covid19hoax <- getCount2(all4, "covid19hoax")
test$coronahoax <- getCount2(all4, "coronahoax")
test$dontwearamask <- getCount2(all4, "dontwearamask")
test$id2020 <- getCount2(all4, "id2020")
test$covid1984 <- getCount2(all4, "covid1984")
test$maskoff <- getCount2(all4, "maskoff")
test$Arrestbillgates <- getCount2(all4, "arrestbillgates")
test$Barbaramdev <- getCount2(all4, "barbaramdev")
test$Chinesebioterrorism <- getCount2(all4, "chinesebioterrorism")
test$Coronil <- getCount2(all4, "coronil")
test$Cv1984 <- getCount2(all4, "cv1984")
test$Drfraudfauci <- getCount2(all4, "drfraudfauci")
test$Emptyhospitals <- getCount2(all4, "emptyhospitals")
test$Endcovidscamnow <- getCount2(all4, "endcovidscamnow")
test$Faucifraud <- getCount2(all4, "faucifraud")
test$Faucithefraud <- getCount2(all4, "faucithefraud")
test$Hcqworks <- getCount2(all4, "hcqworks")
test$Hydroxycholorquineworks <- getCount2(all4, "hydroxycholorquineworks")
test$Limengyan <- getCount2(all4, "limengyan")
test$Plandemicdocumentary <- getCount2(all4, "plandemicdocumentary")
test$Ramdev <- getCount2(all4, "Ramdev")
test$Arrestfauci <- getCount2(all4, "arrestfauci")
test$Casedemic <- getCount2(all4, "casedemic")
test$Covidhoax <- getCount2(all4, "covidhoax")
test <- test[,-2]

length(test$User_ID_Str)
length(wanted_ids)



# Creating final data-frame which contains the final user_id count for users who tweeted one of the keywords all 6 months.
test2 <- test[test$User_ID_Str %in% wanted_ids, ]

#Checking the results
results <- test2$User_ID_Str %in% wanted_ids
results <- data.frame(results)

# Grouping together duplicated user_IDs
test2 %>%
  group_by(User_ID_Str) %>%
  summarise_all(sum) %>%
  data.frame() -> Finaldf

# Checking to see if the dataframe is a reasonable size
object.size(Finaldf)

# Confirming the final dataframe has no duplicates
duplicated(Finaldf$User_ID_Str)

write.csv(wanted$march_ids, "/Users/robertmoncrief/Documents/Twitter Data 2020/wanted_ids.csv")
write.csv(Finaldf, "/Users/robertmoncrief/Documents/Twitter Data 2020/Finaldf.csv")
