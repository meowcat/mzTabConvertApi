library(rJava)

.jinit()
rJava::.jaddClassPath(fs::path("jmztabm-cli-1.0.6.jar"))


mzTabToJson <- function(file) {

  parser <- J("de.isas.mztab2.io.MzTabFileParser")
  file <- new(J("java.io.File"), fs::path("MouseLiver_negative.mzTab") %>% fs::path_abs() %>% as.character())
  os <- new(J("java.io.ByteArrayOutputStream"))
  parser <- new(J("de.isas.mztab2.io.MzTabFileParser"), file)
  
  parser$parse(os)
  errors <- parser$getErrorList()
  mztab <- parser$getMZTabFile()
  
  filenameOut <- fs:::file_temp()
  fileOut <- new(J("java.io.File"), 
                 filenameOut %>% fs::path_abs() %>% as.character())
  
  
  sf <- J("com.fasterxml.jackson.databind.SerializationFeature")
  om <- new(J("com.fasterxml.jackson.databind.ObjectMapper"))
  om <- om$enable(sf$INDENT_OUTPUT)
  om$writeValue(fileOut, mztab)
  
  return(filenameOut)
}






