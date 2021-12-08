#!/usr/bin/perl
use warnings;
use strict;

require('../global.pl');

our @inputs = get_inputs();

# Get our key to XOR with later
my $xor_key = get_xor_key(length $inputs[0]);

# Get the gamma rate
my $gamma_rate = find_gamma_rate();
# Our epislon rate is just the inverse of the gamma rate
my $epsilon_rate = $gamma_rate ^ $xor_key;

# Print solution
print $gamma_rate * $epsilon_rate;

# Return a fully high byte to XOR with
sub get_xor_key
{
	return oct "0b".join('', ("1" x $_[0]));
}

sub find_gamma_rate
{
	my $word_length = length $inputs[0];

	my @most_common_bit = ();

	for(my $i = 0; $i < $word_length; $i++)
	{
		my $low = 0;
		my $high = 0;
		foreach my $word (@inputs)
		{
			my $curr_bit = substr($word, $i, 1);
			
			if($curr_bit eq '0'){ $low++; }
			else{ $high++; }
		}

		push(@most_common_bit, clamp($high - $low));
	}

	return oct "0b".join('', @most_common_bit);
}

print "\n";

1;