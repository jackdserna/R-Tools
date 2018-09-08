# Use this progress bar function to give a graphic visual of upload progress.
# These functions are only to be used with updates into Salesforce via R. 
progressValue<- function(x){
    x = x$numberRecordsProcessed
    return(sum(as.numeric(x)))
}
rows<- function(x){
    return(as.numeric(nrow(x)))
}
progressBar<- function(x, min = 0, max, value){
    pb<- txtProgressBar(min, max, style = 3)
    for(i in 1 : max){
        setTxtProgressBar(pb, value)
        if(value / max == 1){
            close(pb)
        }
    }
}