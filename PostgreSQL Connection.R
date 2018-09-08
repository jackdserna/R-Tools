### Login to PostgreSQL database
pkgs<- c("DBI", "RPostgreSQL")
install.packages(pkgs, dependencies = TRUE)
sapply(pkgs, require, character.only = TRUE)

### This line of code is hashed because it only need be run once to set the key-
### value pair. For the service name, I recommend typing in your server name 
### as a reminder of which server instance you're working in.For example, use 
### "Server Prod" or "Server Dev" as potential services. You will most likely 
### need to set a key for each server instance. Fill-in your service and username
### to get into the server and databases. 
### Set your login to a new keyring:
# key_set(service = "service_name", username = "usr") # Menu pop-up for password

### Connect to a database using a keyring, and then query all names of tables 
### and views, to use as a reference. If working in only one schema, enter that.
schema<- "enter_schema_name"
con<- DBI::dbConnect(PostgreSQL(), user = key_list("service_name")[1,2],
                     password = key_get("service_name", 
                                        username = key_list("service_name")[1,2]),
                     host = "enter.host.name.here",
                     port = 5432, 
                     dbname = "enter_database_name")
tables<- dbGetQuery(con, "SELECT table_name FROM information_schema.tables
                   WHERE table_schema = schema")