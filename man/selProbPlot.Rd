\name{selProbPlot}
\alias{selProbPlot}
\title{Selection probability plot for variable importance from random forests}
\description{
  Plot, for the top ranked \eqn{k} variables from the original sample, the
  probability that each of these variables is included among the top
  ranked \eqn{k} genes from the bootstrap samples. 
}
\usage{
selProbPlot(object, k = c(20, 100),
            color = TRUE,
            legend = FALSE,
            xlegend = 68,
            ylegend = 0.93,
            cexlegend = 1.4,
            main = NULL,
            xlab = "Rank of gene",
            ylab = "Selection probability",
            pch = 19, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{An object of class varSelRFBoot such as returned by the
  \code{\link{varSelRFBoot}} function.}
  \item{k}{A two-component vector with the \eqn{k}-th upper variables for
    which you want the plots. }
  \item{color}{If TRUE a color plot; if FALSE, black and white.}
  \item{legend}{If TRUE, show a legend.}
  \item{xlegend}{The x-coordinate for the legend.}
  \item{ylegend}{The y-coordinate for the legend.}
  \item{cexlegend}{The \code{cex} argument for the legend.}
  \item{main}{\code{main} for the plot.}
  \item{xlab}{\code{xlab} for the plot.}
  \item{ylab}{\code{ylab} for the plot.}
  \item{pch}{\code{pch} for the plot.}
  \item{\dots}{Additional arguments to plot.}
}
\details{
  \cite{Pepe et al., 2003} suggested the use of selection probability
  plots to evaluate the stability and confidence on our selection of
  "relevant genes." This paper also presents several more sophisticated
  ideas not implemented here.

}
\value{
  Used for its side effects of producing a plot. In a single plot show
  the "selection probability plot" for the upper
  (largest variable importance) \code{kt}th variables. By default, show
  the upper 20 and the upper 100
  colored blue and red respectively.
}
\references{
  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. , Alvarez de Andres,
  S. (2005) Variable selection from random forests: application to gene
  expression
  data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}

  Pepe, M. S., Longton, G., Anderson, G. L. & Schummer, M. (2003) Selecting differentially expressed genes from microarray experiments.
    \emph{Biometrics}, \bold{59}, 133--142. 
  
 Svetnik, V., Liaw, A. , Tong, C & Wang, T. (2004) Application of
 Breiman's random forest to modeling structure-activity relationships of
 pharmaceutical molecules.  Pp. 334-343 in \emph{F. Roli, J. Kittler, and T. Windeatt}
 (eds.). \emph{Multiple Classier Systems, Fifth International Workshop}, MCS
 2004, Proceedings, 9-11 June 2004, Cagliari, Italy. Lecture Notes in
 Computer Science, vol. 3077.  Berlin: Springer.
}

\author{Ramon Diaz-Uriarte \email{rdiaz@ligarto.org}}

\note{This function is in very rudimentary shape and could be used for
  more general types of data. I wrote specifically to produce Fig.\ 4 of
  the paper.}

\seealso{
  \code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{varSelRFBoot}},
  \code{\link{randomVarImpsRFplot}},
  \code{\link{randomVarImpsRF}}
}



\examples{
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
selProbPlot(rf.vsb, k = c(5, 10), legend = TRUE,
            xlegend = 8, ylegend = 0.8)

}
\keyword{tree}% at least one, from doc/KEYWORDS
\keyword{classif}% __ONLY ONE__ keyword per line