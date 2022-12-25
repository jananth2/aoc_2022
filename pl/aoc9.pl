use strict; use warnings;

my @fields;
my @knot;
my %visited;

push @knot, {x=>0, y=>0} foreach (1..10);

sub _step () {
    $knot[0]{x}++ if ($fields[0] eq "R");
    $knot[0]{x}-- if ($fields[0] eq "L");
    $knot[0]{y}++ if ($fields[0] eq "U");
    $knot[0]{y}-- if ($fields[0] eq "D");

    foreach my $i (1..9){
	if ($knot[$i-1]{x} == $knot[$i]{x} || $knot[$i-1]{y} == $knot[$i]{y}){
	    $knot[$i]{y}++ if ($knot[$i-1]{y} == $knot[$i]{y} + 2);
	    $knot[$i]{y}-- if ($knot[$i-1]{y} == $knot[$i]{y} - 2);
	    $knot[$i]{x}++ if ($knot[$i-1]{x} == $knot[$i]{x} + 2);
	    $knot[$i]{x}-- if ($knot[$i-1]{x} == $knot[$i]{x} - 2);
	} else {
	    if ($knot[$i-1]{x} > $knot[$i]{x}) {
		if ($knot[$i-1]{y} > $knot[$i]{y}) {
		    if ($knot[$i-1]{y} == $knot[$i]{y} + 2 || $knot[$i-1]{x} == $knot[$i]{x} + 2) {
			$knot[$i]{x}++;
			$knot[$i]{y}++;
		    }
		} else {
		    if ($knot[$i-1]{y} == $knot[$i]{y} - 2 || $knot[$i-1]{x} == $knot[$i]{x} + 2) {
			$knot[$i]{x}++;
			$knot[$i]{y}--;
		    }
		}
	    } else {
		if ($knot[$i-1]{y} > $knot[$i]{y}) {
		    if ($knot[$i-1]{y} == $knot[$i]{y} + 2 || $knot[$i-1]{x} == $knot[$i]{x} - 2) {
			$knot[$i]{x}--;
			$knot[$i]{y}++;
		    }
		} else {
		    if ($knot[$i-1]{y} == $knot[$i]{y} - 2 || $knot[$i-1]{x} == $knot[$i]{x} - 2) {
			$knot[$i]{x}--;
			$knot[$i]{y}--;
		    }
		}
	    }
	}
    }
    $visited{"$knot[9]{x}, $knot[9]{y}"} = 1;
}

until (eof STDIN) {
    @fields = split q{ }, <STDIN>;
    _step() for (0..$fields[1]-1);
}
my $s = keys %visited;
print "$s\n";
