#---For ATAC library
/cellranger-atac-1.2.0/cellranger-atac mkfastq --id=Snubar_fastq --run=/path/to/Snubar_sequencing --samplesheet=sample_index.csv --localcores=60 --localmem=600 --qc
/cellranger-atac-1.2.0/cellranger-atac count --id=SnubarATAC_test --reference=/ref/folder --fastqs=/Snubar_fastq/path --sample=Snuber_test1 --localcores=60 --localmem=600

#---For barcode library
#--merge R1 and R2 files from different lanes if you have
#--R1: Read1; R2: Inex2 (cell barcode); R3: Read2
ls /BCREAD_FOLDER/*R1* | xargs cat > SnubarATAC_test1_bc_R1.fastq.gz
ls /BCREAD_FOLDER/*R2* | xargs cat > SnubarATAC_test1_bc_R2.fastq.gz

#--Convert barcode files into R1:Cell_barcode + UMI and R2: Sample_barcode
perl Snubar-ATAC-fq-convert.pl SnubarATAC_test1_bc_R1.fastq.gz SnubarATAC_test1_bc_R2.fastq.gz

#--Prepare barcode white list 
# 1 format: Barcode_sequence,Barcode_name
# 2 one barcode per row

#--Prepare cell white list
sed '1d' /Cell_ranger_results/outs/analysis/clustering/kmeans_3_clusters/clusters.csv | sed 's/-/\t/g' | cut -f1 > whitelist_cells.txt

#--Use CITE-seq-Count (V1.4.3) to generate Cell X Sample_BC matrix 
CITE-seq-Count -R1 Corrected_CITE-SnubarATAC_test1_bc_R1.fastq.gz -R2 Corrected_CITE-SnubarATAC_test1_bc_R1.fastq.gz -t whitelist_barcode -cbf 1 -cbl 16 -umif 17 -umil 24 --max-error 2 --umi_collapsing_dist 1 --dense -o SnubarATAC_out -wl whitelist_cell.txt -cells 10000 -T 60
