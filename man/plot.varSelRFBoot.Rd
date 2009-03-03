\name{plot.varSelRFBoot}
\alias{plot.varSelRFBoot}
\title{plot a varSelRFBoot object}
\description{
  Plots of out-of-bag predictions and OOB error vs. number of variables.
}
\usage{
\method{plot}{varSelRFBoot}(x,  oobProb = TRUE,
                  oobProbBoxPlot = FALSE,
                  ErrorNum = TRUE,
                  subject.names = NULL,
                  class.to.plot = NULL,...)
}
\arguments{
  \item{x}{An object of class varSelRFBoot, such as returned by
    function \code{\link{varSelRFBoot}}.}
  \item{oobProb}{If TRUE plot (average) out-of-bag predictions. See
    \code{prob.predictions} in \code{\link{varSelRFBoot}} for more
      details about the out-of-bag predictions.}
  \item{oobProbBoxPlot}{If TRUE plot a box-plot of out-of-bag predictions.}
  \item{ErrorNum}{If TRUE plot OOB error (as returned by random forest)
    vs. the number of variables.}
  \item{subject.names}{If not NULL, a vector, of the same length as the
    number of cases (samples or subjects) with IDs for the
    cases/samples/subjects, that will be shown to the left of the
    average out-of-bag prediction.}
  \item{class.to.plot}{If not NULL, an integer or a vector of
    integers. These integers are those class levels for which 
    out-of-bag predictions plots will be returned.} 
  \item{\dots}{Not used.}

}
\value{
  This function is only used for its side effects of producing
  plots.
}\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. and Alvarez de Andres,
    S. (2005) Variable selection from random forests: application to gene
    expression
    data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}

   Efron, B. & Tibshirani, R. J. (1997) Improvements on cross-validation: the .632+ bootstrap method.
    \emph{J. American Statistical Association}, \bold{92}, 548--560.  
 
}

\author{Ramon Diaz-Uriarte \email{rdiaz02@gmail.com}}
\note{
  When plotting the out-of-bag predictions, we show one plot for each
  class. This is an overkill for two-class problems, but not necessarily
  for problems with more than two classes. Use \code{class.to.plot} to
  plot only those classes that interest you.}

\section{Warning }{The OOB Error rate is biased down (and can be
  severely biased down) because we do (potentially many) rounds of
  reducing the set of predictor variables until we minimize this OOB
  error rate. Note, however, that this is NOT the error rate reported as the
  estimate of the error rate for the procedure (for which we use the
  .632+ bootstrap rule).} 

\seealso{
  \code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{summary.varSelRFBoot}},
  \code{\link{varSelRFBoot}}}

\examples{
\dontrun{
## This is a small example, but can take some time.

x <- matrix(rnorm(25 * 30), ncol = 30)
x[1:10, 1:2] <- x[1:10, 1:2] + 2
cl <- factor(c(rep("A", 10), rep("B", 15)))  

rf.vs1 <- varSelRF(x, cl, ntree = 200, ntreeIterat = 100,
                   vars.drop.frac = 0.2)
rf.vsb <- varSelRFBoot(x, cl,
                       bootnumber = 10,
                       usingCluster = FALSE,
                       srf = rf.vs1)
rf.vsb
summary(rf.vsb)
plot(rf.vsb)
}
}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line
