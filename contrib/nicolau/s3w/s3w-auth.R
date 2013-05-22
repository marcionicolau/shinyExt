getpgcon <- function(dbname=Sys.info()[["user"]], user=Sys.info()[["user"]],pwd="") {
  suppressPackageStartupMessages(require(RPostgreSQL))
  
  if(user == "root") return(NULL)
  if((dbname != user) & user != "nicolau") return(NULL)  
  hostname <- ifelse(Sys.info()[["nodename"]] == "crem", "", "rstudio.cnpt.embrapa.br")	  
  idx <- which(sapply(dbListConnections(PostgreSQL()),
                      function(x) dbGetInfo(x)[['dbname']]) == dbname)
  
  if(length(dbGetInfo(PostgreSQL())[['connectionIds']]) == 0 || length(idx) == 0) {
    con <- dbConnect(PostgreSQL(), dbname = dbname, user = user, host = hostname, password=pwd)
  } else {
    con <- dbGetInfo(PostgreSQL())[['connectionIds']][[idx]]
  }
  
  if(!isPostgresqlIdCurrent(con)) {
    lapply(dbListConnections(PostgreSQL()), function(x) dbDisconnect(x))
    con <- dbConnect(PostgreSQL(), dbname = dbname, user = user, host = hostname, password=pwd)
  }
  
  print(sprintf("User '%s' connected to dbname '%s' with pid %d", user, dbname,
                slot(PostgreSQL(),"Id")))
  
  return(con)
}

