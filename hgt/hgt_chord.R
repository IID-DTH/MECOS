library(circlize)
pdf('hgt_link.pdf')
#layout(matrix(1:3, 1,3))
mat_athena<-read.table("data\\Human_meta_1_athena.hgt.mat", sep='\t', head=T, row.names=1)
mat_athena<-as.matrix(mat_athena)

col_mat <- rand_color(nrow(mat_athena) * (nrow(mat_athena) - 1) / 2, transparency = 0.5)
chordDiagram(mat_athena, symmetric=T, grid.col=rand_color(nrow(mat_athena)),
             annotationTrack = c("grid", "axis"),
             preAllocateTracks = list(track.height = 0.25))

circos.track(track.index = 1, panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
        facing = "clockwise", niceFacing = TRUE, adj = c(-0.1, 0), cex=0.5)
}, bg.border = NA) # here set bg.border to NA is important


mat_athena<-read.table("data\\H1_spa.hgt.mat", sep='\t', head=T, row.names=1)
mat_athena<-as.matrix(mat_athena)

col_mat <- rand_color(nrow(mat_athena) * (nrow(mat_athena) - 1) / 2, transparency = 0.5)
chordDiagram(mat_athena, symmetric=T, grid.col=rand_color(nrow(mat_athena)),
             annotationTrack = c("grid", "axis"),
             preAllocateTracks = list(track.height = 0.25))

circos.track(track.index = 1, panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
        facing = "clockwise", niceFacing = TRUE, adj = c(-0.1, 0), cex=0.5)
}, bg.border = NA) # here set bg.border to NA is important

mat_athena<-read.table("data\\H1wgs_spa.hgt.mat", sep='\t', head=T, row.names=1)
mat_athena<-as.matrix(mat_athena)
	
col_mat <- rand_color(nrow(mat_athena) * (nrow(mat_athena) - 1) / 2, transparency = 0.5)
chordDiagram(mat_athena, symmetric=T, grid.col=rand_color(nrow(mat_athena)),
             annotationTrack = c("grid", "axis"),
             preAllocateTracks = list(track.height = 0.15))

circos.track(track.index = 1, panel.fun = function(x, y) {
    circos.text(CELL_META$xcenter, CELL_META$ylim[1], CELL_META$sector.index, 
        facing = "clockwise", niceFacing = TRUE, adj = c(-0.1, 0), cex=0.5)
}, bg.border = NA) # here set bg.border to NA is important

dev.off()