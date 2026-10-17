# FuelWise | Shiny Application & Five-Slide Pitch

**Created:** October 17, 2026  
**Author:** Vikranth Vijaykumar

## Part 1 — Shiny app

- `app/ui.R` — input controls, output layout, integrated novice instructions and data limitations.
- `app/server.R` — reactive subset, mean MPG, gallons, estimated cost, and reactive charts.
- `app/README.md` — how to run and deploy.

**Live Shiny URL:** Not yet published; obtain after deploying to your shinyapps.io account.

## Part 2 — Reproducible pitch

- `pitch/FuelWise_Pitch.Rpres` — **exactly five slides**, authored in **RStudio Presenter**, with two evaluated R chunks.
- `pitch/pitch.css` — simple custom styling for RStudio Presenter.
- `pitch/index.html` — standalone five-slide HTML showcase for GitHub Pages. The source `.Rpres` should be **rendered in RStudio** to reproduce and verify the evaluated R output; the included HTML is a separately prepared static presentation edition.

## Preview and publish the RStudio Presenter deck

1. Open `pitch/FuelWise_Pitch.Rpres` in RStudio Desktop.
2. Select **Preview**; code chunks run and display R-generated results.
3. Export/publish the generated presentation as HTML to RPubs **or** export and replace `pitch/index.html` with the genuine RStudio-rendered output on GitHub Pages.

The supplied `pitch/index.html` is useful immediately, but for strict assessment of **reproducibility** publish RStudio's exported HTML, not merely the standalone static edition.

## GitHub Pages

If you place files in a `gh-pages` branch, choose that branch and `/ (root)` in **Settings → Pages**. With pitch files in the repository root of that branch, the public presentation URL uses the repository GitHub Pages domain. If files are in a subfolder, the URL includes that folder.

## Submission checklist

- [ ] Public Shiny URL at `<your-account>.shinyapps.io/fuelwise-trip-explorer/` verified and pasted into Part 1.
- [ ] GitHub links to `app/ui.R` and `app/server.R`.
- [ ] Published **RStudio Presenter output** URL on GitHub Pages or RPubs for Part 2.
- [ ] Confirm exactly five slides, evaluated R output, and no R errors.