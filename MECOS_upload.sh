rawfq1=./example/rawdata/sample/V350110680_L01_1_1.fq.gz
rawfq2=./example/rawdata/sample/V350110680_L01_1_2.fq.gz
sample=sample

###step1.fastqc
fastqc --extract $rawfq1  -o ./example/00.raw/result
fastqc --extract $rawfq2  -o ./example/00.raw/result

###step2.split barcode
cd ./example/01.QC/$sample
perl ./scripts/split_barcode2.pl ./scripts/barcode_list.txt $rawfq1 $rawfq2 split_reads 14 > cutoff_barcode.log
echo "split_reads.1.fq.gz" > lane.lst
echo "split_reads.2.fq.gz" >> lane.lst

###step3.quality control and remove host sequences
SOAPfilter_v2.2 -t 10  -y  -F CTGTCTCTTATACACATCTTAGGAAGACAAGCACTGACGACATGA  -R TCTGCTGAGTCGAGAACGTCTCTGTGAGCCAAGGAGTTGCTCTGG  -p -M 2 -f -1 -Q 10 lane.lst stat_SOAP.txt > SOAP.log
mv split_reads.1.fq.gz.clean.gz split_reads.1.clean.fq.gz
mv split_reads.2.fq.gz.clean.gz split_reads.2.clean.fq.gz
bowtie2  --very-sensitive  -p 10 -x /db/hg38  -1 split_reads.1.clean.fq.gz  -2 split_reads.2.clean.fq.gz  --al-conc-gz  $sample.map.fq.gz  --un-conc-gz  $sample.unmap.fq.gz  -S $sample.sam > bowtie2.log
mv $sample.unmap.fq.1.gz $sample.unmap.1.fq.gz
mv $sample.unmap.fq.2.gz $sample.unmap.2.fq.gz

###step4.remove sequences of invalid barcodes
cd ./example/02.assembly/$sample
zcat ./example/01.QC/$sample/$sample.unmap.1.fq.gz |sed 'N;N;N ;s/\n/\t_|_/g'|grep -v '0_0_0' > $sample.unmap.clean.tmp.1.fq
sort -k 2 $sample.unmap.clean.tmp.1.fq |sed 's/\t\_|\_/\n/g' >$sample.unmap.clean.1.fq
zcat ./example/01.QC/$sample/$sample.unmap.2.fq.gz |sed 'N;N;N ;s/\n/\t_|_/g'|grep -v '0_0_0' > $sample.unmap.clean.tmp.2.fq
sort -k 2 $sample.unmap.clean.tmp.2.fq |sed 's/\t\_|\_/\n/g' >$sample.unmap.clean.2.fq

###step5.assembly stLFR sequences
cd ./example/02.assembly/$sample
fastq_pair $sample.unmap.clean.1.fq $sample.unmap.clean.2.fq
cutadapt  -o $sample.interleaved.clean.fq  --interleaved $sample.unmap.clean.1.fq.paired.fq $sample.unmap.clean.2.fq.paired.fq
metaspades.py -1 $sample.unmap.clean.1.fq.paired.fq -2 $sample.unmap.clean.2.fq.paired.fq  -o ./metaspades
cd ./example/02.assembly/$sample/metaspades
bwa  index  contigs.fasta
bwa  mem -C  contigs.fasta ../$sample.unmap.clean.1.fq.paired.fq  ../$sample.unmap.clean.2.fq.paired.fq | samtools  sort -o align-reads.metaspades-contigs.bam -
samtools index align-reads.metaspades-contigs.bam
cd ./example/02.assembly/$sample/athena
athena-meta --config ./example/02.assembly/$sample/athena/$sample.config  --threads 128 > athena.log

###step6.contig binning
cd ./example/03.binning/$sample
ln -s ./example/02.assembly/$sample/athena/results/olc/athena.asm.fa  $sample.fasta
bowtie2-build  -f $sample.fasta $sample.fasta
bowtie2 -x $sample.fasta  -1 ./example/02.assembly/$sample/$sample.unmap.clean.1.fq.paired.fq  -2 ./example/02.assembly/$sample/$sample.unmap.clean.2.fq.paired.fq  -p 20 -S $sample.sam 2> bowtie2.log
samtools view -F 4  -Sb $sample.sam  > $sample.bam
samtools  sort $sample.bam  -o $sample.sort.bam
samtools index  $sample.sort.bam
jgi_summarize_bam_contig_depths  --outputDepth $sample.depth.txt $sample.sort.bam
metabat2 -i $sample.fasta -a $sample.depth.txt -o $sample --sensitive -t 20 -v > $sample.log.txt

###step7.prokka annotation
ls ./example/03.binning/$sample/$sample.*.fa >./example/04.annotation/$sample.binning.list
for $i in $sample.binning.list
do
prokka --force --cpus 10 --outdir ./example/04.annotation/prokka/$sample/prokka/$i --prefix $i  --locustag $i  --metagenome --kingdom Bacteria  ./example/03.binning/$sample/$i
done

###step8.emapper annotation
for $i in $sample.binning.list
do
emapper.py -i $i --itype metagenome -m diamond --evalue 1e-05 -o $i --output_dir ./example/04.annotation/emapper/$sample/output
done

###step9.gtdb annotation
ln -s ./example/03.binning/$sample/$sample.*.fa  ./example/04.annotation/gtdb/contig/
gtdbtk  classify_wf --genome_dir ./example/04.annotation/gtdb/contig/   --out_dir ./example/04.annotation/gtdb/new_gtdb --extension fa --cpus 30

###step10.vfdb annotation
for $i in $sample.binning.list
do
abricate $i --db vfdb --minid=75 > ./example/04.annotation/vfdb/$sample/$i.vfdb.tab
done

###step11.resfinder annotation
for $i in $sample.binning.list
do
abricate $i --db resfinder_new --minid=75 > ./example/04.annotation/resfinder/$sample/$i.resfinder_new.tab
done
