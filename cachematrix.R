## Function that caches the inverse of a Matrix. Calculating the inverse of a matrix
## is a costly operation and if we are going to use it several times it might
## make sense to cache the results in memory

## The first makeCacheMatrix creates a special "matrix", which is really a 
## list containing a function to
## set the value of the matrix
## get the value of the matrix
## set the value of the inverse
## get the value of the inverse

makeCacheMatrix <- function(x = matrix()) {
  mInv <- NULL
  set <- function(y) {
    x <<- matrix(y)
    mInv <<- NULL
  }
  get <- function() x
  setInverse <- function(solve) mInv <<- solve
  getInverse <- function() mInv
  list(set = set, get = get,
       setInverse = setInverse,
       getInverse = getInverse)
}


## The cacheSolve calculates the inverse of the special "matrix" created 
## with the makeCacheMatrix. However, it first checks to see if the inverse 
## has already been calculated. If so, it gets the matrix from the cache and 
## skips the computation. Otherwise, it calculates the inverse of the matrix
## and sets the value of the matrix in the cache via the setInverse function.

cacheSolve <- function(x, ...) {
        ## Return a matrix that is the inverse of 'x'
  mInv <- x$getInverse()
  if(!is.null(mInv)) {
    message("getting cached data")
    return(mInv)
  }
  data <- x$get
  mInv <- solve(mat, ...)
  x$setInverse(mInv)
  mInv
}

## We can test the functions using this.

## mat <- matrix(c(4,2,7,6), 2, 2)

## 
## cacheSolve(makeCacheMatrix(mat))

