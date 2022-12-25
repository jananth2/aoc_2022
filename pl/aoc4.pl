use strict;
use warnings;

my $total = 0;
until (eof STDIN) {
    my @b = split(/[,-]+/, <>);
    $total++ if ($b[0] <= $b[2] and $b[1] >= $b[2])
      	     or ($b[2] <= $b[0] and $b[3] >= $b[0]);
}
print "$total\n"
