\name{summary.varSelRFBoot}
\alias{summary.varSelRFBoot}
\title{Summary of a varSelRFBoot object}
\description{
  Returns error rate and stability measures of a varSelRFBoot object.
}
\usage{
summary.varSelRFBoot(object, return.model.freqs = FALSE,
                     return.class.probs = TRUE,
                     return.var.freqs.b.models = TRUE, ...)
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{object}{An object of class varSelRFBoot, as returned from
  \code{\link{varSelRFBoot}}.}
  \item{return.model.freqs}{If TRUE return a table with the frequencies
    of the final "models" (sets of selected variables) over all
    bootstrap replications.}
  \item{return.class.probs}{If TRUE return average class probabilities
    for each sample based on the out-of-bag probabilites (see
    \code{\link{varSelRFBoot}}, the \code{prob.predictions} component).}
  \item{return.var.freqs.b.models}{If TRUE return the frequencies of all
    variables selected from the bootstrap replicates.}
  \item{\dots}{Not used.}
}
\value{
  If \code{return.class.probs = TRUE} a matrix with the average class
  probabilities  for each sample based on the out-of-bag probabilites. 

  Regardless of that setting, print out several summaries:
%  \begin{itemize}
  \item{Summaries related to the "simplified" random forest on the original
    data}{Such as the number and identity of the variables selected.}
  \item{Summaries related to the error rate estimate}{Such as the .632+
    estimate, and some of its components}
  \item{Summaries related to the stability (uniqueness) of the results
    obtained}{Such as the frequency of the selected variables in the
    bootstrap runs, the frequency of the selected variables in the
    boostrap runs that are also among the variables selected from the
    complete run, the overlap of the bootstrap forests with the forest
    from the original data set (see \code{\link{varSelRF}} for the
    definition of overlap), and (optionally) the frequency of the
    "models", where a
    model is the set of variables selected in any particular run.}
%    \end{itemize}
    
}
\references{

  Breiman, L. (2001) Random forests.
  \emph{Machine Learning}, \bold{45}, 5--32.

  Diaz-Uriarte, R. and Alvarez de Andres,
    S. (2005) Variable selection from random forests: application to gene
    expression
    data. Tech. report. \url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}

   Efron, B. & Tibshirani, R. J. (1997) Improvements on cross-validation: the .632+ bootstrap method.
    \emph{J. American Statistical Association}, \bold{92}, 548--560.  
    

}
\author{Ramon Diaz-Uriarte  \email{rdiaz@ligarto.org}}

\seealso{\code{\link[randomForest]{randomForest}},
  \code{\link{varSelRF}},
  \code{\link{varSelRFBoot}},
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
