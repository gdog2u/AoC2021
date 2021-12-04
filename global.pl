#!/usr/bin/perl

sub get_inputs
{
    if(!$ARGV[0])
    {
        die "Supply path to inputs";
    }

    my @lines;

    open($fh, '<', $ARGV[0]) or die "Failed to open file: $ARGV[0]";

    while(my $line = <$fh>)
    {
        push(@lines, $line);
    }

    return @lines;
}

1;