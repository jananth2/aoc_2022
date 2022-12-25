use strict; use warnings;

my @in = split(//, <STDIN>);
my @window = splice(@in, 0, 14);
my (@unique, $start);

do {
    $start++;
    @unique = do { my %seen; grep { !$seen{$_}++ } @window };
    shift(@window);
    push(@window, shift(@in));
} until (@unique == 14);

print $start + 13;
