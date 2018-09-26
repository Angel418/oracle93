use strict;
use warnings;
use diagnostics;
use feature ':all';
use experimental 'smartmatch';
use List::Util qw(shuffle);



system 'cls'; # clear screen
say "Your question please:";
my $question = <STDIN>;
chomp $question;

system 'cls'; # clear screen
say "Whom would you like to ask:";
my $oracle = <STDIN>;
chomp $oracle;

# label for later if statement checking if the following 
# choice is correct

NATURE: 
# Starting with the Western Standard - The Tree of Life. There needs to be consideration whether the number itself should be used
# as simply the number of numbers generated, or whether we should use it in the RNG seed as well, and if so, should we use it straight
# or opt for a solution with magic squares, or the "Sacred Numbers" of each element.

system 'cls'; # clear screen
say "Of what nature is your question?

1 	
2 		
3 		
4 		
5 		
6 		
7 		
8 		
9 		
10 	

Please input a number between 1 and 10.\n";

# $nature is the number of answers provided, as the higher 
# planes are less complex

my $nature = <STDIN>;
chomp $nature;

# checking if choice is within 1-10 range, 
# if not, goes back to choice

if ($nature > 10 || $nature < 1 ){
	goto NATURE;
}

system 'cls'; # clear screen - windows only; need to look for a solution that'll clear the CMD line on any system.

# Turns $question and $oracle strings into ASCII numbers, 
# then sums them forming the seed of the question
# from which pseudo-random numbers are generated

my @seedarray = unpack ("C*", $question.$oracle);
my $seed = eval join '+', @seedarray;

# use generated seed and create the array into which answers will go

srand (int($seed)*$nature);
my @answers;

for (my $i = 0; $i < $nature; $i++){
	my $integer = int(rand(1500)-rand(1000));
	
	if ($integer ~~ @answers || $integer < 1){ #we want to avoid repeating numbers and negatives
		$i--; #discarding the randomized number if it's already in array or negative
		next; 
	}
	else{
		$answers[$i] = $integer;
	}
}

# nice table printout of answers - this will need to be "nicened" eventually
printf "------------------------------------------------------------\n";
printf "\tYour Question Was:\n";
printf "\t$question\n";
printf "------------------------------------------------------------\n";
printf "\tYou Asked:\n";
printf "\t$oracle\n";
printf "------------------------------------------------------------\n";

# if 1 answer, print different string
if ($nature == 1){
	printf "\tYour Answer Is:\n";
} 
else {
		printf "\tYour Answers Are:\n";
}

printf "------------------------------------------------------------\n";
for (my $i = 0; $i < $nature; $i++){
	printf "\t$answers[$i]\n";
	printf "------------------------------------------------------------\n";
}

# Connecting to a large database of number interpretations
# It'd be great to somehow find a way of analyzing/ interpreting numbers on the fly

printf "\tPlease consult Bill Heidrick's 
\tHebrew Gematria database for 
\tfurther information.

\thttp://www.billheidrick.com/works/hgemat.htm"."\n";
printf "------------------------------------------------------------\n\n";


# Magic Words is basically simplified bibliomancy - it pulls words from 
# a text file (one word per line), using a simple shuffle function. 
# I'll still need to find a way of using the previously generated seed for this.

MAGICWORDS:
printf "Would you like to see some magic words?
Please type \"yes\" or \"no\".\n\n";
my $magicwords = <STDIN>;
chomp $magicwords;

if (fc($magicwords) eq "yes"){
	HOWMANYMAGICWORDS:
	printf "How many magic words would you like?";
	my $numberofmagicwords = <STDIN>;
	chomp $numberofmagicwords; 
	if ($numberofmagicwords < 1){
		goto HOWMANYMAGICWORDS;
	}
	
	# the file with words right now is just in the same directory as the script itself, called "wordlist.txt"
	# one word per line
	
	open (IN, "<", "wordlist.txt"); 
	
	# shuffles the lines into an array; very inefficient, since the whole file is basically copied into memory (~5MB)
	# likely could be simplified more
	
	my @lines = shuffle(<IN>); 
	printf "Your magic words are:\n";
	for my $i (1 .. $numberofmagicwords){
		printf @lines[$i];
	}
}
elsif (fc($magicwords) eq "no"){
	printf "\n\nPress any key to close.\n\n";
	<STDIN>;
	exit;
}
else{
	goto MAGICWORDS;
}
