# Selecting-Intervals-for-Piecewise-Continuous-Sampling

# Piecewise Continuous Shiny App

This repository contains a single R script, **`piecewiseContinuousShinyApp.R`**, which launches a Shiny app for conducting **piecewise continuous sampling** of animal behavior.

## What is Piecewise Continuous Sampling?

Capturing qualitative features of animal behavior often requires continuous observation, which can be labor-intensive and sometimes infeasible. Instantaneous sampling reduces effort but misses the fine structure present in continuous data. **Piecewise continuous sampling** provides a middle ground: it samples multiple shorter continuous intervals that are randomly distributed within a larger observation window.

This technique allows researchers to balance efficiency and accuracy, minimizing both labor and sampling error. For example, in a study of harvester-ant workers, piecewise continuous sampling effectively captured behavioral patterns while requiring substantially less effort than full continuous observation.

## Features

- Set the **number of intervals** (`I` in the manuscript).
- Specify the **total number of seconds** to be sampled (`n` in the manuscript).
- Define the **start** and **end** times of the sampling window (e.g., 06:00 to 18:00 for a full-day recording).
- **Randomly generate** sampling intervals within the chosen timeframe.
- **Replace** any interval if it is unsuitable (e.g., if no behavior occurs during that time) and draw a new random interval.

## Installation and Usage

1. **Clone** or download this repository.
2. **Open** `piecewiseContinuousShinyApp.R` in R or RStudio.
3. **Install dependencies** (only if needed):

        install.packages(c("lubridate", "shiny", "shinyTime"))

4. **Run the app**:
   - In RStudio, click **Run App**, or
   - From the Console: `shiny::runApp()` (with the working directory set to the repo folder)

5. **Configure your design** in the UI:
   - Set *Number of intervals (I)*
   - Set *Total sampling time (n, seconds)*
   - Set *Start* and *End* times for the allowable observation window
   - If one interval is unsuitable, select it and request a new random draw

## Example

Recording window: **06:00** to **18:00**  
Design: **I = 5** intervals, **n = 600 seconds** total

The app will generate 5 random continuous intervals whose durations sum to 600 seconds and that are distributed within the 12-hour window.

## Reproducibility

- For reproducible designs, consider setting a seed before running the app (e.g., `set.seed(123)`), provided the script exposes a seed control or you add one.
- Export/record the generated intervals (e.g., copy from the app output or extend the script to save to CSV).

## Citation

If you use this tool in your research, please cite:

Lynch, C. M., Bespalova, I., Harrison, J. F., Pratt, S. C., Pavlic, T. P., & Fewell, J. H. (2025). Piecewise continuous sampling: Balancing effort and accuracy in behavioral observations. *Ethology.* (in press).

## License

Specify a license (e.g., MIT) if you intend others to reuse/modify the code.

## Issues and Contributions

- Please open issues for bugs or feature requests.
- Pull requests are welcome (e.g., exporting intervals, adding seed control, or enabling custom distributions over interval lengths).

