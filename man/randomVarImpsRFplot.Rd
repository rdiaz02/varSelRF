\name{randomVarImpsRFplot}
\alias{randomVarImpsRFplot}
\title{Plot random random variable importances}
\description{
  Plot variable importances from random permutations of class labels and
  the variable importances from the original data set.
}
\usage{
randomVarImpsRFplot(randomImportances, forest,
                    whichImp = "impsUnscaled", nvars = NULL,
                    show.var.names = FALSE, vars.highlight = NULL,
                    main = NULL, screeRandom = TRUE,
                    lwdBlack = 1.5,
                    lwdRed = 2,
                    lwdLightblue = 1,
                    cexPoint = 1,
                    overlayTrue = FALSE,
                    xlab = NULL,
                    ylab = NULL, ...)
}
\arguments{
  \item{randomImportances}{A list with a structure such as the object
    return by \code{\link{randomVarImpsRF}}}.
  \item{forest}{A random forest fitted to the original data. This forest
  must have been fitted with \code{importances = TRUE}.}
  \item{whichImp}{The importance measue to use. One (only one) of
  \code{impsUnscaled},
    \code{impsScaled}, \code{impsGini}, that correspond, respectively, to
    the (unscaled) mean decrease in accuracy, the scaled mean decrease
    in accuracy, and the Gini index.  See below and
\code{\link[randomForest]{randomForest}},
    \code{importance} and the references for further explanations of the
    measures of variable importance. }
  \item{nvars}{If NULL will show the plot for the complete range of
    variables. If an integer, will plot only the most important nvars.}
  \item{show.var.names}{If TRUE, show the variable names in the
    plot. Unless you are plotting few variables, it probably won't be of
  any use.}
  \item{vars.highlight}{A vector indicating the variables to highlight
    in the plot with a vertical blue segment. You need to pass here a
    vector of variable names, not variable positions.}
  \item{main}{The title for the plot.}
  \item{screeRandom}{If TRUE, order all the variable importances (i.e.,
    those from both the original and the permuted class labels data
    sets) from
    largest to smallest before plotting. The plot will thus resemble a
    usual "scree plot". }
  \item{lwdBlack}{The width of the line to use for the importances from
    the original data set.}
  \item{lwdRed}{ The width of the line to use for the average of the
    importances for the permuted data sets. }
  \item{lwdLightblue}{ The width of the line for the importances for the
    individual permuted data sets.}
  \item{cexPoint}{ \code{cex} argument for the points for the
    importances from the original data set.}
  \item{overlayTrue}{If TRUE, the variable importance from the
    original data set will be plotted last, so
    you can see it even if buried in the middle of many gree lines; can
    be of help when the plot does not allow you to see the black line.}
  \item{xlab}{The title for the x-axis (see \code{xlab}).}
  \item{ylab}{The title for the y-axis (see \code{ylab}).}
  \item{...}{Additional arguments to plot.}
}
\value{
  Only used for its side effects of producing plots. In particular, you
  will see lines of three colors:
   \item{black}{Connects the variable importances from the original
    simulated data. }
  \item{green}{Connect the variable
    importances from the data sets with permuted class labels; there
    will be as many lines as \code{numrandom} where used when
    \code{\link{randomVarImpsRF}} was called to obtain the random
    importances.}
  \item{red}{Connects the average of the importances from the permuted
    data sets.}
   Additionally, if you used a valid set of values for
  \code{vars.highlight}, these will be shown with a vertical blue
  segment.
   
}
\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. , Alvarez de Andres,
  S. (2005) Variable selection from random forests: application to gene
  expression
  data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}
  
  Friedman, J., Meulman, J. (2005) Clustering objects on subsets of attributes (with discussion).
  \emph{J. Royal Statistical Society, Series B}, \bold{66}, 815--850. 
}
\author{Ramon Diaz-Uriarte \email{rdiaz02@gmail.com}}
\note{These plots resemble the scree plots commonly used with principal
  component analysis, and the actual choice of colors was taken from the
  importance spectrum plots of \cite{Friedman \& Meulman}.}

\seealso{
  \code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{varSelRFBoot}},
  \code{\link{varSelImpSpecRF}},
  \code{\link{randomVarImpsRF}}
}
\examples{

x <- matrix(rnorm(45 * 30), ncol = 30)
x[1:20, 1:2] <- x[1:20, 1:2] + 2
colnames(x) <- paste0("V", seq.int(ncol(x)))
cl <- factor(c(rep("A", 20), rep("B", 25)))  

rf <- randomForest(x, cl, ntree = 200, importance = TRUE)
rf.rvi <- randomVarImpsRF(x, cl, 
                          rf, 
                          numrandom = 20, 
                          usingCluster = FALSE) 

randomVarImpsRFplot(rf.rvi, rf)
op <- par(las = 2)
randomVarImpsRFplot(rf.rvi, rf, show.var.names = TRUE)
par(op)


\dontrun{
## identical, but using a cluster
## make a small cluster, for the sake of illustration
psockCL <- makeCluster(2, "PSOCK")
clusterSetRNGStream(psockCL, iseed = 789)
clusterEvalQ(psockCL, library(varSelRF))

rf.rvi <- randomVarImpsRF(x, cl, 
                          rf, 
                          numrandom = 20, 
                          usingCluster = TRUE,
                          TheCluster = psockCL) 

randomVarImpsRFplot(rf.rvi, rf)
stopCluster(psockCL)
}

}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line
