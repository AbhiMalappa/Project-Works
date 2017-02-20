##  Description 
##  Data - 
##  The data is collection of 332 comma-separated-value (CSV) files containing pollution monitoring data for fine particulate matter (PM) air pollution at 332 locations in the United States. Each file contains data from a single monitor and the ID number for each monitor is contained in the file name. For example, data for monitor 200 is contained in the file "200.csv". 
##  Part 1
##  The code calculates the mean of a pollutant (sulfate or nitrate) across a specified list of monitors. The function 'pollutantmean' takes three arguments: 'directory', 'pollutant', and 'id'. Given a vector monitor ID numbers, 'pollutantmean' reads that monitors' particulate matter data from the directory specified in the 'directory' argument and returns the mean of the pollutant across all of the monitors, 
##  Part 2
##  The code reads a directory full of files and reports the number of completely observed cases in each data file. The function returns a data frame where the first column is the name of the file and the second column is the number of complete cases. 
##  Part 3
##  Calculates the correlation between sulfate and nitrate for monitor locations where the number of completely observed cases (on all variables) is greater than the threshold. The function returns a vector of correlations for the monitors that meet the threshold requirement. 

## PART 1 
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

##** PART 2 **
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
