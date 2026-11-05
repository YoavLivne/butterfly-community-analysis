
#First make sure that You have all the following packages installed and loaded:

library(dismo)#This is an old species distribution modeling package we will use for the environmental envalope model
library(sdm)#This is the new species distribution modeling package we will use
installAll()#This in a function from the sdm package which will download all the packages which sdm dephands on
library(raster)#this is for spatial data (in this script for the environmental data)
library(rgdal)
library(ggmap)#mapping
library(maptools)#mapping
library(maps)#mapping
installAll()

library(rworldmap);library(rgdal);library(raster);library(plotfunctions);library(bRacatus);library(rgbif)

bioclim <- getData("worldclim", var="bio", res=10)

#################################We will start with getting the data on the species we selected
#In this case a fish- Diplodus sargus
sp <- "telmessia"#species name (species only)
gn <- "maniola"#Genus name
#next we want to get observations from gbif
sp.occr<-gbif(genus=gn ,species=sp)
#now few lines of data cleaning
sp.occr<-subset(sp.occr,!is.na(lon) & !is.na(lat))#only observation with lat and lon
# 2 next lines for removing duplicates
dups <- duplicated(cbind(sp.occr$lon,sp.occr$lat))
sp.occr <- sp.occr[!dups, ]

# we will now create data frame with only the location (lat,lon) of the observation from gbif (there is a lot of unnecessary datainformation in what we downloaded)
sp.occr_loc <- data.frame(lon=sp.occr$lon,lat=sp.occr$lat)
#look at the data- it is simply the lat and lon of the location where the species was observed
sp.occr_loc
#we want to limit to an area of the Mediterranean and east Atlantic Ocean
sp.occr_loc <- subset(sp.occr_loc,lat>=5 & lat<=40)
sp.occr_loc <- subset(sp.occr_loc,lon>=23 & lon<=85)

#we now need to make the data in a format useable for the SDM functions
#the next line crates a data frame with one column which every line is the number '1'.  This will indicate that the species is present in the location (later we will use also '0' for absent)
sp_name <- data.frame(Occurrence=rep(1,nrow(sp.occr_loc)))
#next we create the full species location data using two elements:
#sp.occr_loc- the lat and lon we created earlier
#sp_name-the data frame of repeating 1s indicating that the species is present in these locations
species_t <- SpatialPointsDataFrame(coords=sp.occr_loc,data=sp_name)


preds_t <- stack(bioclim[[12]],bioclim[[1]])
# lets limit the data to Mediterranean and east Atlantic
newext <- c(23,85,5,40)#this is the range of cordinates we would like to use
preds_t_med <- crop(preds_t, newext)#croping the raster to the part that we want
plot(preds_t_med)#ploting the environmental data


#Now we can look at the species location in relation to the environmental conditions
#lets see occurance with mean SST
plot(preds_t_med[[1]])#mean SST is the first element in the raster stack
plot(species_t,add=T)#adding species locations



################We move to the Species Distribution modeling
# first we will use our data which is 'present only'
#we can use the climatic envelope approach  to model the expected species distribution
#the function we will use is 'bioclim' from 'dismo'
t_bioclim <- bioclim(preds_t_med,species_t)#running the model useing species location ('species_t') and environmental data ('preds_t_med')
pred.full <- predict(t_bioclim, preds_t_med)#predicting where the species is likely to appear using the model we just created ('t_bioclim') and the environmental data ('preds_t_med')
plot(pred.full)#plotting the prediction
points(species_t, col="red") + title("Colotis fausta SDM - Present only")#adding the location where the species was observed

#we will now move to other SDM methods which requires 'present-absent' data
#fist we will have to create pseudo absent data. There are many ways to do this- you can look at the paper we talked about to see what is recommended (there is no one simple answer...)

#We will just sample point from the coordinates of the environmental data
#we know that it is all at sea and we are randomly sampling from the range of environmental conditions
#again we will need to move between formats to do this
m <- data.frame( rasterToPoints( preds_t_med[[1]] ) )#create data frame from the first layer of environmental data 
sp.absent <- m[sample(nrow(m), 1000), 1:2]#select randomaly 1000 points 
colnames(sp.absent)=c("lon","lat")#name the data frame's columns

#now we create data frame with both the present and pseudo absent
#'sp.occr_loc'- gbif data
#'sp.absent'- pseudo absent data we just created
sp_data_psd=rbind(sp.occr_loc,sp.absent)


#as before we now need to create format we can work with in the SDM
sp_name_psd <- data.frame(Occurrence=c(rep(1,nrow(sp.occr_loc)),rep(0,nrow(sp.absent))))# present (1) or absent (0)
species_t_psd <- SpatialPointsDataFrame(coords=sp_data_psd,data=sp_name_psd)#the full data we will need

##########We can now generate the model
#first line is for the 'sdm' package to prepare the data for the modeling function 'sdmData'- arguments used:
#formula- here we will set the model we what to use. in the next example we will use: formula=Occurrence~.
#this means we want to generate models which predicts species present or absent using all the environmental data we have
#you can use something like- 'formula=Occurrence~sstmean+salinity' to use a subset of the predictors

#additional arguments are-species observation ('species_t_psd') and the predictors ('preds_t_med')
d <- sdmData(formula=Occurrence~., train=species_t_psd, predictors=preds_t_med)

#Now we run the models
#we will use here 3 model fitting algorithms: 'glm' 'gam' and 'brt' 
SDMmodel <- sdm(Occurrence~.,data=d,methods=c('glm','gam'),replicatin='sub',test.percent=30,n=1)
#look at the output- you can find information on different fitting criteria
SDMmodel
#the first one is 'AUC' area under the curve which we talked about. we can plot this by:
roc(SDMmodel)
#now we can make predictions:
p1 <- predict(SDMmodel,newdata=preds_t_med,overwrite=TRUE)
#and plot predictions:
plot(p1)

