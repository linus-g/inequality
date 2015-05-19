# ui.R

library(shiny)

shinyUI(navbarPage("Inequality comparisons",
        tabPanel("Simulation",
                column(6,
                       wellPanel(
                               fluidRow(
                                       h3("Distribution 1", align = "center"),
                                       plotOutput("dist1_plot", height="250px"),
                                       tableOutput("table1"),
                                       align="center"
                               ),
                               fluidRow(
                                       fluidRow(
                                               column(3,
                                                      br(),
                                                      h4("Sub-group 1", align="center")
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d1_n", label = h6("Group size"),
                                                                  min = 1, max = 10000, value = 1000)
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d1_mean", label = h6("Mean income"),
                                                                  min = 0, max = 100000, value = 30000)
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d1_sd", label = h6("Standard deviation"),
                                                                  min = 0, max = 20000, value = 5000)
                                               )
                                       ),
                                       fluidRow(
                                               column(3,
                                                      br(),
                                                      h4("Sub-group 2", align="center")
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d2_n", label = NULL,
                                                                  min = 1, max = 10000, value = 1000)
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d2_mean", label = NULL,
                                                                  min = 0, max = 100000, value = 30000)
                                               ),
                                               column(3,
                                                      sliderInput("dist1_d2_sd", label = NULL,
                                                                  min = 0, max = 20000, value = 5000)
                                               )
                                       )
                               )        
                        )
                           
                ),
                
                column(6,
                       wellPanel(
                               fluidRow(
                                       h3("Distribution 2", align = "center"),
                                       plotOutput("dist2_plot", height="250px"),
                                       tableOutput("table2"),
                                       align="center"
                               ),
                               fluidRow(
                                       fluidRow(
                                               column(3,
                                                      br(),
                                                      h4("Sub-group 1", align="center")
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d1_n", label = h6("Group size", align="center"),
                                                                  min = 1, max = 10000, value = 1000)
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d1_mean", label = h6("Mean income"),
                                                                  min = 0, max = 100000, value = 30000)
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d1_sd", label = h6("Standard deviation"),
                                                                  min = 0, max = 20000, value = 5000)
                                               )
                                       ),
                                       fluidRow(
                                               column(3,
                                                      br(),
                                                      h4("Sub-group 2", align="center")
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d2_n", label = NULL,
                                                                  min = 1, max = 10000, value = 1000)
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d2_mean", label = NULL,
                                                                  min = 0, max = 100000, value = 30000)
                                               ),
                                               column(3,
                                                      sliderInput("dist2_d2_sd", label = NULL,
                                                                  min = 0, max = 20000, value = 5000)
                                               )
                                       )
                               ) 
                       )
                )
        ),
        
        tabPanel("Instructions",
                 column(4,
                        wellPanel(
                                h4("Introduction"),
                                p("There are many different ways to measure income inequality, each with their own advantages and disadvantages. A common issue ",
                                        "is that the same measure can give the same result for very different income distributions, even if it would not be unreasonable ", 
                                        "to consider these distributions to have different levels of inequality. A second issue is that different inequality measures ",
                                        " often rank distributions differently."),
                                
                                p("This application allows the user to construct two different income distributions and compare three different measures of inequality ",
                                        "for each of the two distributions, the Gini coefficient, the ratio of income at the 90th percentile to that at the 10 percentile, ", 
                                        "and the coefficient of variation. There are also two plots for each distribution, one histogram of the income distribution and a ",
                                        "plot of the", a("Lorenz curve", href="http://en.wikipedia.org/wiki/Lorenz_curve", target="_blank"), "."),
                                p("More information about measures of inequality, including those used here, and the Lorenz curve can be found in this ", 
                                        a("article", href="http://www.ncbi.nlm.nih.gov/pmc/articles/PMC2652960/", target="_blank"))
                        )
                 ),
                 column(4,
                        wellPanel(
                                h4("Instructions"),
                                p("The user can construct two different income distributions, each based on two subgroups drawn from separate normal distributions with user-specified ",
                                        "sample sizes, means and standard deviations. By combining draws from two different normal distributions, it is possible to create many different ",
                                  "distributions, includning the extreme cases of perfect equality (everybody has the same income) and perfect inequality (one person gets all the income)."),
                                p("The input sliders can be used to specifiy the parameters for each subgroup in each of the two distributions. The inequality measures and plots ",
                                  " will update automatically after each change."),
                                
                                p("Note: Any observations with incomes of less than 0 will be removed from the data set before inequality measures are calculated and plots are produced.")
                                
                        )       
                )
        ),
        
        tabPanel("About",
                 h4("This Shiny application was created by Linus Gustafsson for the Coursera Johns Hopkins Developing Data Products course.")
        )
))
                 
                 