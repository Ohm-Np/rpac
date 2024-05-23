## next_weekday.R

library("lubridate")

next_weekday <- function(day) {

  # Define the order of weekdays
  weekdays_order <- c("Monday", "Tuesday", "Wednesday", "Thursday", "Friday",
                      "Saturday", "Sunday")

  # Find the index of the current day
  day_index <- match(day, weekdays_order)

  if (is.na(day_index)) {
    stop("Invalid day provided. Please enter a valid weekday name.")
  }

  # Calculate the index of the next day
  next_day_index <- day_index %% 7 + 1

  # Return the name of the day
  return(weekdays_order[next_day_index])
}

# Example usage:

# next_weekday("Monday")
# next_weekday("Friday")


