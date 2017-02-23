
rm (list=ls())

library(ggplot2) # for graphs
#library(pastecs) # for descriptive statistics
#library(reshape2) # for transform
#library (plyr)
                                        # library(lsr) # for etaSquared

imageDirectory <- file.path(Sys.getenv("HOME"), "Dropbox", "PhD", "Thesis", "replication")

# 
labels.data = c("response", "correct", "RT")

fig4data.rt <- read.delim("fig4_rts.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.errors <- read.delim("fig4_errors.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
