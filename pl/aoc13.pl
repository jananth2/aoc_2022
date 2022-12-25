use strict; use warnings;

sub cmp_list {
    my $len = ($#{$_[0]}, $#{$_[1]})[$#{$_[0]} < $#{$_[1]}];
    for (0..$len) {
	my ($left, $right) = (@{$_[0]}[$_], @{$_[1]}[$_]);
	return  1 unless (defined($left));
	return -1 unless (defined($right));

	if (!ref($left) and !ref($right)) {
	    return ($left < $right) || -1  if $left != $right;
	} else {
	    $left  = [$left]  unless ref($left);
	    $right = [$right] unless ref($right);
	    my $valid = cmp_list($left, $right);
	    return $valid if $valid;
	}
    }
    return 0;
}

my @refs = ([[2]], [[6]]);
push(@refs, eval $_) while (<STDIN>);
my @sorted = sort { -cmp_list($a, $b); } @refs;

sub find_index {
    grep { cmp_list($sorted[$_], $_[0]) eq "0"; } (0 .. $#sorted);
}

my ($i2, $i6) = (find_index([[2]]), find_index([[6]]));
my $total = ($i2+1) * ($i6+1);
print "$total\n";
