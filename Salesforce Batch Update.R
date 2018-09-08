# Use this R script to modularize R-Salesforce updates for all projects.
# To use this in a main script, run the source() function, and paste the path.
# Rememeber to set your object in your main script as 'object'.
# Remember to set your upload data in your main script as 'upData'

# Set concurrencyMode = 'Serial' to avoid "Lock Contentions", which prevent you
# from updating a record due to the unability to access and update the record. 
# Switching to 'Serial' mode instead of 'Parallel' is the safest option.
# As a note, 'Parellel' mode is faster and works most of the time. However, I 
# have noticed some issues of running into this error.

# NOTE: This script depends on the progress_bar_update R script. 
job<- rforcecom.createBulkJob(session, operation = 'update', object = object, 
                              concurrencyMode = 'Parallel')
info<- rforcecom.createBulkBatch(session, jobId = job$id, data = upData, 
                                 multiBatch = TRUE, batchSize = 250)
status<- rbindlist(lapply(info, FUN = function(x) {
    rforcecom.checkBatchStatus(session,jobId = x$jobId, batchId = x$id)
}), fill = TRUE)
# Continuously run all batches
v = 0
while(all(status$state == "Completed") != TRUE) {
    status<- rbindlist(lapply(info, FUN = function(x) {
        rforcecom.checkBatchStatus(session,jobId = x$jobId, batchId = x$id)}), 
        fill = TRUE)
    progressBar(status, max = rows(upData), 
                value = v+progressValue(status))
    if(any(status$state == "Failed") == TRUE) {break}
}
Sys.sleep(0.1)
details<- rbindlist(lapply(split(status, status$id), FUN = function(x){
    rforcecom.getBatchDetails(session, jobId = x$jobId, batchId = x$id)
}))  
closeJob<- rforcecom.closeBulkJob(session, jobId = job$id)
rm(status, closeJob, info, job, v)