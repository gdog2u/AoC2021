#!/usr/bin/perl
use warnings;
use strict;
use Data::Dumper;

require('../global.pl');

our @inputs = get_inputs();

my @calls = split(/,/, shift @inputs);

# Throw out empty line
shift @inputs;

our @boards = ();
create_boards();

# map{ print_board($_); } @boards;

# print_board($boards[0]);

# print "\n\n\n";

for(0..4){ my $call = $_; map{ mark_call($calls[$call], $_); } @boards; }

foreach my $call (@calls)
{
	map{ mark_call($call, $_); } @boards;
	if(check_for_bingo($call)){ last; }
}

# # if(check_for_bingo()){ debug("BINGO FOUND"); }
# check_for_bingo();

# Generate boards from the input
sub create_boards
{
	my $temp_board = [];
	foreach my $line (@inputs)
	{
		# Store board and empty the temp
		if($line !~ /\d/)
		{
			# debug();
			# print_board($temp_board);

			push(@boards, $temp_board);
			$temp_board = [];

			next;
		}

		my @row = split(/\s+/, $line);
		push(@{ $temp_board }, \@row);
	}
	
	push(@boards, $temp_board);
			
}

# Replace a cell on a board with an 'x' when a number is called
sub mark_call
{
	my $call = $_[0];
	my @board = @{ $_[1] };
	
	map{ map{ $_ =~ s/^$call$/x/; } @{ $_ }; } @board;
}

# Pretty print a board
sub print_board
{
	my @board = @{ $_[0] };

	for(my $i = 0; $i < 5; $i++)
	{
		for(my $j = 0; $j < 5; $j++)
		{
			print length $board[$i][$j] == 2 ? $board[$i][$j] : " ".$board[$i][$j];
			print " ";
		}
		print "\n";
	}
	
	print "\n";
}

# Check all boards for a bingo
sub check_for_bingo
{
	my $last_call = $_[0];
	my $bingo_found = 0;
	for(my $index = 0; $index < scalar @boards; $index++)
	{
		if($bingo_found){ last; }
		for(my $row = 0; $row < 5; $row++)
		{
			if($bingo_found){ last; }
			
			# Check the row for a bingo
			if(scalar grep(/^x$/, @{ $boards[$index][$row] }) == 5)
			{
				# debug("row won");
				score_board($index, $last_call);
				$bingo_found++;
				last;
			}
			
			# Check column for bingo, only on first row
			if($row == 0)
			{
				for(my $column = 0; $column < 5; $column++)
				{
					# If top cell of column isn't marked, skip to the next
					if($boards[$index][$row][$column] ne 'x'){ next; }
					
					if($boards[$index][$row + 1][$column] eq 'x' && 
					   $boards[$index][$row + 2][$column] eq 'x' && 
					   $boards[$index][$row + 3][$column] eq 'x' && 
					   $boards[$index][$row + 4][$column] eq 'x')
					{
						# debug("column won");
						score_board($index, $last_call);
						$bingo_found++;
						last;
					}
				}
				
			}
		}
	}

	return $bingo_found;
}

sub score_board
{
	my $bingo_board = $_[0];
	my $last_call = $_[1];
	my $score = 0;

	debug("Board #$bingo_board won!");

	foreach my $row (@{ $boards[$bingo_board] })
	{
		$score += eval(join('+', grep(/^\d+$/, @{ $row })));
	}

	$score *= $last_call;

	debug("Winning score: $score");
}

print "\n";

1;