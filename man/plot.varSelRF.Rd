\name{plot.varSelRF}
\alias{plot.varSelRF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Plot a varSelRF object}
\description{
  Plots a varSelRF object, showing the initial variable importances, and
  the change in OOB error with the number of variables.}
\usage{
plot.varSelRF(x, nvar = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{x}{The varSelRF object.}
  \item{nvar}{The number of variables for which the initial variable
    importances should be shown. By default, only the 30 with the
    largest importance are shown.}
  \item{\dots}{Not used.}
}
\value{This function is only used for its side effect of producing plots.
}
\references{
    Diaz-Uriarte, R. and Alvarez de Andres,
    S. (2005) Variable selection from random forests: application to gene
    expression
    data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}
}
\author{Ramon Diaz-Uriarte \email{rdiaz@ligarto.org}}
\section{Warning }{The OOB Error rate is biased down (and can be
  severely biased down) because we do (potentially many) rounds of
  reducing the set of predictor variables until we minimize this OOB
  error rate.} 

\seealso{\code{\link{varSelRF}}, \code{\link[randomForest]{randomForest}},
  \code{\link[randomForest]{importance}}}
\examples{
x <- matrix(rnorm(25 * 30), ncol = 30)
x[1:10, 1:2] <- x[1:10, 1:2] + 2
cl <- factor(c(rep("A", 10), rep("B", 15)))  

rf.vs1 <- varSelRF(x, cl, ntree = 200, ntreeIterat = 100,
                   vars.drop.frac = 0.2)
rf.vs1
plot(rf.vs1)
}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line
