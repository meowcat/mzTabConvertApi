
#* @post convert
#* @parse parser_text
#* @serializer contentType list(type="application/json")
function(req) {
  tempFile <- fs::file_temp()
  print(req$body)
  writeBin(req$body, tempFile)
  res <- mzTabToJson(tempFile)
  return(read_file(res))
}