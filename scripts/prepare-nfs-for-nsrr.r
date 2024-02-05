ver="0.1.0.pre1"

library(readxl)
library(dplyr)


setwd("//rfawin.partners.org/bwh-sleepepi-nsrr-staging/20240130-chee-need-for-sleep/nsrr-prep")
data<-readxl::read_excel("_source/Demographics.xlsx", sheet = "Screening_NFS12345")

# change the variable names to lower case
colnames(data)<-tolower(colnames(data))
colnames(data)[2]<-"sex"


#Harmonized dataset
harmonized_data<-data[,c("subj_id", "sex","age","bmi")]%>%
	dplyr::mutate(nsrr_age=age,
				  nsrr_bmi=bmi,
				  nsrrid=subj_id,
				  nsrr_sex=dplyr::case_when(
				  sex==1 ~ "female",
				  sex==0 ~ "male",
				  TRUE ~ "not reported"
				))%>%
	select(nsrrid,nsrr_age,nsrr_sex,nsrr_bmi)	
	
	
write.csv(data, file=paste0("_releases/",ver,"/nfs-dataset-",ver,".csv",sep=""), row.names = F, na="")
write.csv(harmonized_data, paste0("_releases/",ver,"/nfs-harmonized-dataset-",ver,".csv",sep=""), row.names = F, na="")
