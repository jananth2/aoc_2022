use strict; use warnings;

my ($gx, $gy);
my @matrix;
my @srcs;
my %visited;
my @q;

sub parse () {
    @matrix = <STDIN>;
    for my $j (0..$#matrix) {
	$matrix[$j] = [split //, $matrix[$j]];
	for my $i (0..$#{$matrix[$j]}-1) {
	    if ($matrix[$j]->[$i] eq "a" || $matrix[$j]->[$i] eq "S") {
		$matrix[$j]->[$i] = "a";
		push (@srcs, ($i, $j));
	    } elsif ($matrix[$j]->[$i] eq "E") {
		($gx, $gy) = ($i, $j);
	    }
	}
    }
}

sub bfs () {
    my ($x, $y, $d) = splice(@q, 0, 3);

    return 0 if (exists $visited{"$x $y"});
    $visited{"$x $y"} = 1;

    return $d if ($x == $gx && $y == $gy);

    push @q, ($x-1, $y, $d + 1) if ($x > 0 && ord($matrix[$y]->[$x]) >= (ord($matrix[$y]->[$x-1])-1));
    push @q, ($x+1, $y, $d + 1) if ($x < $#{$matrix[0]}-1 && ord($matrix[$y]->[$x]) >= (ord($matrix[$y]->[$x+1])-1));
    push @q, ($x, $y-1, $d + 1) if ($y > 0 && ord($matrix[$y]->[$x]) >= (ord($matrix[$y-1]->[$x])-1));
    push @q, ($x, $y+1, $d + 1) if ($y < $#matrix && ord($matrix[$y]->[$x]) >= (ord($matrix[$y+1]->[$x])-1));
    return 0;
}

parse();

my @dists;
while (@srcs) {
    my $ret;
    @q = (splice(@srcs, 0, 2), 0);
    do { $ret = bfs() } until ($ret || !@q);
    %visited = ();
    push (@dists, $ret) if @q > 0;
}
my @sorted = sort {$a <=> $b} @dists;
print "$sorted[0]\n";
