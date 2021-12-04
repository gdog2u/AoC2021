#!/usr/bin/perl
use warnings;
use strict;

require('../global.pl');

my @inputs = get_inputs();

my @sums = get_sliding_window_sums(\@inputs);

print count_increases(\@sums);

sub count_increases
{
    my @array = @{ $_[0] };

    my $last_value;
    my $times_value_increased = 0;

    foreach my $value (@array)
    {
        if(!$last_value)
        {
            $last_value = $value;
            next;
        }

        if($value > $last_value)
        {
            $times_value_increased++;
        }

        $last_value = $value;
    }

    return $times_value_increased;
}

sub get_sliding_window_sums
{
    my @array = @{ $_[0] };
    my $window_size = $_[1] || 3;
    my @sums;
    my $stepper = 1;

    my $final_index = ((scalar @array) - $window_size)+1;

    for(my $i = 0; $i < $final_index; $i++)
    {
        my $window_sum = 0;
        for(my $j = 0; $j < $window_size; $j++)
        {
            $window_sum += $array[$i + $j];
        }

        push(@sums, $window_sum);
        
        if(0)
        {
            print "$stepper) $window_sum \n";
            if($stepper == 2) { exit; }
            $stepper++;
        }
    }

    return @sums;
}