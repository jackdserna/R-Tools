# Use this R script to modularize R-Salesforce queries for all projects
# To use this in a main script, run the source() function, and paste the path.
# Rememeber to set your object in your main script as 'object'.
# Remember to set your query in your main script as 'soqlQuery'
job<- rforcecom.createBulkJob(session, operation = 'query', object = object)
info<- rforcecom.submitBulkQuery(session, jobId = job$id, query = soqlQuery)
repeat{
    status<- rforcecom.checkBatchStatus(session, jobId = info$jobId, 
                                        batchId = info$id)
    if (status[["state"]]=="Completed") {
        break
    }
    if (status[["state"]]=="Failed") {
        break
    }
}
Sys.sleep(0.1)
details<- rforcecom.getBatchDetails(session, jobId = info$jobId, 
                                    batchId = info$id)
result<- rforcecom.getBulkQueryResult(session, jobId = info$jobId, info$id, 
                                      resultId = details$result)
closeJob<- rforcecom.closeBulkJob(session, jobId = job$id)
rm(job, info, status, details, closeJob, soqlQuery, object)