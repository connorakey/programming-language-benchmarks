#!/usr/bin/env perl

use strict;
use warnings;

sub sieve_of_eratosthenes {
    my ($n) = @_;
    return () if $n < 2;
    
    # Create boolean array
    my @primes = (1) x ($n + 1);
    $primes[0] = $primes[1] = 0;
    
    # Sieve algorithm
    for (my $i = 2; $i * $i <= $n; $i++) {
        if ($primes[$i]) {
            for (my $j = $i * $i; $j <= $n; $j += $i) {
                $primes[$j] = 0;
            }
        }
    }
    
    # Collect prime numbers
    my @result;
    for (my $i = 2; $i <= $n; $i++) {
        push @result, $i if $primes[$i];
    }
    
    return @result;
}

sub main {
    my $limit = 10000000;  # 10 million
    my @primes = sieve_of_eratosthenes($limit);
    
    print "Found " . scalar(@primes) . " primes up to $limit\n";
    print "First 10 primes: " . join(" ", @primes[0..9]) . "\n";
    print "Last 10 primes: " . join(" ", @primes[-10..-1]) . "\n";
}

main();
