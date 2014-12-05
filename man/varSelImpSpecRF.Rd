\name{varSelImpSpecRF}
\alias{varSelImpSpecRF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Variable selection using the "importance spectrum"}
\description{
  Perform variable selection based on a simple heuristic using the
  importance spectrum of the
  original data compared to the importance spectra from the same data
  with the class labels randomly permuted.
}
\usage{
varSelImpSpecRF(forest, xdata = NULL, Class = NULL,
                randomImps = NULL,
                threshold = 0.1,
                numrandom = 20,
                whichImp = "impsUnscaled",
                usingCluster = TRUE,
                TheCluster = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{forest}{A previously fitted random forest (see \code{\link[randomForest]{randomForest}}).}
  \item{xdata}{A data frame or matrix, with subjects/cases in rows and
    variables in columns. NAs not allowed.}
  \item{Class}{The dependent variable; must be a factor.}
  \item{randomImps}{A list with a structure such as the object
    return by \code{\link{randomVarImpsRF}}}.
  \item{threshold}{The threshold for the selection of variables. See details.}
  \item{numrandom}{The number of random permutations of the class labels.}
  \item{whichImp}{One of \code{impsUnscaled},
    \code{impsScaled}, \code{impsGini}, that correspond, respectively, to
    the (unscaled) mean decrease in accuracy, the scaled mean decrease
    in accuracy, and the Gini index.  See below and
\code{\link[randomForest]{randomForest}},
    \code{importance} and the references for further explanations of the
    measures of variable importance.}
   \item{usingCluster}{If TRUE use a cluster to parallelize the calculations.}
  \item{TheCluster}{The name of the cluster, if one is used.}
  \item{\dots}{Not used.}
}
\details{
  You can either pass as arguments a valid object for \code{randomImps},
  obtained from a previous call to \code{\link{randomVarImpsRF}} OR
  you can pass a covariate data frame and a dependent variable, and
  these will be used to obtain the random importances. The former is
  preferred for normal use, because this function will not returned the
  computed random variable importances, and this computation can  be
  lengthy.  If you pass both \code{randomImps}, \code{xdata}, and \code{Class},
  \code{randomImps} will be used.


  To select variables, start by  ordering  from largest (\eqn{i=1}) to smallest
  (\eqn{i = p}, where \eqn{p} is the number of
  variables),  the variable importances from the original data and from
  each  of the data sets with permuted class labels. (So the ordering is
  done in each data set independently). Compute 
  \eqn{q_i}, the \eqn{1 - threshold} quantile of
  the ordered variable importances from the permuted data at ordered
  postion \eqn{i}. Then,
  starting from \eqn{i = 1}, let \eqn{i_a} be the first \eqn{i} for which
  the variable importance from the original data is smaller than
  \eqn{q_i}. Select all variables from \eqn{i=1} to \eqn{i = i_a - 1}.

}
\value{A vector with the names of the selected variables, ordered by
  decreasing importance.}
\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. , Alvarez de Andres,
  S. (2005) Variable selection from random forests: application to gene
  expression
  data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}
  
  Friedman, J., Meulman, J. (2005) Clustering objects on subsets of attributes (with discussion).
  \emph{J. Royal Statistical Society, Series B}, \bold{66}, 815--850. } 


\author{Ramon Diaz-Uriarte \email{rdiaz02@gmail.com}} \note{The name
  of this function is related to the idea of "importance spectrum plot",
  which is the term that \cite{Friedman \& Meulman, 2005} use in their paper.}

\seealso{
  \code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{varSelRFBoot}},
  \code{\link{randomVarImpsRFplot}},
  \code{\link{randomVarImpsRF}}
}
\examples{
x <- matrix(rnorm(45 * 30), ncol = 30)
x[1:20, 1:2] <- x[1:20, 1:2] + 2
cl <- factor(c(rep("A", 20), rep("B", 25)))  

rf <- randomForest(x, cl, ntree = 200, importance = TRUE)
rf.rvi <- randomVarImpsRF(x, cl, 
                          rf, 
                          numrandom = 20, 
                          usingCluster = FALSE) 
varSelImpSpecRF(rf, randomImps = rf.rvi)



\dontrun{
## Identical, but using a cluster
psockCL <- makeCluster(2, "PSOCK")
clusterSetRNGStream(psockCL, iseed = 456)
clusterEvalQ(psockCL, library(varSelRF))

rf.rvi <- randomVarImpsRF(x, cl, 
                          rf, 
                          numrandom = 20, 
                          usingCluster = TRUE,
                          TheCluster = psockCL) 
varSelImpSpecRF(rf, randomImps = rf.rvi)
stopCluster(psockCL)

}



}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line
