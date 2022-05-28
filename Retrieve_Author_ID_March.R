getwd()
setwd("/work_bgfs/r/rmoncrief/March_Analysis/")

library(stringi)
library(readr)
library(stringr)
library(cld2)
library(dplyr)
library(tm)
library(data.table)

temp = list.files(path = "03-2020", pattern = "*.csv", full.names = TRUE)
temp = temp[file.size(temp) > 150]

df <- read_csv(temp, col_select = c("created_at", "text", "user_id_str", "user_screen_name", "user_verified",
                                                "retweeted_status_created_at", "retweeted_status_id_str",
                                                "retweeted_status_text", "retweeted_status_retweet_count",
                                                "retweeted_status_user_id_str", "retweeted_status_user_screen_name",
                                                "retweeted_status_user_verified", "retweeted_status_lang"), show_col_types = FALSE)

df <- data.frame(df)
df <- subset(df, detect_language(df$text) == "en")
df <- subset(df, df$retweeted_status_lang == "en")

hashtags <- c("Scamdemic", "Plandemic", "Scaredemic", "NoCovidVaccine", "FilmYourHospital", "5GCoronavirus",
              "FireFauci", "ExposeBilGates", "hoaxvirus", "covid19hoax", "coronahoax", "dontwearamask", "id2020",
              "covid1984", "maskoff", "Arrestbillgates", "Barbaramdev", "Chinesebioterrorism", "Coronail", "Cv1984",
              "Drfraudfauci", "Emptyhospitals", "Endcovidscamnow", "Exposebillgates", "Faucifraud", "Faucithefraud", 
              "Filmyourhospital", "Firefauci", "Hcqworks", "Hydroxycholorquineworks", "id2020", "Limengyan",
              "Plandemicdocumentary", "Ramdev", "Arrestfauci", "Casedemic")


test <- df[df$text %like% "Scamdemic|Planedemic|Scaredemic|NoCovidVaccine|Scamdemic|Plandemic|Scaredemic|NoCovidVaccine|FilmYourHospital|5GCoronavirus|FireFauci|ExposeBilGates|hoaxvirus|covid19hoax|coronahoax|dontwearamask|id2020|covid1984|maskoff|Arrestbillgates|Barbaramdev|Chinesebioterrorism|Coronail|Cv1984
Drfraudfauci|Emptyhospitals|Endcovidscamnow|Exposebillgates|Faucifraud|Faucithefraud|Filmyourhospital|Firefauci|Hcqworks|Hydroxycholorquineworks|id2020|Limengyan|Plandemicdocumentary|Ramdev|Arrestfauci|Casedemic", ]

user_id_str_March <- data.frame(test$user_id_str)
user_id_str_March

write.csv(test, "/work_bgfs/r/rmoncrief/March_Analysis/df_March.csv")
write.csv(user_id_str_March, "/work_bgfs/r/rmoncrief/March_Analysis/user_id_str_March.csv")

