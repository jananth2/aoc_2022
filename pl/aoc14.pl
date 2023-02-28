use strict; use warnings;

my @lines = <STDIN>;
chomp @lines;

my ($min_x, $max_x) = (500, 500);
my ($min_y, $max_y) = (0, 0);
my @walls;

for (0..$#lines) {
    my @fields = split ' -> ', $lines[$_];

    my @wall_origin;
    for (0..$#fields) {
	my @coord = split ',', $fields[$_];
	$min_x = $coord[0] if $min_x > $coord[0];
	$max_x = $coord[0] if $max_x < $coord[0];
	# $min_y = $coord[1] if $min_y > $coord[1];
	$max_y = $coord[1] if $max_y < $coord[1];

	push(@walls, @coord);
	if (@wall_origin) {
	    my $len_x = $coord[0] - $wall_origin[0];
	    my $len_y = $coord[1] - $wall_origin[1];


	    do { push(@walls, ($coord[0]-$_, $coord[1])) for(1..$len_x-1) } if ($len_x > 0);
	    do { push(@walls, ($coord[0]+$_, $coord[1])) for(1..-$len_x-1) } if ($len_x < 0);
	    do { push(@walls, ($coord[0], $coord[1]-$_)) for(1..$len_y-1) } if ($len_y > 0);
	    do { push(@walls, ($coord[0], $coord[1]+$_)) for(1..-$len_y-1) } if ($len_y < 0);
	}
	@wall_origin = @coord;
    }
}

my $width = $max_x - $min_x + 3;
my $height = $max_y - $min_y + 1;
my $source_x = 500 - $min_x + 1;

my @grid;
push @grid, [('.') x ($width)] for (0..$height);
push @grid, [('#') x ($width)];
$grid[0][$source_x] = '+';

while (@walls) {
    my ($x, $y) = splice @walls, 0, 2;
    $x -= $min_x - 1;
    $grid[$y][$x] = '#';
}

my $done = 0;
my $ans = 0;
my ($lh, $rh) = (0, 0);

until($done) {
    my ($sp_x, $sp_y) = ($source_x, 0);
    my $blocked = 0;

    until ($blocked) {
	$lh = $height - $sp_y + 1 if ($sp_x == 0);
	$rh = $height - $sp_y + 1 if ($sp_x == ($width)-1);

	if ($grid[$sp_y+1][$sp_x] eq '.') {
	    $sp_y++;
	} elsif ($sp_x > 0 && $grid[$sp_y+1][$sp_x-1] eq '.'){
	    $sp_y++;
	    $sp_x--;
	} elsif ($sp_x < ($width - 1) && $grid[$sp_y+1][$sp_x+1] eq '.'){
	    $sp_y++;
	    $sp_x++;
	} else {
	    $done = 1 if($sp_y == 0 && $sp_x == $source_x);
	    $grid[$sp_y][$sp_x] = 'o';
	    $ans++;
	    $blocked = 1;
	}
    }
}

$ans += (($lh*($lh-1))+($rh*($rh-1)))/2;

print "\n$ans\n\n";
