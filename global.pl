#!/usr/bin/perl
use warnings;
use strict;

# Load the puzzle inputs into an array
# Loads the inputs from the file name supplied as first parameter
sub get_inputs
{
    if(!$ARGV[0])
    {
        die "Supply path to inputs";
    }

    my @lines;

    open(my $fh, '<', $ARGV[0]) or die "Failed to open file: $ARGV[0]";

    while(my $line = <$fh>)
    {
        chomp $line;
        push(@lines, $line);
    }

    return @lines;
}

# Print a debug notice to the console
# Allows for any number of parameters
sub debug
{
    print "## DEBUG ##\n";
    while(my $arg = shift)
    {
        print "   $arg\n";
    }
    print "###########\n";
}

# Return a value clamped between a minimum & a maximum
sub clamp
{
    my $value = $_[0];
    my $min = $_[1] || 0;
    my $max = $_[2] || 1;

    if($value < $min){ return $min; }
    if($value > $max){ return $max; }
    
    return $value;
}

1;