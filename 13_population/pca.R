library(ggplot2)
library(tidyr)

args <- commandArgs(trailingOnly = TRUE)
if (length(args) < 4) {
  stop("Usage: Rscript pca_plot.R <eigenvalFile> <eigenvecFile> <classFile> <prefix> [xPC] [yPC]")
}

eigenvalFile <- args[1]
eigenvecFile <- args[2]
classFile    <- args[3]
prefix       <- args[4]
xPC <- ifelse(length(args) >= 5, args[5], "1")
yPC <- ifelse(length(args) >= 6, args[6], "2")
# ----- read pca result file -----
eigenval <- read.table(eigenvalFile, header = FALSE)
total_variance <- sum(eigenval$V1)
variance_explained <- eigenval$V1 / total_variance * 100

eigenvec <- read.table(eigenvecFile, header = FALSE)
colnames(eigenvec) <- c("SampleID", "FamilyID", paste0("PC", 1:(ncol(eigenvec) - 2)))

sampleclass <- read.table(classFile, header = FALSE, sep = "\t")
colnames(sampleclass) <- c("SampleID", "Class")

merged_data <- merge(eigenvec, sampleclass, by = "SampleID", all.x = TRUE)
write.table(merged_data, paste0(prefix, ".mergedData.txt"),
            sep = "\t", quote = FALSE, row.names = FALSE)


color_table <- c(
  African_indicine = "#F98C02",
  African_taurine = "#35C1FF",
  American_bison = "#6f89ad",
  Banteng = "#8075ad",
  China_hybird = "#AD6B1A",
  European_bison = "#99b3c6",
  European_taurine = "#2E90FF",
  Gaur = "#8a7c9c",
  Gayal = "#6b2da0",
  Indian_indicine = "#E8A08C",
  Middle_East_taurine = "#86CEFA",
  Northeast_Asia_taurine = "#2E8B57",
  Northwest_China_taurine = "#2FB1A9",
  South_China_indicine = "#D55020",
  Tibet_taurine = "#43FE7F",
  Tibet_yak = "#3d293f"
)

pop_order <- c(
  "Gayal",
  "Banteng",
  "Gaur",
  "European_bison",
  "American_bison",
  "Tibet_yak",
  "South_China_indicine",
  "Indian_indicine",
  "African_indicine",
  "China_hybird",
  "Tibet_taurine",
  "Northeast_Asia_taurine",
  "African_taurine",
  "Northwest_China_taurine",
   "European_taurine"
)
merged_data$Class <- factor(merged_data$Class, levels = pop_order)

merged_data <- merged_data[order(merged_data$Class), ]

pdf_prefix <- paste0(prefix, ".", "PC", xPC, "-", "PC", yPC)
pdf(paste0(pdf_prefix, ".pdf"), width = 8, height = 5)

X <- paste0("PC", xPC)
Y <- paste0("PC", yPC)
ggplot(merged_data, aes_string(x = X, y = Y, fill = "Class")) +
  geom_point(shape = 21, size = 5, color = "white", stroke = 0.3) +
  scale_fill_manual(values = color_table) +
  labs(
    x = paste0(X," (", round(variance_explained[as.numeric(xPC)], 2), "%)"),
    y = paste0(Y," (", round(variance_explained[as.numeric(yPC)], 2), "%)")
  ) +
  theme_bw() +
  theme(
    panel.grid.major = element_blank(),
    panel.grid.minor = element_blank(),
    axis.title = element_text(size = 14, color = "black"),
    axis.text = element_text(size = 14, color = "black"),
    axis.ticks.length = unit(0.3, "cm"),
    axis.ticks = element_line(linewidth = 0.4, color = "black"),
    axis.line = element_blank()
  ) +
  theme(
    legend.position = "right",
    legend.box = "vertical",
    legend.title = element_text(size = 10, color = "black"),
    legend.text = element_text(size = 10, color = "black"),
    legend.spacing.y = unit(0.000001, 'cm')
  ) +
  guides(
    fill  = guide_legend(byrow = TRUE),
    color = guide_legend(byrow = TRUE),
    shape = guide_legend(byrow = TRUE)
  )

dev.off()