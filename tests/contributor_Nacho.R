datasets <- c("57e2b30b99592d0300020b5a", "57e2de98920edd03004b71e5")

#contributors <- function(cnx, datasets) {
offdS <- resource(cnx, "dataSets")
df_dataSets = query(offdS, todataframe = FALSE)
df_dataSets[[2]]
#credit = NULL :(
pathi <- df_dataSets[[2]]$`_links`$references[[1]]$href
queryInternal(cnx, pathi) #HERE THEY ARE!
#but is it practical? It means one query per dataSet.
#I guess we may query on dataSets by name using query, but we would need an %in% operator,
#rather than an == operator that forces as many queries as items to retireve,
#alternativelly, we need to fetch them all and filter.
#this needs to be automayted.

#Y veo que contributors tiene más datos :( (Country,  Organization, Url, Email)
#que se podrian pillar recursivamente
off <- resource(cnx, "contributors")
df_contributors = query(off, todataframe = TRUE)
#}
