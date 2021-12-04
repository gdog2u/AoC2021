#!/usr/bin/perl
use warnings;
use strict;

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

sub debug
{
    print "## DEBUG ##\n";
    while(my $arg = shift)
    {
        print "  $arg\n";
    }
    print "###########\n";
}

1;