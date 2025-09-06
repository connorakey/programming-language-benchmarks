#!/usr/bin/env perl

use strict;
use warnings;

sub quicksort {
    my @arr = @_;
    return @arr if @arr <= 1;
    
    my $pivot = $arr[@arr / 2];
    my @left = grep { $_ < $pivot } @arr;
    my @middle = grep { $_ == $pivot } @arr;
    my @right = grep { $_ > $pivot } @arr;
    
    return (quicksort(@left), @middle, quicksort(@right));
}

sub main {
    my $size = 1000000;
    my @arr;
    
    srand(42);
    for (my $i = 0; $i < $size; $i++) {
        push @arr, int(rand(1000000)) + 1;
    }
    
    my @sorted = quicksort(@arr);
    
    print "First 10: ";
    for (my $i = 0; $i < 10; $i++) {
        print "$sorted[$i] ";
    }
    print "\n";
    
    print "Last 10: ";
    for (my $i = $size - 10; $i < $size; $i++) {
        print "$sorted[$i] ";
    }
    print "\n";
}

main();
