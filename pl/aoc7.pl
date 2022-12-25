use warnings; use strict; use List::Util "min";

my ($line, @curr, $key, %seen, $size);
until (eof STDIN) {
    my @chars = split(' ', $line = <STDIN>);
    if ($line eq "\$ cd ..\n") {
	$size = $seen{$key};
	pop(@curr);
	$key = join('/', @curr);
	$seen{$key} += $size;
    } elsif ($chars[0] eq "\$" and $chars[1] eq "cd"){
	push(@curr, $chars[2]);
	$key = join('/', @curr);
	$seen{$key} = 0;
    } elsif ($chars[0] ne "\$" && $chars[0] ne "dir") {
	$seen{$key} += $chars[0];
    }
}

until (@curr == 1) {
    $size = $seen{$key};
    pop(@curr);
    $key = join('/', @curr);
    $seen{$key} += $size;
}

my $need = $seen{"\/"} - 40000000;
my $ans = "inf";
for (keys %seen) {
    $ans = min($seen{$_}, $ans) if ($seen{$_} > $need);
}

print "$ans\n";
