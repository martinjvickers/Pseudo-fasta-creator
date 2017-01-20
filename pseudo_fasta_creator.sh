#!/usr/bin/perl

$file='test.fa';
open(INFO, $file) or die("Could not open  file.");

my $maxchr=22576114;
my $chr=0;
@counts = (0,0,0,0,0,0,0,0,0,0);

my $buffer="NNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNNN";

##a file to record the new locations of the original scaffolds within our pseudo chromosomes
my $filename = 'report.txt';
open(my $fh, '>', $filename) or die "Could not open file '$filename' $!";

##the file which stores our pseudo chromosomes
my $filename2 = 'pseudo.fa';
open(my $fh2, '>', $filename2) or die "Could not open file '$filename2' $!";

foreach $line (<INFO>)  {

	my @char = split("",$line);
		
	##print to report so we know what we're doing
	if(@char[0] eq ">"){
		chomp($line);
		print $fh "$line >pseudo_$chr $counts[$chr]\n"
	} else {
		#record current pseudo chr length
		$counts[$chr] = $counts[$chr]+length($line)+length($buffer);
		chomp($line);
		print $fh2 "$line$buffer";
		if($counts[$chr] > $maxchr)
		{
			print $fh2 "\n";
			$chr++;
		}
	}

        ##if new psudo, print header
        if(($counts[$chr] == 0) && (@char[0] eq ">")){
                print $fh2 ">pseudo_$chr\n"
        }

}

print "hello"
