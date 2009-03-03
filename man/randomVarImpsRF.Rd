\name{randomVarImpsRF}
\alias{randomVarImpsRF}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{ Variable importances from random forest on permuted class labels}
\description{
  Return variable importances from random forests fitted to data sets
  like the original except class labels have been randomly permuted.
}
\usage{
randomVarImpsRF(xdata, Class, forest, numrandom = 100,
                whichImp = "impsUnscaled", usingCluster = TRUE,
                TheCluster = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{xdata}{A data frame or matrix, with subjects/cases in rows and
    variables in columns. NAs not allowed.}
  \item{Class}{The dependent variable; must be a factor.}
  \item{forest}{A previously fitted random forest (see \code{\link[randomForest]{randomForest}}).}
  \item{numrandom}{The number of random permutations of the class labels.}
  \item{whichImp}{A vector of one or more of \code{impsUnscaled},
    \code{impsScaled}, \code{impsGini}, that correspond, respectively, to
    the (unscaled) mean decrease in accuracy, the scaled mean decrease
    in accuracy, and the Gini index.  See below and
\code{\link[randomForest]{randomForest}},
    \code{\link[randomForest]{importance}} and the references for further explanations of the
    measures of variable importance.}
   \item{usingCluster}{If TRUE use a cluster to parallelize the calculations.}
  \item{TheCluster}{The name of the cluster, if one is used.}
  \item{\dots}{Not used.}
}
\details{
  The measure of variable importance most often used is based on the decrease
  of classification accuracy when values of a variable in a node of a
  tree are permuted randomly (see references);
  we use the unscaled version ---see our paper and supplementary
  material. Note that, by default, \code{\link[randomForest]{importance}} returns the scaled
  version.  } \value{An object of class randomVarImpsRF, which is a list
  with one to three named components. The name of each
  component corresponds to the types of variable importance measures
  selected (i.e., impsUnscaled, impsScaled, impsGini).

  Each component is a matrix, of dimensions number of variables by
  \code{numrandom}; each element \code{(i,j)} of this matrix is the variable
  importance for variable \code{i} and random permutation \code{j}.
}
\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. and Alvarez de Andres,
    S. (2005) Variable selection from random forests: application to gene
    expression
    data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}

 Svetnik, V., Liaw, A. , Tong, C & Wang, T. (2004) Application of
 Breiman's random forest to modeling structure-activity relationships of
 pharmaceutical molecules.  Pp. 334-343 in \emph{F. Roli, J. Kittler, and T. Windeatt}
 (eds.). \emph{Multiple Classier Systems, Fifth International Workshop}, MCS
 2004, Proceedings, 9-11 June 2004, Cagliari, Italy. Lecture Notes in
 Computer Science, vol. 3077.  Berlin: Springer.

}
\author{Ramon Diaz-Uriarte  \email{rdiaz02@gmail.com}}

\seealso{\code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{varSelRFBoot}},
  \code{\link{varSelImpSpecRF}},
  \code{\link{randomVarImpsRFplot}}
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

randomVarImpsRFplot(rf.rvi, rf)
}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line
