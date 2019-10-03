#!/usr/bin/env perl
use strict;
use constant MAPQ_COLUMN => 11;

while (<>) {
	chomp;
	my @data = split /\t/;
	#extract the relevant tags and put them in consistent positions for the read.table that dotplotly will invoke
	my $type_idx;
	my $dvrg_idx;
	my $i = MAPQ_COLUMN + 1;
	for (; $i < @data; $i++) {
	  if ($data[$i] =~ /^tp:/) {
		  $type_idx = $i;
		  last;
	  }
	}
	for (; $i < @data; $i++) {
	  if ($data[$i] =~ /^d[ev]:/) {
	     $dvrg_idx = $i;
	     last;
	  }
	}
	print join("\t",@data[0..MAPQ_COLUMN],$data[$type_idx],(defined $dvrg_idx ? $data[$dvrg_idx] : sprintf("de:f:%0.2f",1-($data[9]/$data[10])))), "\n";
}
