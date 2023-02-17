sample=$1;
./sp_N50.pl ${sample}.len_kraken >${sample}.sp_N50
cut -f 1 ${sample}.sp_N50 |awk -F"|" '{print $NF}'|sed 's/s__//;s/_/ /'|../../my_join.pl -F 1 -f 1 -a  ../../refseq_complete.list -b - |awk -F"\t" '$5!=""'|grep 'Complete Genome'|awk -F"/" '{print $NF}'|awk -F"\t" '{print $2"\t"$1}'|awk -F "." '{print $1}' >${sample}.sp_genome
cut -f 2 ${sample}.sp_genome |while read f;do ../../get_fa_length.pl ../../complete_genome/$f.fna|awk -v f=$f '{print f"\t"$0}';done >${sample}.sp_genome_length
awk -F"|" '{print $0"\t"$NF}' ${sample}.len_kraken |../../my_join.pl -F 5 -f 1 -a - -b <(sed 's/^/s__/;s/ /_/' ${sample}.sp_genome)|grep 'GCA' >${sample}.contig.sp_len
sed -i 's/^/s__/;s/ /_/' ${sample}.sp_genome
echo "BLAST start"
mkdir sp_blast_${sample}
cat ${sample}.sp_genome|while read sp genome;do
grep ${sp} ${sample}.len_kraken |cut -f 1 |../../select_fa.pl ../gene_prediction/Result/${sample}.fna - >sp_blast_${sample}/${sample}.${sp}.fa
blastall -p blastn -d ../../complete_genome/${genome}.fna -i sp_blast_${sample}/${sample}.${sp}.fa -m8 -o  sp_blast_${sample}/${sample}.${sp}.m8;
done 
echo "BLAST end"
ls sp_blast_${sample}/*.m8|while read f;do a=`awk '$3>90&&$4>500' $f|wc -l `;b=`wc -l $f`;echo  $a $b;done >${sample}.m8.cal

awk '{if($1>0)print $3}' ${sample}.m8.cal|sed 's/.m8//'|while read mf;do 
awk '$3>90&&$4>500' ${mf}.m8|cut -f 2,9,10|awk '{if($2>$3){print $1"\t"$3"\t"$2}else{print }}'|sort -k 1,1 -k 2,2n > ${mf}.bed
mergeBed -i ${mf}.bed|awk '{sum[$1]+=$3-$2}END{for (i in sum){print i"\t"sum[i]}}' |sort > ${mf}.genL
awk '{sum[$1]+=$3-$2}END{for (i in sum){print i"\t"sum[i]}}' ${mf}.bed |sort  > ${mf}.contL
awk '$3>90&&$4>500' ${mf}.m8|cut -f 1,2|sort -u |cut -f 2|sort|uniq -c |awk '{print $2"\t"$1}' >${mf}.contigCount
awk '$3>90&&$4>500' ${mf}.m8|awk '{sum[$1"\t"$2]+=$8-$7}END{for (i in sum){print i"\t"sum[i]}}' |../../my_join.pl -F 1 -f 1 -a - -b <(../../get_fa_length.pl ${mf}.fa |sed 's/>//') |awk '$3>1000&&$3/$5>0.5' >${mf}.highQContig 
../../my_join.pl -F 1 -f 1 -a <(awk '$3>90&&$4>500' ${mf}.m8) -b ${mf}.highQContig|awk -F"\t" '$13!=""' >${mf}.highQ.m8 
cut -f 2,9,10 ${mf}.highQ.m8 |awk '{if($2>$3){print $1"\t"$3"\t"$2}else{print }}'|sort -k 1,1 -k 2,2n |mergeBed -i - |awk '{sum[$1]+=$3-$2}END{for (i in sum){print i"\t"sum[i]}}' > ${mf}.highQ.genL
cut -f 1,2 ${mf}.highQ.m8|sort -u |cut -f 2|sort |uniq -c |awk '{print $2"\t"$1}'  >${mf}.highQ.contigCount
done 

awk '$1>0' ${sample}.m8.cal|sed 's/.m8//'|while read fc rc mf;do
../../summary_result.pl ${mf} |sed '1d'|awk -v fc=$fc -v rc=$rc '{print fc"\t"rc"\t"$0}'
done >${sample}.bl8cov 

sed 's/>//;s/ /\t/' ${sample}.sp_genome_length |cut -f 2,4|../../my_join.pl -F 4 -f 1 -a ${sample}.bl8cov -b -  >${sample}.bl8cov_len
awk '{print $0"\t"$9/$11}' ${sample}.bl8cov_len|sort -k 12nr|awk '$12>0.6' >  ${sample}.highQGenome

