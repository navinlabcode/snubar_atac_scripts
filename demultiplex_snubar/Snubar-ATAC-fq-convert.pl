#!/usr/bin/perl -w
use File::Basename;
use strict;

unless (@ARGV==2){
        die "perl $0 <Read1.fastq.gz> <Index5.fastq.gz>\n";
        }
my ($fq1,$fq2)=@ARGV;
my $filename1= basename $fq1;
my $filename2= basename $fq2;

if ($fq1 =~/.gz$/ && $fq2 =~/.gz$/)
{
open FQ1, "gunzip -c $fq1 |" || die "can't open the $fq1 file!";
open FQ2, "gunzip -c $fq2 |" || die "can't open the $fq2 file!";
open OUT1, " | gzip > Corrected_CITE-$filename1";
open OUT2, " | gzip > Corrected_CITE-$filename2";
}
else
{
open FQ1, "<$fq1" || die "can't open the $fq1 file!";
open FQ2, "<$fq2" || die "can't open the $fq2 file!";
open OUT1, " | gzip > Corrected_CITE-$filename1";
open OUT2, " | gzip > Corrected_CITE-$filename2";
}

while(1){
my $a1 = <FQ1>;
my $a2 = <FQ1>;
chomp $a2;
my @c2=split(//,$a2);
my $a3 = <FQ1>;
my $a4 = <FQ1>;
chomp $a4;
my @c4=split(//,$a4);
my $b1 = <FQ2>;
my $b2 = <FQ2>;
chomp $b2;
my @d2=split(//,$b2);
my $b3 = <FQ2>;
my $b4 = <FQ2>;
chomp $b4;
my @d4=split(//,$b4);

print OUT1 $a1.$b2.join("",@c2[18..25])."\n".$a3.$b4.join("",@c4[18..25])."\n";
print OUT2 $b1.join("",@c2[0..17])."\n".$b3.join("",@c4[0..17])."\n";

if(eof(FQ1))
{
last;
}
}
close FQ1;
close FQ2;
close OUT1;
close OUT2;
