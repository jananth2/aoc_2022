my $total;
while (<>) {
    my @t = split(" ");
    my $a = ord($t[0])-64;
    my $r = ord($t[1])-88;
    my $b = ($a+$r-2)%3+1;
    $total+=((($b-$a+1)%3)*3+$b);
}
print "${total}\n";
