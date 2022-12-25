use strict;
use warnings;

my %alph;
@alph{"a".."z", "A".."Z"} = 1..52;

my $total = 0;
until (eof STDIN) {
    my ($rec, @block);
    push @block, $rec while @block < 3 and chomp($rec = <>);
    my %ht = map +($_ => $alph{$_}), split(//, $block[0]);
    my %hu = map +($_ => $alph{$_}), split(//, $block[1]);
    my %hv = map +($_ => $alph{$_}), split(//, $block[2]);
    foreach (keys %ht){	$total += $ht{$_} if exists $hu{$_} && exists $hv{$_}; }
}
print "$total\n";
