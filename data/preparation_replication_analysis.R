
rm (list=ls())

library(ggplot2) # for graphs
#library(pastecs) # for descriptive statistics
library(reshape2) # for transform
#library (plyr)
library(tidyr)
                                        # library(lsr) # for etaSquared

imageDirectory <- file.path(Sys.getenv("HOME"), "Dropbox", "PhD", "Thesis", "replication")

# 
labels.data = c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12")


# label tasks for conditions we are comparing
idtask <- function (position) {
    if (as.numeric(position) == 5) {
        return ("Colour")
    } else if (as.numeric(position) == 9) {
        return ("Word")
    } else if (as.numeric(position) == 6 | as.numeric(position) == 7 | as.numeric(position) == 8){
        return ("Colour")
    } else if (as.numeric(position) == 10 | as.numeric(position) == 11 | as.numeric(position) == 12){
        return ("Word")
    }
      else {
          return ("First")
      }
}

idswitch <- function (position) {
    if (as.numeric(position) == 5) {
        return ("Switch")
    } else if (as.numeric(position) == 9) {
        return ("Switch")
    } else if (as.numeric(position) == 6 | as.numeric(position) == 7 | as.numeric(position) == 8){
        return ("Repeat")
    } else if (as.numeric(position) == 10 | as.numeric(position) == 11 | as.numeric(position) == 12){
        return ("Repeat")
    }
      else {
          return ("First")
      }
}

idgroup <- function (position) {
    if (as.numeric(position) == 5) {
        return ("Colour-Switch")
    } else if (as.numeric(position) == 9) {
        return ("Word-Switch")
    } else if (as.numeric(position) == 6 | as.numeric(position) == 7 | as.numeric(position) == 8){
        return ("Colour-Repeat")
    } else if (as.numeric(position) == 10 | as.numeric(position) == 11 | as.numeric(position) == 12){
        return ("Word-Repeat")
    }
      else {
          return ("First")
      }
}


