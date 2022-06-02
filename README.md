# user_id_str
Based on 30 of the top misinformation hashtags we extracted from twitter, I have pulled out all of the accounts associated with these hashtags.

"User_ID_Str" is the final extraction containing all of the unique user IDs. This version has also deleted any duplicated IDs.

"Retrieve_Author_ID_March.R" is the Rscript I used to complete this process. (R Script used to extract unique user ID's from each month)

"df_..." is the dataframe which contains all the relevant information for the extracted user_id_str. (Based on Month)

"user_id_str_..." is a list of the unique "user_id_str" that used the target misinformation hashtags. (Based on Month)
