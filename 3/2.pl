#!/usr/bin/perl
use warnings;
use strict;

require('../global.pl');

our @inputs = get_inputs();

# Cache the first most & least common bit
my $first_mcb = find_mcb_in_position(0);
my $first_lcb = $first_mcb ^ 0b1;

# Filter the inputs by the first of each type once, to reduce the search space
my @first_mcb_filter = grep(/^$first_mcb/, @inputs);
my @first_lcb_filter = grep(/^$first_lcb/, @inputs);

my $o2_gen_rate = find_o2_gen_rate($first_mcb, 1, \@first_mcb_filter);
my $co2_scrub_rate = find_co2_scrub_rate($first_lcb, 1, \@first_lcb_filter);

# Print solution
# debug(sprintf('%b', $o2_gen_rate));
# debug(sprintf('%b', $co2_scrub_rate));

print $o2_gen_rate * $co2_scrub_rate;

sub find_o2_gen_rate
{
	my $query = $_[0];
	my $current_bit = $_[1];
	my @search_space = @{ $_[2] };

	# print "\n\n\n";

	# debug("Step: ", $current_bit);

	if(scalar @search_space == 1){ return oct "0b".$search_space[0]; }
	elsif(scalar @search_space == 0){ die "Uh oh, you made a fucky wucky\n\tLast \$query: $query\n"; }

	my $mcb = find_mcb_in_position($current_bit, \@search_space);
		# debug($mcb);
	$query .= $mcb;

	@search_space = grep(/^$query/, @search_space);

	return find_o2_gen_rate($query, ++$current_bit, \@search_space);
}

sub find_co2_scrub_rate
{
	my $query = $_[0];
	my $current_bit = $_[1];
	my @search_space = @{ $_[2] };

	if(scalar @search_space == 1){ return oct "0b".$search_space[0]; }
	elsif(scalar @search_space == 0){ die "Uh oh, you made a fucky wucky\n\tLast \$query: $query\n"; }

	my $mcb = find_mcb_in_position($current_bit, \@search_space);
	$query .= $mcb ^ 0b1;

	@search_space = grep(/^$query/, @search_space);

	return find_co2_scrub_rate($query, ++$current_bit, \@search_space);
}



# Find the most common bit at a given index of an array of bytes
sub find_mcb_in_position
{
	my $index = $_[0];
	my @search_space;
	if(defined($_[1]))
	{
		@search_space = @{ $_[1] };
	}
	else
	{
		@search_space = @inputs;
	}

	my $word_length = length $search_space[0];
	
	my $low = 0;
	my $high = 0;
	foreach my $word (@search_space)
	{
		my $current_bit = substr($word, $index, 1);
		
		if($current_bit eq '0'){ $low++; }
		else{ $high++; }
	}

	# debug($high, $low);

	return $high == $low ? clamp($high) : clamp($high - $low);
}

print "\n";

1;