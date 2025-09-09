#Clear workspace
rm(list = ls())

library(lubridate)
library(shiny)
library(shinyTime)

ui <- fluidPage(
  headerPanel("Choose Time Intervals for Behavior"),
  sidebarPanel(
    width = 15,
    numericInput('intervals', 'Choose the Number of Intervals :', 4),
    numericInput('sampleSize', 'Choose the Sample Size (in Seconds) :', 3*60*60),
    timeInput("startTime", "Start Time: ", value = "5:30:00"),
    timeInput("endTime", "End Time: ", value = "19:30:00"),
    numericInput('resetNumber', 'Redo this Interval :', 1),
    verbatimTextOutput('result'),
    actionButton("do1", "Enter"),
    actionButton("do2", "Redo")
  )
)

server <- function(input, output) {
  
  intervalStarts = reactiveValues(starts = 0)
  
  observeEvent(input$do1, {
    
    time = input$startTime
    timeMinutes = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%M'))
    timeHours = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%H'))
    timeStart = timeMinutes*60 + 60*60*timeHours
    
    time = input$endTime
    timeMinutes = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%M'))
    timeHours = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%H'))
    timeEnd = timeMinutes*60 + 60*60*timeHours

    intervals = input$intervals
    sampleSize = input$sampleSize
    intervalLength = ceiling(sampleSize/intervals)
    
    secondsVec = timeStart:(timeEnd-intervalLength)
    intervalStarts$starts = sort(sample(x = secondsVec,size = intervals, replace = FALSE))
    differencesBool = diff(intervalStarts$starts)<intervalLength
    counter = 0
    
    while(any(differencesBool)){
      diffIndex = min(which(differencesBool == TRUE))
      invervalRand = sample(c(diffIndex, diffIndex+1), size=1)
      intervalStarts$starts[invervalRand] = sample(x = secondsVec, size = 1)
      intervalStarts$starts = sort(intervalStarts$starts)
      differencesBool = diff(intervalStarts$starts)<intervalLength
      counter = counter+1
      if(counter > 1000){
        differencesBool = FALSE
      }
    }
    
    td1 <- seconds_to_period(intervalStarts$starts)
    td2 <- seconds_to_period(intervalStarts$starts+intervalLength)
    output$result = renderText({sprintf('%02d:%02d:%02d - %02d:%02d:%02d | ', td1@hour, minute(td1), second(td1), td2@hour, minute(td2), second(td2))})
    
  })
  
  observeEvent(input$do2, {
    
    time = input$startTime
    timeMinutes = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%M'))
    timeHours = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%H'))
    timeStart = timeMinutes*60 + 60*60*timeHours
    
    time = input$endTime
    timeMinutes = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%M'))
    timeHours = as.numeric(format(as.POSIXct(time,format='%m/%d/%Y %H:%M:%S'),format='%H'))
    timeEnd = timeMinutes*60 + 60*60*timeHours
    
    intervals = input$intervals
    sampleSize = input$sampleSize
    resetNumber = input$resetNumber
    intervalLength = ceiling(sampleSize/intervals)
    secondsVec = timeStart:(timeEnd-intervalLength)
    
    differencesBool = diff(intervalStarts$starts)<intervalLength

    differencesBool[resetNumber] = TRUE
    counter = 0

    while(any(differencesBool)){
      intervalStarts$starts[resetNumber] = sample(x = secondsVec, size = 1)
      differencesBool = diff(intervalStarts$starts)<intervalLength
      counter = counter+1
      if(counter > 1000){
        differencesBool = FALSE
      }
    }

    td1 <- seconds_to_period(intervalStarts$starts)
    td2 <- seconds_to_period(intervalStarts$starts+intervalLength)
    output$result = renderText({sprintf('%02d:%02d:%02d - %02d:%02d:%02d | ', td1@hour, minute(td1), second(td1), td2@hour, minute(td2), second(td2))})

  })
  
}

shinyApp(ui, server)
