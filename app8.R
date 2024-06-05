# Indebted to Barret Schloerke's solution in this post
# https://forum.posit.co/t/shiny-sortable-how-to-limit-number-of-items-that-can-be-dropped/69233/2
# which in turn took inspiration from https://jsbin.com/nacoyah/edit?js,output

library(shiny)
library(sortable)

# sourcing a script full of functions, like a n00b (for now because of the issue
# of installing custom packages on shinyapps.io)
source("utils.R") 

items <- read_items('qsort_items.yaml')

k <- sqrt(length(items))

# number of items should be a square number
stopifnot(k == as.integer(k))

ui <- fluidPage(
  
  # style for the grid
  make_grid_css(k = 6),
  # Add javascript to make the grid draggable/dropable
  make_grid_js(id = 'my-grid-container'),
  
  fluidRow(
    column(
      width = 3,
      tags$h2("Items to sort"),
      make_grid(items, id = 'my-grid-container'),
    ),
    column(
      width = 9,
      tags$h2("Sort the items here ... (11, 9, 7, 5, 3, 1)"), 
      make_qsort_funnel_row(width = 6, input_id = 'list_1', group = 'my_shared_group', limit=11, offset = 0),
      make_qsort_funnel_row(width = 5, input_id = 'list_2', group = 'my_shared_group', limit=9, offset = 1),
      make_qsort_funnel_row(width = 4, input_id = 'list_3', group = 'my_shared_group', limit=7, offset = 2),
      make_qsort_funnel_row(width = 3, input_id = 'list_4', group = 'my_shared_group', limit=5, offset = 3),
      make_qsort_funnel_row(width = 2, input_id = 'list_5', group = 'my_shared_group', limit=3, offset = 4),
      make_qsort_funnel_row(width = 1, input_id = 'list_6', group = 'my_shared_group', limit=1, offset = 5)
    )
  )
  ,
  # display answers
  tags$p("Row contents"),
  "1st: ", verbatimTextOutput("result_1"),
  "2nd: ", verbatimTextOutput("result_2"),
  "3rd: ", verbatimTextOutput("result_3"),
  "4th: ", verbatimTextOutput("result_4"),
  "5th: ", verbatimTextOutput("result_5"),
  "6th: ", verbatimTextOutput("result_6")
)



server <- function(input, output) {
  output$result_1 <- renderPrint({ input$list_1 })
  output$result_2 <- renderPrint({ input$list_2 })
  output$result_3 <- renderPrint({ input$list_3 })
  output$result_4 <- renderPrint({ input$list_4 })
  output$result_5 <- renderPrint({ input$list_5 })
  output$result_6 <- renderPrint({ input$list_6 })
}

shinyApp(ui, server)