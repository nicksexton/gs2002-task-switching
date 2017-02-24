
rm (list=ls())

library(ggplot2) # for graphs
#library(pastecs) # for descriptive statistics
#library(reshape2) # for transform
#library (plyr)
                                        # library(lsr) # for etaSquared

imageDirectory <- file.path(Sys.getenv("HOME"), "Dropbox", "PhD", "Thesis", "replication")

# see run_block for octave code that creates this matrix. column format:
labels.data = c("response", "correct", "RT")

# files created by simulation_fixedblocks. each condition created as separate matrix
colour.neutral <- read.delim("fig3_colour_neutral.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
colour.congruent <- read.delim("fig3_colour_congruent.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
colour.incongruent <- read.delim("fig3_colour_incongruent.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
word.neutral <- read.delim("fig3_word_neutral.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
word.congruent <- read.delim("fig3_word_congruent.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
word.incongruent <- read.delim("fig3_word_incongruent.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)

# create some column headings
colour.neutral$congruency <- "neutral"
colour.neutral$task <- "colour"
word.neutral$congruency <- "neutral"
word.neutral$task <- "word"
colour.congruent$congruency <- "congruent"
colour.congruent$task <- "colour"
word.congruent$congruency <- "congruent"
word.congruent$task <- "word"
colour.incongruent$congruency <- "incongruent"
colour.incongruent$task <- "colour"
word.incongruent$congruency <- "incongruent"
word.incongruent$task <- "word"

fig3data <- rbind (colour.neutral, word.neutral, colour.congruent, word.congruent, colour.incongruent, word.incongruent)

    # change order to match gilbert & shallice
fig3data$congruency <- factor (fig3data$congruency, levels=c("neutral", "incongruent", "congruent"))


replication.fig3<- ggplot (fig3data,  aes(x=congruency, y=RT, group=task, colour=task))
replication.fig3 +
    # set the zoom on the graph without chucking away data (as setting limits would)
    coord_cartesian(ylim=c(25, 110)) +
    stat_summary(fun.y = mean, geom = "line", position = "dodge") +
    stat_summary(fun.y = mean, geom = "point") +
    stat_summary(fun.data = mean_cl_boot,
          geom = "errorbar",
#         position = position_dodge(width = 0.2),
          width = 0.2) + 
#      labs (x = "stimulus congruency", y = "Simulated RT (Cycles)") +
    ggtitle("Replication: Gilbert & Shallice (2002) Fig. 3") +
    theme_bw() + theme (legend.position="right") + 
    scale_colour_grey(start = 0.1, end = 0.4) +
    scale_y_continuous( name= "RT (model cycles)",
          sec.axis = sec_axis(~ . * 5.8 +  318, # transformed sec axis to perform regression equation
          name="simulated RT (ms)",
          breaks = c(450, 550, 650, 750, 850, 950), 
          labels = c("450", "550", "650", "750", "850", "950")))


imageFile <- file.path("~/Dropbox/PhD/Thesis/replication/", "gs_fig3.png")
ggsave(filename=imageFile, width = 200, height = 200, units = "mm")
