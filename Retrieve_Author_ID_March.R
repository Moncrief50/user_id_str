getwd()
setwd("/work_bgfs/r/rmoncrief/March_Analysis/")

#Loading in the required packages
library(stringi)
library(readr)
library(stringr)
library(cld2)
library(dplyr)
library(tm)
library(data.table)

#Pulling all the files from the folder "03-2020" that are csv files and putting them into the temp variable. 
#Furthermore we want to only exract files over 150 to weed out blank files.
temp = list.files(path = "03-2020", pattern = "*.csv", full.names = TRUE)
temp = temp[file.size(temp) > 150]

#Create a dataframe from the temp variable
df <- read_csv(temp, col_select = c("created_at", "text", "user_id_str", "user_screen_name", "user_verified",
                                                "retweeted_status_created_at", "retweeted_status_id_str",
                                                "retweeted_status_text", "retweeted_status_retweet_count",
                                                "retweeted_status_user_id_str", "retweeted_status_user_screen_name",
                                                "retweeted_status_user_verified", "retweeted_status_lang"), show_col_types = FALSE)


df <- data.frame(df)

#Subset data frame to english only.
df <- subset(df, detect_language(df$text) == "en")
df <- subset(df, df$retweeted_status_lang == "en")

#Top 30~ misinformation hashtags
hashtags <- c("Scamdemic", "Plandemic", "Scaredemic", "NoCovidVaccine", "FilmYourHospital", "5GCoronavirus",
              "FireFauci", "hoaxvirus", "covid19hoax", "coronahoax", "dontwearamask", "id2020",
              "covid1984", "maskoff", "Arrestbillgates", "Barbaramdev", "Chinesebioterrorism", "Coronail", "Cv1984",
              "Drfraudfauci", "Emptyhospitals", "Endcovidscamnow", "Exposebillgates", "Faucifraud", "Faucithefraud", 
              "Filmyourhospital", "Firefauci", "Hcqworks", "Hydroxycholorquineworks", "id2020", "Limengyan",
              "Plandemicdocumentary", "Ramdev", "Arrestfauci", "Casedemic")


#Creating a new dataframe that contains all the tweets that include one or multiple of the top 30~ hashtags.
test <- df[df$text %like% "Scamdemic|Planedemic|Scaredemic|NoCovidVaccine|Scamdemic|Plandemic|Scaredemic|NoCovidVaccine|FilmYourHospital|5GCoronavirus|FireFauci|ExposeBilGates|hoaxvirus|covid19hoax|coronahoax|dontwearamask|id2020|covid1984|maskoff|Arrestbillgates|Barbaramdev|Chinesebioterrorism|Coronail|Cv1984
Drfraudfauci|Emptyhospitals|Endcovidscamnow|Exposebillgates|Faucifraud|Faucithefraud|Filmyourhospital|Firefauci|Hcqworks|Hydroxycholorquineworks|id2020|Limengyan|Plandemicdocumentary|Ramdev|Arrestfauci|Casedemic", ]

#Extracing unique user_id_str from the new dataframe that contains the data we are looking for.
user_id_str_March <- data.frame(test$user_id_str)
user_id_str_March

#Writing the final csv files that will be extracted ito the specified path.
write.csv(test, "/work_bgfs/r/rmoncrief/March_Analysis/df_March.csv")
write.csv(user_id_str_March, "/work_bgfs/r/rmoncrief/March_Analysis/user_id_str_March.csv")

