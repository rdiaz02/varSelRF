\name{basicClusterInit}
\alias{basicClusterInit}
%- Also NEED an '\alias' for EACH other topic documented here.
\title{Initialize a cluster of workstations}
\description{
  Use Snow to initialize a cluster of workstations, with either MPI or
  PVM as the type of cluster, setup the random number generator, and
  load randomForest library in all the nodes. 
}
\usage{
basicClusterInit(clusterNumberNodes = 1, nameCluster = "TheCluster",
                 typeCluster = "MPI")
}
%- maybe also 'usage' for other objects documented here.
\arguments{
  \item{clusterNumberNodes}{The number of nodes in the cluster. If you
    only have 1 CPU you can pass a 1 here.}
  \item{nameCluster}{The name you want to give to the newly created cluster.}
  \item{typeCluster}{Either "MPI" or "PVM".}
}
\details{
  This function is a wrapper to \code{\link[snow]{makeCluster}} with a little
  bit of additional code (load randomForest and varSelRF in all the
  nodes and initialize the random number generator). It can be used to
  initialize a cluster of workstations. It
  will be called by several other functions in the package if you ask
  that computations be done using a cluster and you do not specify a
  cluster name. In this case, a "dummy" cluster of only one node will be
  created.
  
  For this function to run you MUST have installed the following Rpackages: 
  snow, Rmpi or rpvm, and
rsprng. You might also need to start your cluster environment (e.g.,
"lamboot whatever.the.name.of.your.def.file" from a shell).
}
\value{This function is used to create a
  cluster. An object with name "nameCluster" with a reference to the
  cluster will be created. See \code{\link[snow]{makeCluster}} for details.
}
\references{\url{http://ligarto.org/rdiaz/Papers/rfVS/randomForestVarSel.html}}
\author{Ramon Diaz-Uriarte \email{rdiaz@ligarto.org}}
\note{ It is a lot better if you specify all arguments: if you really
  have a netwrok of workstations you can use, you will need to specify
  the number of nodes and the correct type of cluster (MPI or PVM). If
  you don't have a network of workstations then nothing is gained (and a
  little bit lost) from asking  the functions in this package to use the
  cluster, and you should specify "usingCluster = FALSE".

  I have only tested the workings of this and similar functions, and the
  workings of the package, extensively with MPI, not PVM, though I'd
  expect things to work equally well with both PVM and MPI.

  Instead of using the rsrpng library, you could use the rlecuyer package. Changing
  the code should be straightfoward (see \code{\link[snow]{clusterSetupRNG}}).
}


\seealso{ \code{\link[snow]{makeCluster}}, \code{\link{randomVarImpsRF},
    \code{\link{varSelRFBoot}}}
  }
\examples{
## Create a simple cluster with only one slave node. Will work even
## in 1 CPU cases if you have the required packages.
\dontrun{
basicClusterInit(clusterNumberNodes = 1,
                 nameCluster = "TheCluster",
                 typeCluster = "MPI") 
}
}
\keyword{programming}% at least one, from doc/KEYWORDS

