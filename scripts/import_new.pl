#!/usr/bin/perl
use strict;
use warnings;
use utf8;

use lib '/home/grand/corpus/perl/lib';
use OpenCorpora::Dict::Importer;
#use Data::Dump qw/dump/;

binmode(STDOUT, ':utf8');
binmode(STDERR, ':utf8');

my $importer = new OpenCorpora::Dict::Importer;
$importer->read_rules('C://practice//scripts//import_rules.txt');
#my $dump = dump($importer);
#$dump =~ s/\\x{([0-9a-f]+)}/X/gi;
#print $dump;
$importer->read_aot('C://dictionary//morphs.mrd.dump.utf8.adj');
#$importer->read_aot('/home/grand/corpus/scripts/test.txt');
