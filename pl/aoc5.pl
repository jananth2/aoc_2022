use warnings; use strict; use Data::Dump;

my ($in, @stacks);
until (($in = <STDIN>) eq "\n") {
    my @layer = split(//, $in);
    next if ($layer[1] eq "1");

    for (my ($i, $j)=(1, 0); $j < 9; $i+=4, $j++) {
	push(@{$stacks[$j]}, $layer[$i]) if ($layer[$i] ne " ");
    }
}
until (eof STDIN) {
    my @fields = split(' ', $in = <STDIN>);
    my @t = splice(@{$stacks[$fields[3]-1]}, 0, $fields[1]);
    splice(@{$stacks[$fields[5]-1]}, 0, 0, @t);
}

dd \@stacks;
