# Pseudo-fasta-creator
You have a reference with 1000s of scaffolds which breaks all of your tools. The Marchantia genome did it for us, so this program converts it into 10 Pseudo chromosomes.

##Using this

This is quite a nasty script at this point as it was intended as a one time. These instructions will hopefully be enough to follow the procedure in case a different reference needs this treatment or if the tool needs rewriting to be more generic.

To begin with remove the carriage returns from the sequence lines of the fasta file. This is because the perl program assumes two lines per scaffold.

```
chmod +x remove_carriage_rtn_fasta.sh
./remove_carriage_rtn_fasta.sh Mpolymorpha_320_v3.0.fa > test.fa
```

From here it's useful to count the number of bases in each scaffold. You can do this a number of ways, here is my awk/sed way of doing it.

```
cat test.fa | awk '{print length($1)}' | sed -n '1~2!p' |awk '{sum=sum+$1} END {print sum}'
225761139
```

So the `Mpolymorpha_320_v3.0.fa` geneome has 225761139 bases. Since we wish to create 10 pseudo chromosomes we set a max psuedo chromosome size of 22576114 bases. These parameters are set in the perl `pseudo_fasta_creator.sh` script by the `$maxchr` variable and the number of 0's in the `@counts` array. Besides those two variables and the input file name (`$file='test.fa';`) you shouldn't need to change anything else.

When you run the perl script you will get the pseudo.fa and the report.txt which will tell you where each scaffold has been translated to in the pseudo reference. Column 1 is the original scaffold name, column 2 is the new pseudo chromosome name and column 3 is the start base in the new pseudo chromosome that the scaffold begins at.

```
martin@x250:$ head report.txt 
>scaffold_1 >pseudo_0 0
>scaffold_2 >pseudo_0 6193412
>Chr_Y_A >pseudo_0 9767619
>scaffold_3 >pseudo_0 13243749
>scaffold_4 >pseudo_0 16596635
>scaffold_5 >pseudo_0 19804082
>scaffold_6 >pseudo_1 0
>scaffold_7 >pseudo_1 2947545
>scaffold_8 >pseudo_1 5869921
>scaffold_9 >pseudo_1 8775999

```

##Lots of N's

In order to provide a buffer between scaffolds, 1000 Ns are placed after the scaffold sequence. The start base in the report.txt file has taken this into account. 
