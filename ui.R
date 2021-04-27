ohdsiBlueHex <- "#20425A"
ohdsiLightYellowHex <- "FBC209"

addInfo <- function(item, infoId, class = NULL, style = NULL) {
  if (is.null(class)) {
    class = "badge pull-right action-button"
  }
  if (is.null(style)) {
    style = "padding: 1px 6px 2px 6px; background-color: steelblue;"
  }
  infoTag <- tags$small(class = class,
                        style = style,
                        type = "button", 
                        id = infoId,
                        "i")
  item$children[[1]]$children <- append(item$children[[1]]$children, list(infoTag))
  return(item)
}

dashboardPage(
  dashboardHeader(
    title = "EHDEN RA DUS",
    tags$li(div(img(src = 'logo.png',
                    title = "EHDEN Rheumatoid Arthritis Drug Utilization Study", 
                    height = "40px", 
                    width = "40px"),
                style = "padding-top:0px; padding-bottom:0px;"),
            class = "dropdown")    
    ),  
  dashboardSidebar(
    tags$head(tags$style(HTML(paste0('.main-header { background-color: ', ohdsiBlueHex, '; }')))),
    sidebarMenu(id = "tabs",
                menuItem("About", tabName = "about"),
                menuItem("csDMARD Totals", tabName = "totals"),
                menuItem("Secular Trends", tabName = "trends"),
                menuItem("Database information", tabName = "databaseInformation")#,
    )
  ),
  dashboardBody(
    tags$head(
      tags$link(rel="stylesheet", type="text/css", href="ohdsi.css")
    ),
    ### changing theme
    tabItems(
      tabItem(tabName = "about",
              includeMarkdown("md/about.md")
      ),
     tabItem(tabName = "databaseInformation",
              downloadButton("dlDatabaseInformation", "Download Data"),
              htmlOutput("borderDatabaseInformation"),
              dataTableOutput("databaseInformationTable")
      )
    )
  )
)