library(shiny)

# FuelWise uses the built-in mtcars dataset. No uploads or API keys required.
shinyUI(fluidPage(
  tags$head(
    tags$title("FuelWise | Interactive Road Trip Fuel Explorer"),
    tags$meta(name = "viewport", content = "width=device-width, initial-scale=1"),
    tags$style(HTML("\n      body { background: #f3f7fb; color: #17253b; font-family: 'Segoe UI', Arial, sans-serif; }\n      .container-fluid { max-width: 1280px; margin: 0 auto; }\n      .hero { background: linear-gradient(115deg, #0f2444, #115b68); border-radius: 20px; color: #fff; padding: 27px 31px; margin: 22px 0 17px; }\n      .hero h1 { margin-top: 0; font-weight: 750; letter-spacing: -.8px; }\n      .hero p { color:#d4e9ef; margin-bottom: 0; font-size: 16px; }\n      .eyebrow { color:#83e6d6; text-transform: uppercase; letter-spacing: 2px; font-size: 11px; font-weight: bold; }\n      .panel-card { background: white; border-radius: 14px; border: 1px solid #e1e8f0; padding: 19px 22px; margin-bottom: 15px; box-shadow: 0 5px 20px rgba(17,48,77,.04); }\n      .panel-card h3 { font-size: 19px; margin: 0 0 16px; font-weight: 700; }\n      .metric-grid { display: flex; flex-wrap: wrap; gap: 12px; margin: 3px 0 13px; }\n      .metric { flex: 1 1 150px; background: #f0f8f8; padding: 18px; border-radius: 12px; border: 1px solid #d2eae9; }\n      .metric .number { font-size: 27px; color: #0c665c; font-weight: 800; }\n      .metric .caption { font-size: 12px; font-weight: 700; color: #526679; text-transform: uppercase; letter-spacing: .5px; }\n      .help-note { padding: 13px 16px; border-radius: 10px; background: #e9f3ff; color: #2e526f; line-height: 1.6; margin-top: 12px; }\n      .nav-tabs>li>a { font-weight: 600; }\n      .form-group label { font-weight: 650; color: #344966; }\n      .small-label { font-size: 12px; color: #61758c; }\n      .doc p, .doc li { font-size: 15px; line-height: 1.65; }\n      @media(max-width:767px){.hero {padding:22px;} .hero h1{font-size:27px;} .metric .number{font-size:23px;}}\n    "))
  ),
  div(class = "hero",
      div(class = "eyebrow", "DATA SCIENCE · SHINY · INTERACTIVE ESTIMATION"),
      h1("FuelWise"),
      p("Explore historical fuel efficiency and estimate road-trip fuel costs in seconds.")),
  tabsetPanel(id = "main_tabs", type = "tabs",
    tabPanel("Trip Explorer", br(),
      fluidRow(
        column(4,
          div(class = "panel-card",
            h3("1 · Choose a vehicle group"),
            selectInput("cyl", "Engine cylinders", choices = c("4 cylinders" = 4, "6 cylinders" = 6, "8 cylinders" = 8), selected = 6),
            radioButtons("transmission", "Transmission", choices = c("All" = "all", "Automatic" = "0", "Manual" = "1"), selected = "0", inline = TRUE),
            hr(), h3("2 · Set your trip"),
            sliderInput("miles", "Trip distance (miles)", min = 50, max = 3000, value = 500, step = 50, sep = ","),
            sliderInput("price", "Gas price ($ per gallon)", min = 1.5, max = 8, value = 3.5, step = 0.25, pre = "$"),
            div(class = "help-note", "Try 6 cylinders + Automatic + 500 miles + $3.50/gallon. Results update as you change any control.")
          )
        ),
        column(8,
          div(class = "panel-card",
            h3("Your estimate"),
            uiOutput("metricCards"),
            textOutput("calculationText"),
            div(class = "small-label", "Educational estimate from the mtcars sample; not a current fuel-economy rating.")
          ),
          div(class = "panel-card", h3("Fuel cost by engine group"), plotOutput("costPlot", height = "270px")),
          div(class = "panel-card", h3("MPG for the selected cars"), plotOutput("mpgPlot", height = "260px"))
        )
      )
    ),
    tabPanel("Start Here · Instructions", br(),
      div(class = "panel-card doc",
        h2("How to use FuelWise"),
        p("FuelWise is designed for first-time users. There are no files to upload and no accounts to create."),
        tags$ol(
          tags$li(strong("Open Trip Explorer."), " This is the main application tab."),
          tags$li(strong("Select 4, 6, or 8 cylinders."), " This filters the historical cars."),
          tags$li(strong("Choose All, Automatic, or Manual."), " The sample changes to match your choice."),
          tags$li(strong("Set trip distance and gasoline price."), " Use the sliders."),
          tags$li(strong("Read the results."), " Compare estimated cost, gallons needed, sample MPG, and cars used.")
        ),
        h3("Worked example"),
        p("For 6-cylinder automatic cars, a 500-mile drive at $3.50 per gallon uses the sample average of 19.125 MPG. Estimated fuel is 26.14 gallons and the total is approximately $91.50."),
        h3("What does MPG mean?"),
        p("MPG is miles per gallon. Higher MPG means fewer gallons are needed for the same trip."),
        h3("How is it calculated?"),
        tags$pre("Mean MPG = average mpg of the matching mtcars rows\nGallons needed = trip miles / mean MPG\nEstimated cost = gallons needed × price per gallon"),
        h3("Tips"),
        p("Try different cylinder counts or transmissions. Watch how the charts and costs change instantly. Use 'All' if you do not want to filter by transmission.")
      )
    ),
    tabPanel("About the Data · Limitations", br(),
      div(class = "panel-card doc",
        h2("Data and assumptions"),
        p("Data source: R's built-in mtcars dataset, a historical Motor Trend road-test collection containing 32 automobiles. It is bundled with R, so the app needs no network data source."),
        tags$ul(
          tags$li("The calculation uses the arithmetic mean MPG of cars in the selected cylinder/transmission group."),
          tags$li("Estimates assume consistent MPG throughout the journey and a fixed fuel price."),
          tags$li("The dataset is old and small; it should not be used as a modern vehicle purchasing recommendation."),
          tags$li("Transmission differences are descriptive, not evidence of a causal effect."),
          tags$li("Actual results depend on speed, terrain, traffic, temperature and individual vehicles.")
        ),
        h3("Privacy and accessibility"),
        p("No personal information is collected by the app. Each control has a visible label and results are also reported as text, rather than only through charts."),
        p(strong("Created: October 17, 2026"))
      )
    )
  ),
  br(), div(class = "small-label", "FuelWise · Created October 17, 2026 · Built with Shiny and base R")
))