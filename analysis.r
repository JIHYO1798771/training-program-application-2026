# ---------------------------------------------------------

# Melbourne Bioinformatics Training Program

# This exercise to assess your familiarity with R and git. Please follow
# the instructions on the README page and link to your repo in your application.
# If you do not link to your repo, your application will be automatically denied.

# Leave all code you used in this R script with comments as appropriate.
# Let us know if you have any questions!


# You can use the resources available on our training website for help:
# Intro to R: https://mbite.org/intro-to-r
# Version Control with Git: https://mbite.org/intro-to-git/

# ----------------------------------------------------------

# Load libraries -------------------
# You may use base R or tidyverse for this exercise

# ex. library(tidyverse)
library(tidyverse)

# Load data here ----------------------
# Load each file with a meaningful variable name.
gene_expression = read.csv("data/GSE60450_GeneLevel_Normalized(CPM.and.TMM)_data.csv", header = T)
gene_meta = read.csv("data/GSE60450_filtered_metadata.csv", header = T)

# Inspect the data -------------------------

# What are the dimensions of each data set? (How many rows/columns in each?)
# Keep the code here for each file.

## Expression data
dim(gene_expression) # 23735 14

## Metadata
dim(gene_meta) # 4 12

# Prepare/combine the data for plotting ------------------------
# How can you combine this data into one data.frame?

head(gene_expression)
head(gene_meta) # Check structures to dicide how to combine

gene_combine = gene_expression[, -c(1,2)] # removing id columns
gene_combine = as.data.frame(t(gene_combine)) # transposing table for simpler structure
id = c(paste0(gene_expression[,1], "_", gene_expression[,2])) # combining ENSEMLB code and gene symbol
colnames(gene_combine) = id
gene_combine = cbind(gene_meta[, -1], gene_combine) # combining meta data
gene_combine[1:10, 1:10] # check for successful combining

# Plot the data --------------------------
## Plot the expression by cell type
## Can use boxplot() or geom_boxplot() in ggplot2

target = colnames(gene_combine)[4] # declare a variable for repeating, taking first gene as example
expression_plot = ggplot(data = gene_combine , aes(x = characteristics, y = .data[[target]])) + 
	                geom_boxplot() + coord_flip() # x index names are long
expression_plot

## Save the plot
### Show code for saving the plot with ggsave() or a similar function

ggsave("expression_plot.pdf", plot = expression_plot, path = "results")

