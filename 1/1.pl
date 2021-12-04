#!/usr/bin/perl
use warnings;
use strict;

require('../global.pl');

my @inputs = get_inputs();

print count_increases(\@inputs);

sub count_increases
{
    my @depths = @{ $_[0] };

    my $last_depth;
    my $times_depth_increased = 0;

    foreach my $depth (@depths)
    {
        if(!$last_depth)
        {
            $last_depth = $depth;
            next;
        }

        if($depth > $last_depth)
        {
            $times_depth_increased++;
        }

        $last_depth = $depth;
    }

    return $times_depth_increased;
}