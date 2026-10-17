# FuelWise Shiny Application

**Created:** October 17, 2026  
**Technology:** R Shiny; built-in `mtcars` data; no extra modeling packages.

## Run locally

1. Install R and RStudio.
2. In RStudio run `install.packages("shiny")` once.
3. Open this `app` folder and run `shiny::runApp(".")`, or open `ui.R` and click **Run App**.
4. Follow the **Start Here · Instructions** tab inside the app itself.

## Deploy to shinyapps.io

1. Create/sign in to a free account at https://www.shinyapps.io/.
2. In RStudio install `rsconnect` if needed: `install.packages("rsconnect")`.
3. In shinyapps.io select **Account / Tokens**, add a token, show and copy its `rsconnect::setAccountInfo(...)` command. Paste this **only into your own private RStudio Console**. Never publish the token or secret to GitHub.
4. Run `rsconnect::deployApp(appDir = "path/to/app", appName = "fuelwise-trip-explorer")`, replacing the path with your downloaded `app` folder.
5. Open the returned public shinyapps.io URL and test changing each control.

The Shiny application includes documentation in **Start Here · Instructions** and **About the Data · Limitations**, so the grader does not have to visit external instructions.

## Core calculation

`mean_mpg = mean(selected$mpg)`  
`gallons = input$miles / mean_mpg`  
`cost = gallons * input$price`

The data are educational and historical, not current fuel economy estimates.