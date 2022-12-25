use strict;
use warnings;
use List::Util ("sum");

my $current_sum = 0;
my @top3 = ( 0, 0, 0 );

while (<STDIN>) {
    chomp;
    if ($_ eq "") {
	push(@top3, $current_sum);
	@top3 = sort{$a<=>$b}(@top3);
	shift(@top3);
	$current_sum = 0;
	next;
    }
    $current_sum += $_;
}
print sum(@top3);
