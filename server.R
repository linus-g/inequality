# server.R

library(shiny)
library(ggplot2)
library(dplyr)
library(ineq)
source("helpers.R")

shinyServer(function(input, output) {
        
        ################### Functions for distribution 1 ################
        dataDist1 <- reactive({  
                generateData(list(c(input$dist1_d1_n, input$dist1_d1_mean, input$dist1_d1_sd), c(input$dist1_d2_n, input$dist1_d2_mean, input$dist1_d2_sd)))
        })
        
        output$dist1_plot <- renderPlot({
                p1 <- distPlot(dataDist1())
                p2 <- ineqPlot(dataDist1())
                
                multiplot(p1, p2, cols=2)
        }, bg = "transparent")
        
        output$table1 <- renderTable({
                
                table <- data.frame(gini=ineq(dataDist1()$income), p90to10=percentileIncomeRatio(dataDist1(), 0.9, 0.1), cov=sd(dataDist1()$income)/mean(dataDist1()$income))
                colnames(table)=c("Gini coefficient", "Ratio P90 to P10", "Coefficient of variation")
                table
        },include.rownames=FALSE)
        
        ################### Functions for distribution 2 ################
        dataDist2 <- reactive({  
                generateData(list(c(input$dist2_d1_n, input$dist2_d1_mean, input$dist2_d1_sd), c(input$dist2_d2_n, input$dist2_d2_mean, input$dist2_d2_sd)))
        })
        
        output$dist2_plot <- renderPlot({
                p1 <- distPlot(dataDist2())
                p2 <- ineqPlot(dataDist2())
                
                multiplot(p1, p2, cols=2)
        }, bg = "transparent")
        
        output$table2 <- renderTable({
                table <- data.frame(gini=ineq(dataDist2()$income), p90to10=percentileIncomeRatio(dataDist2(), 0.9, 0.1), cov=sd(dataDist2()$income)/mean(dataDist2()$income))
                colnames(table)=c("Gini coefficient", "Ratio P90 to P10", "Coefficient of variation")
                table
        },include.rownames=FALSE)
})