## PREP INTERVAL 1
fig4data.001.rt <- read.delim("fig4_rts_prep_01.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.001.errors <- read.delim("fig4_errors_prep_01.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.001.rt$block <- seq(from=1, by=1, to=nrow(fig4data.001.rt))
fig4data.001.errors$block <- seq(from=1, by=1, to=nrow(fig4data.001.errors))
#
fig4data.001.rt.long <- melt(fig4data.001.rt, id.vars = "block",
                         variable.name = "trial.position",
                         value.name = "RT")
fig4data.001.errors.long <- melt(fig4data.001.errors,
                             id.vars = "block",
                             variable.name = "trial.position",
                             value.name = "error.rate")
#
#
fig4data.001.long <- fig4data.001.rt.long
fig4data.001.long$error.rate <- fig4data.001.errors.long$error.rate
fig4data.001.long$trial.position <- as.numeric(gsub('p', '', fig4data.001.long$trial.position))
fig4data.001.long$preparation <- 1


## PREP INTERVAL 26
fig4data.026.rt <- read.delim("fig4_rts_prep_26.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.026.errors <- read.delim("fig4_errors_prep_26.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.026.rt$block <- seq(from=1, by=1, to=nrow(fig4data.026.rt))
fig4data.026.errors$block <- seq(from=1, by=1, to=nrow(fig4data.026.errors))
#
fig4data.026.rt.long <- melt(fig4data.026.rt, id.vars = "block",
                         variable.name = "trial.position",
                         value.name = "RT")
fig4data.026.errors.long <- melt(fig4data.026.errors,
                             id.vars = "block",
                             variable.name = "trial.position",
                             value.name = "error.rate")
#
#
fig4data.026.long <- fig4data.026.rt.long
fig4data.026.long$error.rate <- fig4data.026.errors.long$error.rate
fig4data.026.long$trial.position <- as.numeric(gsub('p', '', fig4data.026.long$trial.position))
fig4data.026.long$preparation <- 26

## PREP INTERVAL 61
fig4data.061.rt <- read.delim("fig4_rts_prep_61.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.061.errors <- read.delim("fig4_errors_prep_61.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.061.rt$block <- seq(from=1, by=1, to=nrow(fig4data.061.rt))
fig4data.061.errors$block <- seq(from=1, by=1, to=nrow(fig4data.061.errors))
#
fig4data.061.rt.long <- melt(fig4data.061.rt, id.vars = "block",
                         variable.name = "trial.position",
                         value.name = "RT")
fig4data.061.errors.long <- melt(fig4data.061.errors,
                             id.vars = "block",
                             variable.name = "trial.position",
                             value.name = "error.rate")
#
#
fig4data.061.long <- fig4data.061.rt.long
fig4data.061.long$error.rate <- fig4data.061.errors.long$error.rate
fig4data.061.long$trial.position <- as.numeric(gsub('p', '', fig4data.061.long$trial.position))
fig4data.061.long$preparation <- 61

## PREP INTERVAL 150
fig4data.150.rt <- read.delim("fig4_rts_prep_150.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.150.errors <- read.delim("fig4_errors_prep_150.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.150.rt$block <- seq(from=1, by=1, to=nrow(fig4data.150.rt))
fig4data.150.errors$block <- seq(from=1, by=1, to=nrow(fig4data.150.errors))
#
fig4data.150.rt.long <- melt(fig4data.150.rt, id.vars = "block",
                         variable.name = "trial.position",
                         value.name = "RT")
fig4data.150.errors.long <- melt(fig4data.150.errors,
                             id.vars = "block",
                             variable.name = "trial.position",
                             value.name = "error.rate")
#
#
fig4data.150.long <- fig4data.150.rt.long
fig4data.150.long$error.rate <- fig4data.150.errors.long$error.rate
fig4data.150.long$trial.position <- as.numeric(gsub('p', '', fig4data.150.long$trial.position))
fig4data.150.long$preparation <- 150


fig4data.long <- rbind (fig4data.001.long,
                        fig4data.026.long,
                        fig4data.061.long,
                        fig4data.150.long)

                                        # convert p1, p2 etc. into numeric position

# assign task (1, 2) for drawing group lines to match the figure
fig4data.long$condition.task <- sapply (fig4data.long$trial.position, idtask)
fig4data.long$condition.switch <- sapply (fig4data.long$trial.position, idswitch)
fig4data.long$condition.group <- sapply (fig4data.long$trial.position, idgroup)

# now get rid of First trials
fig4data <- subset(fig4data.long, fig4data.long$condition.task != "First")

                                        # split condition

    
replication.fig4<- ggplot (fig4data,  aes(x=preparation, y=RT, group=condition.group, colour=condition.task, linetype=condition.switch))
replication.fig4 +
    coord_cartesian(ylim=c(20, 120)) +
    stat_summary(fun.y = mean, geom = "line", position = "dodge") +
    stat_summary(fun.y = mean, geom = "point") +
        stat_summary(fun.data = mean_cl_boot,
                     geom = "errorbar",
                     # position = position_dodge(width = 0.2),
                     width = 0.2) + 
    labs (x = "Preparation Interval (cycles)", y = "Simulated RT (Cycles)") +
    ggtitle("Replication: Gilbert & Shallice (2002) Fig. 8") +
    theme_bw() + theme (legend.position="bottom") + 
        scale_colour_grey(start = 0.1, end = 0.4) +
            theme_bw() + theme (legend.position="bottom") + 
            ## scale_x_continuous (name = "trial position",
            ##                     breaks = c(1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12),
            ##                     labels = c("1", "2", "3", "4", "5", "6", "7", "8", "9", "10", "11", "12")) +
    scale_y_continuous( name= "RT (model cycles)",
       sec.axis = sec_axis(~ . * 5.8 +  318, # transformed sec axis to perform regression equation
       name="simulated RT (ms)",
       breaks = c(400, 500, 600, 700, 800, 900, 1000, 1100), 
       labels = c("400", "500", "600", "700", "800", "900", "1000", "1100")))


imageFile <- file.path("~/Dropbox/PhD/Thesis/replication/", "fig8_replicated_rt.png")
ggsave(filename=imageFile, width = 120, height = 80, units = "mm")


replication.fig4.error<- ggplot (fig4data,  aes(x=preparation, y=1-error.rate, group=condition.group, colour=condition.task, linetype=condition.switch))
replication.fig4.error +
    coord_cartesian(ylim=c(0, 0.03)) +
    stat_summary(fun.y = mean, geom = "line", position = "dodge") +
    stat_summary(fun.y = mean, geom = "point") +
        stat_summary(fun.data = mean_cl_boot,
                     geom = "errorbar",
                     # position = position_dodge(width = 0.2),
                     width = 0.2) + 
    labs (x = "Preparation Interval (cycles)", y = "Error Rate") +
    ggtitle("Replication: Gilbert & Shallice (2002) Fig. 8") +
    theme_bw() + theme (legend.position="bottom") + 
        scale_colour_grey(start = 0.1, end = 0.4) +
            theme_bw() + theme (legend.position="bottom")




imageFile <- file.path("~/Dropbox/PhD/Thesis/replication/", "fig8_replicated_errors.png")
ggsave(filename=imageFile, width = 120, height = 80, units = "mm")
