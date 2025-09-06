#!/usr/bin/env perl

use strict;
use warnings;
use bigint;

sub fibonacci {
    my ($n) = @_;
    my $a = 0;
    my $b = 1;
    
    for (my $i = 0; $i < $n; $i++) {
        my $temp = $a;
        $a = $b;
        $b += $temp;
    }
    
    return $a;
}

my $result = fibonacci(100000);
print "$result\n";
