#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(dplyr)
library(plotly)
library(ggplot2)
library(chartjs)
library("shinydashboard")


combine_df <- read.csv('./data/combine_df.csv')
combine_df$ID <- seq.int(nrow(combine_df))

explain_df <- read.csv('./data/explain_df.csv')
explain_df$ID <- seq.int(nrow(explain_df))

proportion_df <- data.frame(
  group = c("AIS", "DTAC", "TRUE"),
  value = c(41, 24.5, 24.5),
  color = c('rgb(0, 166, 90)', 'rgb(0, 115, 183)', 'rgb(221, 75, 57)')
)

RevenueCustomer_df <- data.frame(
  group = c("AIS", "DTAC", "TRUE"),
  value = c(251, 216, 217),
  color = c('rgb(0, 166, 90)', 'rgb(0, 115, 183)', 'rgb(221, 75, 57)')
)

AIS_1_df <- read.csv('./data/AIS_summary1.csv')


DTAC_1_df <- read.csv('./data/DTAC_summary1.csv')


TRUE_1_df <- read.csv('./data/TRUE_summary1.csv')





AIS_2_df <- read.csv('./data/AIS_summary2.csv')


DTAC_2_df <- read.csv('./data/DTAC_summary2.csv')


TRUE_2_df <- read.csv('./data/TRUE_summary2.csv')




AIS_3_df <- read.csv('./data/AIS_summary3.csv')


DTAC_3_df <- read.csv('./data/DTAC_summary3.csv')


TRUE_3_df <- read.csv('./data/TRUE_summary3.csv')




ui <- dashboardPage(
  
   
  dashboardHeader(title = "Dashboard"),
   
   
     dashboardSidebar(
       sidebarMenu(
         menuItem("Summary", tabName = "Summary", icon = icon("dashboard")),
         menuItem("AIS", tabName = "AIS"),
         menuItem("DTAC", tabName = "DTAC"),
         menuItem("TRUE", tabName = "TRUE")
       )
      
     ),
      
      # Show a plot of the generated distribution
  dashboardBody(
    tabItems(
      tabItem(tabName = "Summary",
        tags$head(
          tags$style("label{font-family: BentonSans Book;}")
        ),
        fluidRow(
          # plotOutput("distPlot"),
          # plotOutput("test"),
          
          box(width=8, title = "Chart", status = "primary", solidHeader = T, plotlyOutput('plot')),
          box(width=4, title = 'Explain', status='primary', solidHeader = T, htmlOutput('explain'), height = 462)
          
        ),
        fluidRow(
          box(title='Proportion of customer', width = 4, status='primary', solidHeader = T, plotlyOutput('proportion')),
          box(title='Avg revenue per customer', width = 4, status='primary', solidHeader = T,
            plotlyOutput('revenue')
          ),
          box(title='Controller', status='warning', solidHeader = T, width=4,
            selectizeInput('operator', label=h3('Operator'), c('AIS', 'DTAC', 'TRUE'),
                           selected = 'AIS', multiple = T,
                           options = NULL),
            
            selectInput("select", h3("Select box"), choices = combine_df[, 'features'], selected = 1)
          )
        ),
        h3('AIS'),
        fluidRow(
          # AIS
          infoBox("มูลค่าตามราคาตลาด", "539,616.80 ล.",color = "green", icon=icon('stats', lib="glyphicon")),
          
          infoBox("P/E", "17.67",color='green', icon=icon('sort', lib='glyphicon')),
          
          
          infoBox("อัตราปันผล", "3.90%",color='green',icon=icon('usd', lib='glyphicon'))
          
        ),
        h3('DTAC'),
        fluidRow(
          # DTAC
          infoBox("มูลค่าตามราคาตลาด", "111,287.12 ล.",color='blue', icon=icon('stats', lib="glyphicon")),
          
          
          infoBox("P/E", "99.83", color='blue', icon=icon('sort', lib='glyphicon')),
          
          
          infoBox("อัตราปันผล", "0.51%",color='blue', icon=icon('usd', lib='glyphicon'))
          
        ),
        h3('TRUE'),
        fluidRow(
          # TRUE
          infoBox("มูลค่าตามราคาตลาด", "195,203.94 ล.",color='red', icon=icon('stats', lib="glyphicon")),
          
          
          infoBox("P/E", "13.58", color='red', icon=icon('sort', lib='glyphicon')),
          
          
          infoBox("อัตราปันผล", "0.53%",color='red', icon=icon('usd', lib='glyphicon'))
          
        )
      ),
      tabItem(tabName = "AIS",
              fluidRow(
                box(height = 600,
                  h3('ฐานะทางการเงิน'),
                  tableOutput('AIS_1'),
                  hr(),
                  h3('ความสามารถในการทำกำไร'),
                  tableOutput('AIS_2')
                ),
                box(height = 600,
                  h3('การประเมิน'),
                  tableOutput('AIS_3')
                )
              )
      ),
      tabItem(tabName = "DTAC",
              fluidRow(
                box(height = 600,
                  h3('ฐานะทางการเงิน'),
                  tableOutput('DTAC_1'),
                  hr(),
                  h3('ความสามารถในการทำกำไร'),
                  tableOutput('DTAC_2')
                ),
                box(height = 600,
                  h3('การประเมิน'),
                  tableOutput('DTAC_3')
                )
              )
      ),
      tabItem(tabName = "TRUE",
              fluidRow(
                box(height = 600,
                  h3('ฐานะทางการเงิน'),
                  tableOutput('TRUE_1'),
                  hr(),
                  h3('ความสามารถในการทำกำไร'),
                  tableOutput('TRUE_2')
                ),
                box(height = 600,
                  h3('การประเมิน'),
                  tableOutput('TRUE_3')
                )
              )
      )
    )
  )
   
)

