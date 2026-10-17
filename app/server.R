library(shiny)

# All calculations are performed on the server, based on reactive user input.
shinyServer(function(input, output, session) {
  selected_cars <- reactive({
    req(input$cyl, input$transmission)
    cars <- mtcars
    cars$car_name <- rownames(mtcars)
    cars <- cars[cars$cyl == as.numeric(input$cyl), , drop = FALSE]
    if (input$transmission != "all") {
      cars <- cars[cars$am == as.numeric(input$transmission), , drop = FALSE]
    }
    cars
  })

  estimate <- reactive({
    req(input$miles, input$price)
    cars <- selected_cars()
    validate(need(nrow(cars) > 0, "No cars match your selection. Please change a filter."))
    mpg <- mean(cars$mpg)
    gallons <- as.numeric(input$miles) / mpg
    cost <- gallons * as.numeric(input$price)
    list(mpg = mpg, gallons = gallons, cost = cost, n = nrow(cars))
  })

  money <- function(x) paste0("$", formatC(x, digits = 2, format = "f", big.mark = ","))
  metric <- function(value, label) {
    div(class = "metric", div(class = "number", value), div(class = "caption", label))
  }

  output$metricCards <- renderUI({
    e <- estimate()
    div(class = "metric-grid",
      metric(money(e$cost), "Estimated trip fuel cost"),
      metric(sprintf("%.1f", e$gallons), "Gallons needed"),
      metric(sprintf("%.1f", e$mpg), "Sample average MPG"),
      metric(as.character(e$n), "Cars in sample")
    )
  })

  output$calculationText <- renderText({
    e <- estimate()
    paste0(format(input$miles, big.mark = ","), " miles ÷ ",
      sprintf("%.2f", e$mpg), " MPG × ", money(input$price),
      "/gallon = ", money(e$cost), ".")
  })

  output$costPlot <- renderPlot({
    req(input$miles, input$price)
    pool <- mtcars
    if (input$transmission != "all") {
      pool <- pool[pool$am == as.numeric(input$transmission), , drop = FALSE]
    }
    groups <- c(4, 6, 8)
    avg_mpg <- vapply(groups, function(n) mean(pool$mpg[pool$cyl == n]), numeric(1))
    valid <- is.finite(avg_mpg) & avg_mpg > 0
    validate(need(any(valid), "No comparison data available."))
    costs <- input$miles / avg_mpg[valid] * input$price
    cg <- groups[valid]
    cols <- ifelse(cg == as.numeric(input$cyl), "#0a9482", "#aac9d9")
    op <- par(mar = c(4, 4.3, 2.0, 1), bg = "white")
    on.exit(par(op), add = TRUE)
    tops <- barplot(costs, names.arg = paste(cg, "cyl"), col = cols,
      border = NA, ylab = "Estimated fuel cost ($)", ylim = c(0, max(costs) * 1.19),
      cex.axis = 0.9, cex.lab = 0.9)
    text(tops, costs, labels = paste0("$", sprintf("%.0f", costs)), pos = 3, cex = .96, col = "#20314a")
    mtext("Green bar = selected cylinder group", side = 1, line = 2.65, cex = 0.75, col = "#60768b")
  })

  output$mpgPlot <- renderPlot({
    cars <- selected_cars()
    validate(need(nrow(cars) > 0, "No matching cars."))
    op <- par(mar = c(4.2, 4.3, 1.6, 1), bg = "white")
    on.exit(par(op), add = TRUE)
    plot(cars$mpg, rep(1, nrow(cars)) + seq(-0.11, 0.11, length.out = nrow(cars)),
      xlim = range(c(0, cars$mpg + 2)), ylim = c(0.7, 1.3), pch = 19,
      col = "#0d9284", cex = 1.45, xlab = "Miles per gallon (MPG)",
      ylab = "", yaxt = "n", main = "", bty = "l")
    abline(v = mean(cars$mpg), lwd = 2, lty = 2, col = "#db7c44")
    legend("topright", legend = "Orange dashed line = group mean", lty = 2,
      lwd = 2, col = "#db7c44", bty = "n", cex = .80)
    mtext(sprintf("%d matching vehicles", nrow(cars)), side = 3, adj = 0, cex = .85, col = "#5c6b82")
  })
})