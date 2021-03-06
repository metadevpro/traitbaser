% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/query.R
\name{query}
\alias{query}
\title{Makes a query}
\usage{
query(resource, limit = -1, skip = 0, conditions = NULL, sort,
  selectFields, distinct)
}
\arguments{
\item{resource}{The resource to query.}

\item{limit}{Limit the number of data rows to retrieve. If no specified, no limit applies.}

\item{skip}{Skip the first N data rows to retrieve. If no specified, no skip=0 is assumed.}

\item{conditions}{A set of conditions to constraint the query on the server side. Use the function \code{buildCondition()} to create the conditions.0}

\item{sort}{Criteria to sort the data returned. (Not yet implemented)}

\item{selectFields}{Select and filter the fields to retrieve (columns). (Not yet implemented)}

\item{distinct}{Provides a distict criteria. (Not yet implemented)}
}
\value{
Returns a dataframe with the returned data.
}
\description{
Executes a query on the server backend and returns data.
}
\examples{
\donttest{
cnx <- connect('http://www.traitbase.info')
off <- resource(cnx, 'species')

res <- query(off)
query(off, conditions=buildCondition('species', '==', 'Bombus')  )
query(off, limit=2, skip=0)
query(off, limit=2, skip=2)
}
}
