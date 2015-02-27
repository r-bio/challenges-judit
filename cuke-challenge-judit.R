#download datasets
download.file("http://r-bio.github.io/data/holothuriidae-specimens.csv", "data/holothuriidae-specimens.csv")
download.file("http://r-bio.github.io/data/holothuriidae-nomina-valid.csv", "data/holothuriidae-nomina-valid.csv")
#read data
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
morethan2005 <- table(hol$dwc.year[hol$dwc.year>2005])   ### you can sum the elements after subsetting 
sum(morethan2005) ## the answer is 1472
length(hol$dwc.year)    ##2984
1472/2984   ###.3280831 was your original answer   ##There must be a better way to do this
prop.col <- spec.2006.2014/nrow(hol) 
prop.col*100 ## ~49.3%
#4)Use the function nzchar to answer:
#How many specimens do not have the information for class listed?
table(nzchar(hol$dwc.class)) #50 are missing class
#For the specimens where the information is missing, replace it with the information for their (again, they should all be "Holothuroidea").
hol$dwc.class <- "Holothuroidea"
#5)Using the nom data frame, and the columns Subgenus.current and Genus.current, 
#which of the genera listed has/have subgenera?
nom$Genus.current[(table(nzchar(nom$Subgenus.current)))] #"Holothuria"
#6)With the function paste(), 
#create a new column (called genus_species) that 
#contains the genus (column dwc.genus) and species names (column dwc.specificEpithet) 
#for the hol data frame.
genus_species <- paste(hol$dwc.genus, hol$dwc.specificEpithet, sep="_")
hol <- cbind(hol, genus_species)
#Do the same thing with the nom data frame 
#(using the columns Genus.current and species.current).
genus_species_current <- paste(nom$Genus.current, nom$species.current, sep="_")
nom <- cbind(nom, genus_species=genus_species_current)
#Use merge() to combine hol and nom 
all.data <- merge(hol, nom, all.x=TRUE)
#Create a data frame that contains the information for the specimens identified 
#with an invalid species name (content of the column Status is not NA)? 
#(hint: specimens identified only with a genus name 
#shouldn't be included in this count.)
Status_noNA <- all.data[!is.na(all.data$Status),]
#Select only the columns: 
#idigbio.uuid, 11
#dwc.genus, 24
#dwc.specificEpithet, 21
#dwc.institutionCode, 8
#dwc.catalogNumber 17 from this data frame and export the data as a CSV file 
#(using the function write.csv) named holothuriidae-invalid.csv
write.csv(Status_noNA[,c(11, 24,21, 8, 17)], file="data/holothuriidae-invalid.csv")
