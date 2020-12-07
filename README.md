# snubar_atac_scripts

This repository saves the scripts used in the manuscript xxx. 

# SNuBar reads demultiplexing and conversion

As described in the 'Data pre-processing' part in the Methods section, the following 3 scripts were used to pre-process the sequencing reads of SNuBar for spatial/sample barcoding.

1. `Snubar-ATAC-fq-convert.pl`: Core function.
2. `Snubar-ATAC-script.sh`: Script to process the SNuBar-ATAC data.
2. `Snubar-ARC-script.sh`: Script to process the SNuBar-ARC data.

# Signac with customization

The exact Signac package used in the manuscript had customized visualization based on the official Signac v1.0 (https://github.com/timoast/signac/tree/c53f27048b309fa67fe9879702ab330525130d60). 

Compared with the official package, our customization differed in those aspects only :

1. Supported the 'random' mode in the function `TilePlot` which visualizes scATAC fragment presence within randomly selected single cells.
2. Restored the y-axis ticks/texts in the function `CoveragePlot`.
3. Colored the gene strandness in the function `AnnotationPlot`. Black and grey colored the positive and negative strand, respectively.

Here is the link to the Signac version used in the manuscript: https://github.com/Puriney/signac/releases/tag/v.1.0.0.alpha
