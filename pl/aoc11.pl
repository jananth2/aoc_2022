use strict; use warnings; use Data::Dump;

my @fields;
my @monkeys;
my @vis;
my $gcd = 1;

sub slurp_monkey() {
    my %monkey;

    @fields = split ' ', <STDIN>;
    $monkey{'ID'} = substr($fields[1], 0, 1);

    my @items = <STDIN> =~ /[^\s,]+/g;
    shift @items for (0..1);
    $monkey{'Items'} = \@items;

    @fields = split ' ', <STDIN>;
    shift @fields;
    map { $_ =~ s/(new|old)/\$arg/g; } @fields;
    $monkey{'OP'} = join(' ', @fields);

    $monkey{'Div'}     = (split ' ', <STDIN>)[-1];
    $monkey{'IfTrue'}  = (split ' ', <STDIN>)[-1];
    $monkey{'IfFalse'} = (split ' ', <STDIN>)[-1];
    $gcd *= $monkey{'Div'};
    push(@monkeys, \%monkey);
    my $in = <STDIN>;
}

slurp_monkey() until (eof STDIN);
for (0..9999){
    for my $m (0..@monkeys-1) {
	for my $i (@{${$monkeys[$m]}{'Items'}}) {
	    $vis[$m]++;
	    my $arg = $i;
	    eval(${$monkeys[$m]}{'OP'});
	    $arg = $arg % $gcd;
	    my $target = ${$monkeys[$m]}{($arg%(${$monkeys[$m]}{'Div'})==0) ? 'IfTrue' : 'IfFalse'};
	    push @{${$monkeys[$target]}{'Items'}}, $arg;
	}
	@{${$monkeys[$m]}{'Items'}} = ();
    }
}

@vis = sort {$b <=> $a} @vis;
my $ans = $vis[0]*$vis[1];
print "$ans\n";
