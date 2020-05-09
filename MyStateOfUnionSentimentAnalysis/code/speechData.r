
set.seed(123)
# Read and parse HTML file
doc.html.2020 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20200204.html',useInternal = TRUE)
doc.html.2009 = htmlTreeParse('http://stateoftheunion.onetwothree.net/texts/20090224.html',useInternal = TRUE)

# Extract all the paragraphs (HTML tag is p, starting at the root of the document). Unlist flattens the list to
# create a character vector.
doc.text.2020 = unlist(xpathApply(doc.html.2020, '//p', xmlValue))
doc.date.2020 = unlist(xpathApply(doc.html.2020, '//h3', xmlValue))

doc.text.2009 = unlist(xpathApply(doc.html.2009, '//p', xmlValue))
doc.date.2009 = unlist(xpathApply(doc.html.2009, '//h3', xmlValue))

# Replace all \n by spaces
doc.text.2020 = gsub('\\n', ' ', doc.text.2020)
doc.text.2009 = gsub('\\n', ' ', doc.text.2009)

# Join all the elements of the character vector into a single
# character string, separated by spaces
 doc.text.2020 = paste(doc.text.2020, collapse = ' ')
 doc.text.2009 = paste(doc.text.2009, collapse = ' ')

 gc()