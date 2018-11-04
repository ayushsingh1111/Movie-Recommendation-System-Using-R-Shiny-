# This file includes how to create a dashboard in shiny framework for user-interface - 


## ui.R
library(shiny)
library(shinydashboard)
library(proxy)
library(recommenderlab)
library(reshape2)
library(plyr)
library(dplyr)
library(DT)
library(RCurl)

movies <- read.csv("movies.csv", header = TRUE, stringsAsFactors=FALSE)
movies <- movies[with(movies, order(title)), ]

ratings <- read.csv("ratings100k.csv", header = TRUE)


shinyUI(dashboardPage(skin="red",
                      dashboardHeader(title = "Movie Recommenders"),
                      dashboardSidebar(
                        sidebarMenu(
                          menuItem("Movies", tabName = "movies", icon = icon("star-o")),
                          menuItem("About", tabName = "about", icon = icon("question-circle")),
                          menuItem("Source code", icon = icon("file-code-o"), 
                                   href = "https://github.com/ayushsingh1111"),
                          menuItem(
                            list(
                              
                              selectInput("select", label = h5("Select 3 Movies That You Like"),
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Shawshank Redemption, The (1994)"),
                              selectInput("select2", label = NA,
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Forrest Gump (1994)"),
                              selectInput("select3", label = NA,
                                          choices = as.character(movies$title[1:length(unique(movies$movieId))]),
                                          selectize = FALSE,
                                          selected = "Silence of the Lambs, The (1991)"),
                              submitButton("Submit")
                            )
                          )

                          )
                      ),
                      
                      
                      dashboardBody(
                        tags$head(
                          tags$style(type="text/css", "select { max-width: 360px; }"),
                          tags$style(type="text/css", ".span4 { max-width: 360px; }"),
                          tags$style(type="text/css",  ".well { max-width: 360px; }")
                        ),
                        
                        tabItems(  
                          tabItem(tabName = "about",
                                  h2("About this App"),
                                  
                                  HTML('<br/>'),
                                  
                                  fluidRow(
                                    box(title = "Capstone Project -", background = "black", width=7, collapsible = TRUE,
                                        
                                        helpText(p(strong("This application a movie reccomnder using the movielense dataset."))),
                                        
                                        helpText(p("Please contact us on",
                                                   a(href ="https://twitter.com/lpuayushsingh", "twitter",target = "_blank"),
                                                   " or at our",
                                                   a(href ="https://www.linkedin.com/in/ayush-singh-85b817126/", "LinkedIn", target = "_blank"),
                                                   ", for more information, to suggest improvements or report errors.")),
                                        
                                        helpText(p("All code and data is available at our",
                                                   a(href ="https://github.com/ayushsingh1111", "GitHub page",target = "_blank"),
                                                   "or click the 'source code' link on the sidebar on the left."
                                        ))
                                      )
                                  )
                            ),
                          tabItem(tabName = "movies",
                                  fluidRow(
                                    box(
                                      width = 6, status = "info", solidHead = TRUE,
                                    title = "Other Movies You Might Like",
                                    tableOutput("table")),
                                    valueBoxOutput("tableRatings1"),
                                    valueBoxOutput("tableRatings2"),
                                    valueBoxOutput("tableRatings3"),
                                    HTML('<br/>'),
                                    box(DT::dataTableOutput("myTable"), title = "Table of All Movies", width=12, collapsible = TRUE)
                                )
                            )
                        )
                    )
              )
          )              
