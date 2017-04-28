line.fun <- function(alpha, 
                     x, 
                     x1, 
                     y1, 
                     x2, 
                     y2) {
  
  w <- (x - x1) / (x2 - x1)
  
  w <- w ^ alpha
  
  
  output <- y1 * (1 - w) + y2 * w
  
  return(output)
  
  
}

linear <- function(x) {line.fun(alpha = 1, x = x, x1 = 0, y1 = 0, x2 = 100, y2 = 80)}
slow <- function(x) {line.fun(alpha = .7, x = x, x1 = 0, y1 = 0, x2 = 100, y2 = 80)}
fast <- function(x) {line.fun(alpha = .05, x = x, x1 = 0, y1 = 0, x2 = 100, y2 = 80)}
