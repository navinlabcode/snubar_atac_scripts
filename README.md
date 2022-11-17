# snubar_atac_scripts

This repository saves the scripts used in the manuscript. 

Kaile Wang*, Zhenna Xiao*, Yun Yan*, Rui Ye, Min Hu, Shanshan Bai, Emi Sei, Yawei Qiao, Hui Chen, Bora Lim, Steven H Lin, Nicholas E Navin^. Simple oligonucleotide-based multiplexing of single-cell chromatin accessibility. Mol Cell . 2021 Oct 21;81(20):4319-4332.e10. doi: [10.1016/j.molcel.2021.09.026](https://doi.org/10.1016/j.molcel.2021.09.026).



# SNuBar reads demultiplexing and conversion

As described in the 'Data pre-processing' part in the Methods section, the following 3 scripts were used to pre-process the sequencing reads of SNuBar for spatial/sample barcoding.

1. `Snubar-ATAC-fq-convert.pl`: Script to transform ATAC cells barcode.
2. `Snubar-ATAC-script.sh`: Script to process the SNuBar-ATAC data.
2. `Snubar-ARC-script.sh`: Script to process the SNuBar-ARC data.

---

# Prepare SNP for Demuxlet

See the pipeline [here](https://github.com/Puriney/prepare_demuxlet_snp/tree/2d89c3cefe63e2604b2992fab9933dab2e2ad0b7).
