use strict; use warnings;

my @fields;
my $x_reg = 1;
my $cycle = 0;

sub step {
    print ((($cycle) >= $x_reg-1 && ($cycle) <= $x_reg+1) ? '#' : '.');
    print "\n" if (($cycle = (++$cycle % 40)) == 0);
}

until (eof STDIN) {
    @fields = split ' ', <STDIN>; step();
    do { step(); $x_reg += $fields[1]; } if $fields[0] eq "addx";
}