server <- function(input, output) {
  output$AIS_1 <- renderTable({
    AIS_1_df
  })
  output$DTAC_1 <- renderTable({
    DTAC_1_df
  })
  output$TRUE_1 <- renderTable({
    TRUE_1_df
  })
  
  
  output$AIS_2 <- renderTable({
    AIS_2_df
  })
  output$DTAC_2 <- renderTable({
    DTAC_2_df
  })
  output$TRUE_2 <- renderTable({
    TRUE_2_df
  })
  
  output$AIS_3 <- renderTable({
    AIS_3_df  
  })
  output$DTAC_3 <- renderTable({
    DTAC_3_df  
  })
  output$TRUE_3 <- renderTable({
    TRUE_3_df  
  })
  
  
  output$explain <- renderText({
    paste(h3(input$select), explain_df[explain_df$feature == as.character(input$select), 'explain'])
  })
  
  output$revenue <- renderPlotly({
    p <- plot_ly(x = RevenueCustomer_df$value,
                 y = RevenueCustomer_df$group,
                 type = 'bar',
                 orientation = 'h',
                 marker = list(color = RevenueCustomer_df$color),
                 text = ~paste(RevenueCustomer_df$value, ' บาท'),
                 textposition = 'auto',
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text'
                 )
    p
  })
  
  output$proportion <- renderPlotly({
    p <- plot_ly(proportion_df,
                 labels = ~group,
                 values = ~value,
                 type = 'pie',
                 textposition = 'inside',
                 textinfo = 'label+percent',
                 showlegend = FALSE,
                 insidetextfont = list(color = '#FFFFFF'),
                 hoverinfo = 'text',
                 text = ~paste('ผู้ใช้ ', value, ' ล้านคน'),
                 marker=list(colors = proportion_df$color, line = list(color = '#FFFFFF', width = 1))) %>%
      layout(
             xaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE),
             yaxis = list(showgrid = FALSE, zeroline = FALSE, showticklabels = FALSE))
    p
  })
  
  output$table <- renderTable({
    
    # print(input$operator)
    # print(input$select)
    
    
    tmp <- data.frame(combine_df)
    tmp$type <- as.character(tmp$type)
    tmp$features <- as.character(tmp$features)
    
    tmp <- tmp %>%
      filter(type %in% input$operator) 
    tmp %>%
      filter(features == input$select)
  })
  
  output$plot <- renderPlotly({
    tmp <- data.frame(combine_df)
    tmp$type <- as.character(tmp$type)
    tmp$features <- as.character(tmp$features)
    
    tmp <- tmp %>%
      filter(type %in% input$operator) 
    tmp <- tmp %>%
      filter(features == input$select)
    
    tmp_ <- list()
    i <- 1
    
    for (i in seq(1, nrow(tmp))){
      tmp_[i] <- list(data.frame("y"=as.double(lapply(as.vector(tmp[i, seq(2, 5)]), function(x) {gsub(',', '', x)})), "type"=tmp[i, 'type']))
      i <- i + 1
    }
    
    # print(tmp_[[1]])
    # print(tmp_)
    color <- data.frame('AIS'='green', 'DTAC'='blue', 'TRUE'='red')
    # print(color[1, as.vector(tmp_[[1]]$type)[1]])
    # print(tmp_)
    #print(length(tmp_))
    #print(tmp_[[length(tmp_)]])
    #print(color)
    # ifelse(color[1, as.vector(tmp_[[i]]$type)[1]] == 'TRUE', 'TRUE.', color[1, as.vector(tmp_[[i]]$type)[1]])
    
    p <- plot_ly(x = seq(2557, 2560), y = tmp_[[1]]$y, type = "scatter", mode='lines', name=tmp_[[1]]$type, color=I(as.character(ifelse(as.vector(tmp_[[1]]$type)[1] == 'TRUE', 'TRUE_', as.character(color[1, as.vector(tmp_[[1]]$type)[1]])))))
    if (length(tmp_) > 1){
      for(i in seq(2, length(tmp_))){
        p <- add_trace(p, x= seq(2557, 2560), y=tmp_[[i]]$y , name=tmp_[[i]]$type, color=I(as.character(ifelse(as.vector(tmp_[[i]]$type)[1] == 'TRUE', 'red', as.character(color[1, as.vector(tmp_[[i]]$type)[1]])))))
      }
    }
    p
    
  })
}


shinyApp(ui = ui, server = server)

