#' name_of_module_1 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_name_of_module_1_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("Greenhouse gas emissions for 94 food commodities in the UK"), 
    tags$div(
      "data via", 
      tags$a(
        href = "https://link.springer.com/article/10.1007/s10584-014-1169-1/tables/4", 
        "Dietary greenhouse gas emissions of meat-eaters, fish-eaters, vegetarians and vegans in the UK"
      ), 
      column(
        2, 
        checkboxGroupInput(
          ns("type"), 
          "Type", 
          c("Carne", "Vegetarian", "Vegan"), 
          selected = c("Carne", "Vegetarian", "Vegan")
        ), 
        numericInput(
          ns("n"), 
          "Top n `UK GHG emissions (kgCO2e/kg)`", 
          min = 1, 
          max = 94, 
          value = 25
        )
      ), 
      column(
        10,
        plotOutput(
          ns("plot")
        )
      )
    )
  )
}
    
#' name_of_module_1 Server Functions
#'
#' @noRd 
mod_name_of_module_1_server <- function(id, dataset, r){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    output$plot <- renderPlot({
      my_dataset %>%
        dplyr::filter(type %in% input$type) %>%
        dplyr::top_n(input$n, `UK GHG emissions (kgCO2e/kg)`) %>%
        ggplot2::ggplot(
          ggplot2::aes(
            reorder(`Food category`,`UK GHG emissions (kgCO2e/kg)`),
            `UK GHG emissions (kgCO2e/kg)`, 
            fill = type
          )
        ) +
        ggplot2::geom_col() +
        ggplot2::coord_flip() + 
        ggplot2::scale_fill_viridis_d() + 
        ggplot2::labs(
          x = "Food category", 
          y = "UK GHG emissions (kgCO2e/kg)"
        ) + 
        ggplot2::theme_minimal()
    })
  })
}
    
## To be copied in the UI
# mod_name_of_module_1_ui("name_of_module_1_ui_1")
    
## To be copied in the server
# mod_name_of_module_1_server("name_of_module_1_ui_1")
