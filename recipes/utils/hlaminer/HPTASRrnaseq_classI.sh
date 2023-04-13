###Run TASR
echo "Running TASR..."
#TASR Default is -k 15 for recruiting reads. You may increase k, as long as k < L/2 where L is the minimum shotgun read length
/opt2/HLAminer-1.4/HLAminer_v1.4/bin/TASR -f patient.fof -m 20 -k 20 -s /opt2/HLAminer-1.4/HLAminer_v1.4/database/HLA_ABC_CDS.fasta -i 1 -b TASRhla -w 1
###Restrict 200nt+ contigs
cat TASRhla.contigs |perl -ne 'if(/size(\d+)/){if($1>=200){$flag=1;print;}else{$flag=0;}}else{print if($flag);}' > TASRhla200.contigs
if [ -s TASRhla200.contigs ];
then
	    echo "contigs with >200bp length are present"
    else
	        touch HLAminer_HPTASR.csv  && exit 0
fi
###Create a [NCBI] blastable database
echo "Formatting blastable database..."
/opt2/HLAminer-1.4/HLAminer_v1.4/bin/formatdb -p F -i TASRhla200.contigs
###Align HLA contigs to references
echo "Aligning TASR contigs to HLA references..."
/opt2/HLAminer-1.4/HLAminer_v1.4/bin/parseXMLblast.pl -c /opt2/HLAminer-1.4/HLAminer_v1.4/bin/ncbiBlastConfigO.txt -d /opt2/HLAminer-1.4/HLAminer_v1.4/database/HLA_ABC_CDS.fasta -i TASRhla200.contigs -o 0 -a 1 > tig_vs_hla-ncbi.coord
###Align HLA references to contigs
echo "Aligning HLA references to TASR contigs (go have a coffee, it may take a while)..."
/opt2/HLAminer-1.4/HLAminer_v1.4/bin/parseXMLblast.pl -c /opt2/HLAminer-1.4/HLAminer_v1.4/bin/ncbiBlastConfigO.txt -i /opt2/HLAminer-1.4/HLAminer_v1.4/database/HLA_ABC_CDS.fasta -d TASRhla200.contigs -o 0 > hla_vs_tig-ncbi.coord
###Predict HLA alleles
echo "Predicting HLA alleles..."
/opt2/HLAminer-1.4/HLAminer_v1.4/bin/HLAminer.pl -b tig_vs_hla-ncbi.coord -r hla_vs_tig-ncbi.coord -c TASRhla200.contigs -h /opt2/HLAminer-1.4/HLAminer_v1.4/database/HLA_ABC_CDS.fasta
