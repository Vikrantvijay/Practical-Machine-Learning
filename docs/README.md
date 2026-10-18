# Beyond the Algorithm: Global AI & Robotics Atlas

**Created:** 18 October 2026  
**Assignment:** R Markdown web page featuring an interactive Leaflet map.

## What's included

- `index.Rmd` — R Markdown source. Uses the **R `leaflet` package** to build a map with four toggleable regional layers and clickable campus markers.
- `index.html` — polished, ready-to-host interactive Leaflet webpage. It uses Leaflet.js and online CARTO/OpenStreetMap tiles. Includes regional filters, a navigable university directory, popups, pan/zoom, and the visible creation date.
- `.nojekyll` — ensures GitHub Pages serves the static files as-is.

## Preview

Open `index.html` in a browser while connected to the internet. The map needs access to Leaflet's CDN and CARTO map tiles.

## Rebuild from R Markdown

1. Open `index.Rmd` in RStudio.
2. Run `install.packages(c("rmarkdown", "leaflet", "htmlwidgets", "knitr"))` in the R console if needed.
3. Click **Knit** to render the R Markdown version to HTML.
4. For an RPubs submission, click **Publish** on the knitted HTML preview and share your public RPubs URL.

The provided `index.html` is a separately styled production webpage with equivalent campus data and Leaflet interaction. Re-knitting `index.Rmd` regenerates its own R Markdown output with the R `leaflet` widget and will overwrite `index.html` if done in the same folder. Preserve a copy first if you want both visual variants.

## Publish to GitHub Pages

Add these files under the repository's `/docs` directory. Then go to **Settings → Pages → Build and deployment → Deploy from a branch → main → /docs → Save**. Public URL shape: `https://USERNAME.github.io/REPOSITORY/`.

### Assignment checklist

- [x] Page displays **18 October 2026** prominently, within the stated two-month grading window for a submission graded near this date.
- [x] Interactive map **built with Leaflet**, including working zoom, markers and popups.
- [x] Source file in **R Markdown**.
- [ ] Live public hosting must be verified after configuring GitHub Pages or publishing to RPubs.