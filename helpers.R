# Function to generate data on income distributions
# Takes a list of vectors as a an argument
# list(c(group_size, mean_income, standard_deviation), c(...))

generateData <- function(dist_parameters){
        library(ineq)
        
        data <- data.frame()
        
        for(i in 1:length(dist_parameters)){
                data <- rbind(data, data.frame(income=rnorm(dist_parameters[[i]][1], dist_parameters[[i]][2], dist_parameters[[i]][3])))
        }
        
        # Remove observations with negative income
        data <- data %>% filter(income>=0) %>% arrange(income)
        
        # Generate data for Lorenz curve plot 
        lc <- Lc(x=data$income)
        data <- rbind(data.frame(income=0),data)
        data$percentile <- lc$p
        data$incshare <- lc$L
        data$percentileline <- lc$p
        
        return(data)
}

# Function used to calculate the ratio of incomes as different percentiles
percentileIncomeRatio <- function(distData, high, low){
        library(dplyr)
        
        highInc <- distData %>% filter(percentile>=high) %>% select(income)
        lowInc <- distData %>% filter(percentile>=low) %>% select(income)
        
        highInc[1,1]/lowInc[1,1]
}


# Function to create the histogram of incomes
# Takes data frame with variable called income as argument
distPlot <- function(distdata) {
        
        ggplot(distdata, aes(x=income)) + geom_histogram(fill='steelblue1', color="grey") + 
                xlab("Income") +
                ylab("Frequency") +
                ggtitle("Distribution of income") +
                theme(plot.background = element_rect(fill = "transparent", colour=NA)) #,panel.background = element_rect(fill = NULL, colour = NA))
}

# Function to create plot of Lorenz curve
# Takes data frame with variables called percentile and incshare as argument
ineqPlot <- function(distdata) {
       
        ggplot(distdata, aes(x=percentile, y = incshare)) + geom_line(colour="blue") + geom_line(aes(y=percentileline), colour="black") + 
                geom_ribbon(aes(ymax=percentileline, ymin=incshare), alpha=0.4, fill="yellow") +
                geom_ribbon(aes(ymax=incshare, ymin=0), alpha=0.4, fill="blue") +
                coord_cartesian(xlim = c(0, 1), ylim=c(0,1)) +
                xlab("Percentile") +
                ylab("Percent of income") +
                ggtitle("Income inequality (Lorenz curve)") +
                theme(plot.background = element_rect(fill = "transparent", colour=NA))
                
}

# This function has been taken from the R Cookbook website.
# http://www.cookbook-r.com/Graphs/Multiple_graphs_on_one_page_(ggplot2)/

multiplot <- function(..., plotlist=NULL, file, cols=1, layout=NULL) {
        library(grid)
        
        # Make a list from the ... arguments and plotlist
        plots <- c(list(...), plotlist)
        
        numPlots = length(plots)
        
        # If layout is NULL, then use 'cols' to determine layout
        if (is.null(layout)) {
                # Make the panel
                # ncol: Number of columns of plots
                # nrow: Number of rows needed, calculated from # of cols
                layout <- matrix(seq(1, cols * ceiling(numPlots/cols)),
                                 ncol = cols, nrow = ceiling(numPlots/cols))
        }
        
        if (numPlots==1) {
                print(plots[[1]])
                
        } else {
                # Set up the page
                grid.newpage()
                pushViewport(viewport(layout = grid.layout(nrow(layout), ncol(layout))))
                
                # Make each plot, in the correct location
                for (i in 1:numPlots) {
                        # Get the i,j matrix positions of the regions that contain this subplot
                        matchidx <- as.data.frame(which(layout == i, arr.ind = TRUE))
                        
                        print(plots[[i]], vp = viewport(layout.pos.row = matchidx$row,
                                                        layout.pos.col = matchidx$col))
                }
        }
}