\name{varSelRFBoot}
\alias{varSelRFBoot}
\title{Bootstrap the variable selection procedure in varSelRF}
\description{
  Use the bootstrap to estimate the prediction error rate (wuth the
  .632+ rule) and the
  stability of the variable selection procedure implemented in \code{\link{varSelRF}}.
}
\usage{
varSelRFBoot(xdata, Class, c.sd = 1,
             mtryFactor = 1, ntree = 5000, ntreeIterat = 2000,
             vars.drop.frac = 0.2, bootnumber = 200,
             whole.range = TRUE,
             recompute.var.imp = FALSE,
             usingCluster = TRUE,
             TheCluster = NULL, srf = NULL, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{Most arguments are the same as for \code{\link{varSelRFBoot}}.
  \item{xdata}{A data frame or matrix, with subjects/cases in rows and
    variables in columns. NAs not allowed.}
  \item{Class}{The dependent variable; must be a factor.}
  \item{c.sd}{The factor that multiplies the sd. to decide on stopping
    the tierations or choosing the final solution. See reference for details.}
  \item{mtryFactor}{The multiplication factor of
    \eqn{\sqrt{number.of.variables}} for the number of variables to use for
    the ntry argument of randomForest.}
  \item{ntree}{The number of trees to use for the first forest;
    same as ntree for randomForest.}
  \item{ntreeIterat}{The number of trees to use (ntree of randomForest)
    for all additional forests.}
%   \item{vars.drop.num}{The number of variables to exclude at each iteration.}
  \item{vars.drop.frac}{The fraction of variables, from those
  in the previous forest, to exclude at each iteration.}
  \item{whole.range}{If TRUE continue dropping variables until a forest
    with only two variables is built, and choose the best model from the
    complete series of models. If
    FALSE, stop the iterations if the current OOB error becomes larger
    than the initial OOB error (plus c.sd*OOB standard error) or
    if the current OOB error becoems larger than the
    previous OOB error (plus c.sd*OOB standard error).}
  \item{recompute.var.imp}{If TRUE recompute variable importances at
    each new iteration.}
  \item{bootnumber}{The number of bootstrap samples to draw.}
  \item{usingCluster}{If TRUE use a cluster to parallelize the calculations.}
  \item{TheCluster}{The name of the cluster, if one is used.}
  \item{srf}{An object of class varSelRF. If used, the ntree and
    mtryFactor parameters are taken from this object, not from the
    arguments to this function. If used, it allows to skip carrying out
    a first iteration to build the random forest to the complete,
    original data set.}
  \item{\dots}{Not used.}
}
\details{
  If a cluster is used for the calculations, it will be used for the
  embarrisingly parallelizable task of building as many random forests
  as bootstrap samples. 
}
\value{An object of class varSelRFBoot, which is a list with components:
  \item{number.of.bootsamples}{The number of bootstrap replicates.}
  \item{bootstrap.pred.error}{The .632+ estimate of the prediction
    error.}
  \item{leave.one.out.bootstrap}{The leave-one-out estimate of the error
    rate (used when computing the .632+ estimate).}
  \item{all.data.randomForest}{A random forest built from all the data,
    but after the variable selection. Thus, beware because the OOB error
    rate is severely biased down.}
  \item{all.data.vars}{The variables selected in the run with all the
    data.}
  \item{all.data.run}{An object of class varSelRF; the one obtained from
    a run of varSelRF on the original, complete, data set. See
    \code{\link{varSelRF}}.}
  \item{class.predictions}{The out-of-bag predictions from the
    bootstrap, of type "response".See
    \code{\link[randomForest]{predict.randomForest}}. This is an array, with
    dimensions number of cases by number of bootstrap replicates. }
  \item{prob.predictions}{The out-of-bag predictions from the bootstrap,
    of type "class probability". See
    \code{\link[randomForest]{predict.randomForest}}. This is a 3-way array; the last
    dimension is the bootstrap replication; for each bootstrap
    replication, the 2D array
    has dimensions case by number of classes, and each value is the
    probability of belonging to that class.}
  \item{number.of.vars}{A vector with the number of variables selected
    for each bootstrap sample.}
  \item{overlap}{The "overlap" between the variables selected from the
    run in original sample and the variables returned from a bootstrap
    sample.  Overlap between the sets of variables A and B is defined as
    \deqn{\frac{|variables.in.A \cap variables.in.B|}{\sqrt{|variables.in.A|
	 |variables.in.B|}}} or size (cardinality) of
       intersection between the two sets / sqrt(product of size of each
       set).}
   \item{all.vars.in.solutions}{A vector with all the genes selected in
    the runs on all the bootstrap samples. If the same gene is selected in several
    bootstrap runs, it appears multiple times in this vector.}
  \item{all.solutions}{Each solutions is a character vector with all
    the variables in a particular solution concatenated by a "+". Thus,
    all.solutions is a vector, with length equal to
    \code{number.of.bootsamples}, of the solution from each bootstrap
    run.}
  \item{Class}{The original class argument.}
  \item{allBootRuns}{A list of length \code{number.of.bootsamples}. Each
    component of this list is an element of class \code{\link{varSelRF}}
    and stores the results from the runs on each bootstrap sample.}
  
}
\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. and Alvarez de Andres,
    S. (2005) Variable selection from random forests: application to gene
    expression
    data. Tech. report.
    \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}

   Efron, B. & Tibshirani, R. J. (1997) Improvements on cross-validation: the .632+ bootstrap method.
    \emph{J. American Statistical Association}, \bold{92}, 548--560.  
    
 Svetnik, V., Liaw, A. , Tong, C & Wang, T. (2004) Application of
 Breiman's random forest to modeling structure-activity relationships of
 pharmaceutical molecules.  Pp. 334-343 in \emph{F. Roli, J. Kittler, and T. Windeatt}
 (eds.). \emph{Multiple Classier Systems, Fifth International Workshop}, MCS
 2004, Proceedings, 9-11 June 2004, Cagliari, Italy. Lecture Notes in
 Computer Science, vol. 3077.  Berlin: Springer.

}
\author{Ramon Diaz-Uriarte  \email{rdiaz02@gmail.com}}

\note{The out-of-bag predictions stored in \code{class.predictions} and
  \code{prob.predictions} are NOT the OOB votes from random
  forest itself for a given run. These are predictions from the
  out-of-bag samples for each  bootstrap replication. Thus, these are
  samples that have not been used at all in any of the variable selection
  procedures in the given bootstrap replication.}

\seealso{\code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{summary.varSelRFBoot}},
  \code{\link{plot.varSelRFBoot}},
}

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
