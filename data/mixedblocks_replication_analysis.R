
rm (list=ls())

library(ggplot2) # for graphs
#library(pastecs) # for descriptive statistics
library(reshape2) # for transform
#library (plyr)
                                        # library(lsr) # for etaSquared

imageDirectory <- file.path(Sys.getenv("HOME"), "Dropbox", "PhD", "Thesis", "replication")

# 
labels.data = c("p1", "p2", "p3", "p4", "p5", "p6", "p7", "p8", "p9", "p10", "p11", "p12")


fig4data.rt <- read.delim("fig4_rts.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)
fig4data.errors <- read.delim("fig4_errors.txt", header=FALSE, sep=c("", ":"), col.names=labels.data)

fig4data.rt$block <- seq(from=1, by=1, to=nrow(fig4data.rt))
fig4data.errors$block <- seq(from=1, by=1, to=nrow(fig4data.rt))



fig4data.rt.long <- melt(fig4data.rt, id.vars = "block",
                         variable.name = "trial.position",
                         value.name = "RT")
fig4data.errors.long <- melt(fig4data.errors,
                             id.vars = "block",
                             variable.name = "trial.position",
                             value.name = "error.rate")

idtask <- function (position) {
    if (as.numeric(position) < 5) {
        return (1)
    } else if (as.numeric(position) < 9) {
        return (2)
    } else {
        return (3)
    }
}

                                        # convert p1, p2 etc. into numeric position
fig4data.rt.long$trial.position <- as.numeric(gsub('p', '', fig4data.rt.long$trial.position))
fig4data.errors.long$trial.position <- as.numeric(gsub('p', '', fig4data.rt.long$trial.position))

# assign task (1, 2) for drawing group lines to match the figure
fig4data.rt.long$task <- sapply (fig4data.rt.long$trial.position, idtask)
fig4data.errors.long$task <- sapply (fig4data.rt.long$trial.position, idtask)
    
replication.fig4<- ggplot (fig4data.rt.long,  aes(x=trial.position, y=RT, group=task))
replication.fig4 +
    coord_cartesian(ylim=c(20, 140)) +
    stat_summary(fun.y = mean, geom = "line", position = "dodge") +
    stat_summary(fun.y = mean, geom = "point") +
        stat_summary(fun.data = mean_cl_boot,
                     geom = "errorbar",
                     # position = position_dodge(width = 0.2),
                     width = 0.2) + 
    labs (x = "trial position", y = "Simulated RT (Cycles)") +
    ggtitle("Replication: Gilbert & Shallice (2002) Fig. 4") +
    theme_bw() + theme (legend.position="bottom") + 
    scale_colour_grey(start = 0.1, end = 0.4) +
    scale_y_continuous( name= "RT (model cycles)",
       sec.axis = sec_axis(~ . * 5.8 +  318, # transformed sec axis to perform regression equation
       name="simulated RT (ms)",
       breaks = c(400, 500, 600, 700, 800, 900, 1000, 1100), 
       labels = c("400", "500", "600", "700", "800", "900", "1000", "1100")))


imageFile <- file.path("~/Dropbox/PhD/Thesis/replication/", "fig4_replicated_10000.png")
ggsave(filename=imageFile, width = 120, height = 800, units = "mm")


replication.fig4.errors<- ggplot (fig4data.errors.long,  aes(x=trial.position, y=1-error.rate, group=task))
replication.fig4.errors +
    stat_summary(fun.y = mean, geom = "line", position = "dodge") +
    stat_summary(fun.y = mean, geom = "point") +
        stat_summary(fun.data = mean_cl_boot,
                     geom = "errorbar",
                     # position = position_dodge(width = 0.2),
                     width = 0.2) + 
      labs (x = "trial position", y = "Simulated RT (Cycles)") +
          ggtitle("Replication: Gilbert & Shallice (2002) Fig. 4")

imageFile <- file.path("~/Dropbox/PhD/Thesis/replication/", "fig4_errors_replicated_10000.png")
ggsave(filename=imageFile, width = 120, height = 800, units = "mm")
