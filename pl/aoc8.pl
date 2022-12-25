use strict; use warnings; use List::Util "max", "first";

my @lines = <STDIN>;
my @m = map { [split(//, $_)] } (@lines);

my $max_ = 0;
for my $r (1..$#m-1) { # for each row
    for my $c (1..@{$m[$r]}-2) { # for each column
	my $cell = @{$m[$r]}[$c];
	my $s = 1;

	$s *= $r + (first { $_==0 || @{$m[-$_]}[$c] >= $cell } (1-$r..0));
	$s *= (first { $_==$#m || @{$m[$_]}[$c] >= $cell } ($r+1..$#m)) - $r;
	$s *= $c + (first { $_==0 || @{$m[$r]}[-$_] >= $cell } (1-$c..0));
	$s *= (first { $_==@{$m[$r]}-1 || @{$m[$r]}[$_] >= $cell } ($c+1..@{$m[$r]}-1)) - $c;
	$max_ = max($max_, $s);
    }
}

print "$max_\n";
