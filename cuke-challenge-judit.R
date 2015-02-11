download.file("http://r-bio.github.io/data/holothuriidae-specimens.csv", "data/holothuriidae-specimens.csv")
download.file("http://r-bio.github.io/data/holothuriidae-nomina-valid.csv", "data/holothuriidae-nomina-valid.csv")
hol <- read.csv(file="data/holothuriidae-specimens.csv", stringsAsFactors = FALSE)
nom <- read.csv(file = "data/holothuriidae-nomina-valid.csv", stringsAsFactors = FALSE)
#1)How many specimens are included in the data frame hol?
nrow(hol)  ### 2984
#2) The column dwc.institutionCode in the hol data frame lists the museum where the specimens are housed:
#How many institutions house specimens?
table(hol$dwc.institutionCode) ### 4 institutions
#Draw a bar plot that shows the contribution of each institution
barplot(table(hol$dwc.institutionCode))
#3)The column dwc.year indicates when the specimen was collected:
#When was the oldest specimen included in this data frame collected ? (hint: It was not in year 1)
year.count <- table(hol$dwc.year) ### 1902 is oldest
#What proportion of the specimens in this data frame were collected between the years 2006 and 2014 (included)?
spec.2006.2014 <- sum(year.count[45:53]) ##speciments between 2006-2014: 1472
prop.col <- spec.2006.2014/nrow(hol) ## ~49.3%
