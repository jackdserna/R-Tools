### Login to Salesforce API in R
## This login uses the Operating System's credential storage via the Keyring 
## Package. 
pkgs<- c("RForcecom", "keyring")
install.packages(pkgs, dependencies = TRUE)
sapply(pkgs, require, character.only = TRUE)

### This line of code is hashed because it only need be run once to set the key-
### value pair. For the service name, I recommend typing in your Salesforce 
### instance name as a reminder of which salesforce instance you're working in.
### For example, use "Salesforce Prod" or "Salesforce sandbox" as potential 
### services. You will most likely need to set a key for each Salesforce instance.
### When the pop-up menu appears for a password, I recommend typing the password 
### token together with no spaces. An example is provided, where the value inserted
### replaces the {}:
## password = {user-password}{password-token}
## Set your login to a new keyring
# key_set(service = "service_name", username = "usr") # Menu pop-up for password

## Login to Salesforce
## I recommend saving a separate script for each instance, and sourcing the script
## when necessary. Although the Instance URL is an optional argument, it's required
## in reality. The URL of the Salesforce instance for nonprofit orgs will always
## have their own custom URL. This is also a good time to create multiple login 
## scripts for your instances. 

## In addition, because you will most likely need to set a key for each 
### Salesforce instance you will want to index the appropriate username for each 
### service. To see a list of all usernames under a service, 
### type key_list("service_name"), where you enter the name of the service in quotes.
instance<- "URL_of_Salesforce_instance"
session<- rforcecom.login(username = key_list("service_name")[1,2],
                password = key_get("service_name", 
                                   username = key_list("service_name")[1,2]),
                instance)
objects<- rbind_list(rforcecom.getObjectList(session))
rm(pkgs, instance)