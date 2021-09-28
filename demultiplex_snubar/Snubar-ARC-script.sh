#---For SnubarARC demultiplex
/cellranger-arc-1.0.0/cellranger-arc mkfastq --run=/path/to/SnubarARC-ATAC_sequencing --csv atac-sample.csv --id=fastq_atac --localcores=60 --localmem=600
/cellranger-arc-1.0.0/cellranger-arc mkfastq --run=/path/to/SnubarARC-ATAC_sequencing --csv rna-sample.csv --id=fastq_gex_qc --qc --localcores=60 --localmem=600
#---For SnubarARC-ATAC library
#-----Cell lines
#NOTE: For cell lines experiment, since the cellranger-arc doesn't support mixed species, we used cellrange-atac to process the scATAC data from CO-Assay experiment with the following modification:
#--1) Replace /cellranger-atac-cs/1.2.0/lib/python/barcodes/737K-cratac-v1.txt with /cellranger_ARC/cellranger-arc-1.0.0/lib/python/atac/barcodes/737K-arc-v1.txt, but keep the original name.
#--2) Modify line 40 of /cellranger-atac-cs/1.2.0/lib/python/constants.py from MAXIMUM_CELLS_PER_SPECIES = 20000 to MAXIMUM_CELLS_PER_SPECIES = 2000000 to previent limit warnings when overloading the cells.
#--3) For libraries sequenced by nextseq2000, we used seqtk to remove the first 8bp spacers of cell barcode reads (usually named as R2 after demulplexing) 
seqtk trimfq -b 8 SnubarARC-ATAC_S1_L001_R2_001.fastq.gz | gzip -c > ../SnubarARC-ATAC_S1_L001_R2_001.fastq.gz #then replace the old R2 file with the new one
/cellranger-atac-1.2.0/cellranger-atac count --id=SnubarATAC_test --reference=/refdata-cellranger-atac-hg19-and-mm10-1.2.0 --fastqs=/Snubar_fastq/path --sample=Snuber_test1 --localcores=60 --localmem=600
#-----Human tissues
/cellranger-atac-1.2.0/cellranger-atac count --id=SnubarATAC_test --reference=/refdata-cellranger-atac-hg19-1.2.0 --fastqs=/Snubar_fastq/path --sample=Snuber_test1 --localcores=60 --localmem=600
#---For SnubarARC-RNA library
#-----Cell lines
/bin/cellranger-4.0.0/cellranger count --id SnubarARC-RNA_test --fastqs /SnubarARC_RNA_fastq/path --sample SnubarARC-RNA_test1 --transcriptome /refdata-cellranger-hg19_and_mm10-1.2.0_premrna --localcores=60 --localmem=500 --chemistry=JAG-v1
#-----Human tissues
/bin/cellranger-4.0.0/cellranger count --id SnubarARC-RNA_test --fastqs /SnubarARC_RNA_fastq/path --sample SnubarARC-RNA_test1 --transcriptome /refdata-cellranger-hg19-1.2.0_premrna --localcores=60 --localmem=500 --chemistry=JAG-v1
#---For barcode library
#--Prepare barcode white list
# 1 format: Barcode_sequence,Barcode_name
# 2 one barcode per row
#--Prepare cell white list
sed '1d' /Cell_ranger_RNA_results/outs/analysis/clustering/kmeans_2_clusters/clusters.csv | sed 's/-/\t/g' | cut -f1 > whitelist_cells.txt
#--Use CITE-seq-Count (V1.4.3) to generate Cell X Sample_BC matrix
CITE-seq-Count -R1 /BCREAD_FOLDER/SnubarARC-bc-R1.fastq.gz -R2 /BCREAD_FOLDER/SnubarARC-bc-R2.fastq.gz -t whitelist_barcode -cbf 1 -cbl 16 -umif 17 -umil 28 --max-error 2 --umi_collapsing_dist 1 --dense -o SnubarARC_bc_out -wl whitelist_cells.txt -cells 10000 -T 60
