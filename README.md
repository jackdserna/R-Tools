# R-Salesforce branch

This branch is dedicated to connecting to Salesforce and doing important processes, like querying and updating. The scripts I've stored in this branch offer efficient and secure methods that go above and beyond the basic arguments laid out in the RForcecom package. 

Logging in securely is important for organization security of data, especially large data warehouses. There are more secure methods than I laid out, but the method I chose is easiest to implement. It could be sufficient enough for most applications.

Updating thousands of records in Salesforce can be a big task. I've created a script that will not only upload thousands of records in seconds, but it will also provide a visual progress bar in the console to show how much has be updated recently. Most importantly, unlike other tools that put restrictions on updating or ask for subscription costs, using R is completely free and with no limits imposed (except for the limits Salesforce imposes).

For more information about the keyring package, go to their github https://github.com/r-lib/keyring, or package PDF https://cran.r-project.org/web/packages/keyring/keyring.pdf, or R Studio tutorial http://db.rstudio.com/best-practices/managing-credentials/.

For more information about the RForcecom package, go to their github https://github.com/hiratake55/RForcecom, or package PDF https://cran.r-project.org/web/packages/RForcecom/RForcecom.pdf. 
