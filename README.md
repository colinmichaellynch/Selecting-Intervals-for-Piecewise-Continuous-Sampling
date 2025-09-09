# Selecting-Intervals-for-Piecewise-Continuous-Sampling

This repository contains a single R script, **`piecewiseContinuousShinyApp.R`**, which launches a Shiny app for conducting **piecewise continuous sampling** of animal behavior.  

## What is Piecewise Continuous Sampling?

Capturing qualitative features of animal behavior often requires continuous observation, which can be labor-intensive and sometimes infeasible. Instantaneous sampling reduces effort but misses the fine structure present in continuous data. **Piecewise continuous sampling** provides a middle ground: it samples multiple shorter continuous intervals that are randomly distributed within a larger observation window.  

This technique allows researchers to balance efficiency and accuracy, minimizing both labor and sampling error. For example, in a study of harvester-ant workers, piecewise continuous sampling was found to effectively capture behavioral patterns while requiring substantially less effort than full continuous observation.

## Features of the App

The Shiny app provides an interactive interface where you can:  
- Set the number of intervals (`I` in the manuscript).  
- Specify the total number of seconds to be sampled (`n` in the manuscript).  
- Define the start and end times of the sampling window (e.g., 6:00 AM to 6:00 PM for a full video recording).  
- Randomly generate sampling intervals within the chosen timeframe.  
- Replace any interval if it is unsuitable (e.g., if no behavior occurs during that time), and generate a new random draw.  

This tool is designed to make it easy for behavioral researchers to generate unbiased, randomized sampling schemes.

## Installation and Usage

1. Clone or download this repository.  
2. Open **`piecewiseContinuousShinyApp.R`** in R or RStudio.  
3. Ensure the required R packages are installed:  
   ```r
   install.packages(c("lubridate", "shiny", "shinyTime"))
