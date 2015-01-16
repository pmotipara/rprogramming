corr <- function(directory, threshold = 0) {
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files
  
  ## 'threshold' is a numeric vector of length 1 indicating the
  ## number of completely observed observations (on all
  ## variables) required to compute the correlation between
  ## nitrate and sulfate; the default is 0
  
  ## Return a numeric vector of correlations

  corrs <- vector()
  files <- list.files(directory)
  for (f in files) {
    tmp <- read.csv(paste(directory, "/", f, sep=""), header=TRUE)
    tmp <- tmp[!is.na(tmp["sulfate"]) & !is.na(tmp["nitrate"]), c("sulfate","nitrate")]
    if (nrow(tmp) > threshold) {
      corrs <- c(corrs, cor(tmp$sulfate, tmp$nitrate))
      ##writeLines(text = paste("Added Cor:", cor(tmp$sulfate,tmp$nitrate)), con=stdout())
    }
  }
  corrs
}
