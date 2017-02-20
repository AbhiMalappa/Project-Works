** PART 1 **
pollutantmean <- function(directory, pollutant, id = 1:332) 
{
  data <- data.frame();
  files <- list.files(directory, full.names = TRUE);
  
  for (index in files) {
    data <- rbind(data, read.csv(index, comment.char = ""))
  }
  
  neededMonitors <- subset(data, ID %in% id);
  pollutantMean <- mean(neededMonitors[[pollutant]], na.rm = TRUE);
  pollutantMean;
}

** PART 2 **
complete <- function(directory, id = 1:332) {
  files <- list.files(directory, full.names = TRUE);
  completeCases <- data.frame();
  
  for (index in id) {
    data <- read.csv(files[index], comment.char = "");
    c <- complete.cases(data);
    naRm <- data[c, ];
    completeCases <- rbind(completeCases, c(index, nrow(naRm)));
  }
  
  names(completeCases) <- c("id", "nobs");
  completeCases;
}

** PART 3 **
corr <- function(directory, threshold = 0) {
  files <- list.files(directory, full.names = TRUE);
  correlationList <- c();
  index <- 1;
  
  while (index <= length(files)) {
    completeCases <- complete(directory, index);
    
    if (completeCases$nobs > threshold) {
      data <- read.csv(files[index], comment.char = "");
      correlationList <- c(correlationList, cor(data$sulfate, data$nitrate, use = "complete.obs"));
    }
    index <- index + 1;
  }
  
  correlationList;
}
