#Getting Started with R, RStudio, and ggvis

# Tutorial created by Leslie McIntosh, PhD, MPH  dataschemata.com

# Once this is completed, you should only need to go to the 'ggvis Tutorial'
# Install R 
# If you are new to installing programs, use one of the links in the top box labeled
# "Download and Install R"
http://cran.wustl.edu/


#Intall RStudio
# Go to the link and download RStudio
https://www.rstudio.com/ide/

###################################################################################
# Notes

# Comments are preceded by a '#', while code that should be run is not
#        , run the code (not commented out)
# If you need a basic introduction to R, check out 
# http://cran.r-project.org/doc/manuals/R-intro.html

##################################################################################

# Install ggvis
#ggvis is not yet (24 May 2014) available on CRAN. So it needs to be installed from 
#GitHub using the following code.

install.packages("devtools")
devtools::install_github(c("rstudio/shiny", "rstudio/ggvis"),
                         build_vignettes = FALSE)

