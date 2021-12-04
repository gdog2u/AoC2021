#!/usr/bin/perl
use warnings;
use strict;

require('../global.pl');

our @inputs = get_inputs();

our %vector = (
    'x' => 0,
    'y' => 0
);

plot_course();

print "Current Coordinates are X: $vector{x} Y: $vector{y}\n";
print "Multiplied: ".($vector{'x'} * $vector{'y'});

sub plot_course
{
    my %directions = (
        'forward' => sub { $vector{'x'} += $_[0]; },
        'down'    => sub { $vector{'y'} += $_[0]; },
        'up'      => sub { $vector{'y'} -= $_[0]; },
    );

    foreach my $command (@inputs)
    {
        my ($direction, $units) = split(/ /, $command);

        $directions{$direction}($units);
    }
}

1;