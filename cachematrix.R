## Data Science - John Hopkins University through Coursera
##Programming Assignment 2: Lexical Scoping
##Steve Orosz
##2/15/2018
## This assignment is to become familiar with storing data in a different location and ahead of time
##in case the calculations take a long time to run. Two functions will be created to do this.
##The first function will be called makeCacheMatrix. It will calculate the inverse of a matrix and store it
##cached memory. The second function, will check if the inverse calculation for the matrix exists already in 
##cached memory. If so it will simply return what the inverse is by getting the previously runned result. If it
##does not find the inverse of the matrix, it will calculate the inverse locally. The solve() function will be
##used to get the inverse of the matrix.

## makeCacheMatrix calculates the inverse of a matrix and stores the result in cached memory.
makeCacheMatrix <- function(x = matrix()) {
  m <- NULL #Initialize m variable that holds matrix
  set <- function(y) {
    x <<- y
    m <<- NULL
  }
  get <- function() x
  setsolve <- function(solve) m <<- solve #Calculates solve function stores inverse
  getsolve <- function() m
  list(set = set, get = get,
       setsolve = setsolve,
       getsolve = getsolve)

}


## cacheSolve function checks if the inverse of the matrix exists already in cached memory. If so it will retrieve
##the cached value already calculated. If the inverse of the matrix does not exist, then the function will use
##solve function to get the inverse of the matrix.
cacheSolve <- function(x = matrix(), ...) {
        ## Return a matrix that is the inverse of 'x'
  
  m <- x$getsolve()
  if(!is.null(m)) { #Checks if inverse of matrix has already been calculated and stored in cache memory
    message("Getting cached data")
    return(m) #Returns already inverse answer from cached memory
  }
  data <- x$get() #If above section does not return anything, then this section runs to calculate matrix inverse
  m <- solve(data, ...) #Runs solve function against matrix to get inverse
  x$setsolve(m)
  message("Calculating inverse")
  return(m) #Returns calculated inverse of matrix
}

#Interaction Section of above two functions
#Create a matrix
usematrix <- matrix(c(1/2, -1/4, -1, 3/4), nrow = 2, ncol = 2) #Example 1
usematrix <- matrix(c(1/6, -1/2, -1, 1/4), nrow = 2, ncol = 2) #Example 2
usematrix <- matrix(c(1/4, 1/9, -4, 3/4), nrow = 2, ncol = 2)  #Example 3
usematrix

#Use the matrix and run makeCacheMatrix function
cashematrix <- makeCacheMatrix(usematrix)
#Run 2nd function cacheSolve to return previously cached inverse answer or run solve to get inverse answer
inversematrix <- cacheSolve(cashematrix)
inversematrix


#Testing
solve(usematrix)
solve(inversematrix)




