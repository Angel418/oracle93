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

# giving people choices is good, but here we limit the value of the variable to 1-10.

system 'cls'; # clear screen

# turns question and oracle strings into ASCII numbers, 
# then adds them together forming the seed of the question
# from which pseudo-random numbers are generated

my @seedarray = unpack ("C*", $question.$oracle);
my $seed = eval join '+', @seedarray;

# use generated seed and initialize the array into which answers will go

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

# nice table printout of answers
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

printf "\tPlease consult Bill Heidrick's 
\tHebrew Gematria database for 
\tfurther information.

\thttp://www.billheidrick.com/works/hgemat.htm"."\n";
printf "------------------------------------------------------------\n\n";


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
	open (IN, "<", "wordlist.txt");
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

