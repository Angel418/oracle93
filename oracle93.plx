use strict;
use warnings;
use diagnostics;
use feature ':all';
use experimental 'smartmatch';
use List::Util qw(shuffle);

print "Choose mode:
    1. Gematria from the aether
    2. Magic words from a list
    3. Opening of the Key (Tarot)\n";

our $mode = <STDIN>;
chomp $mode;

if ($mode == "1") {
    gematria();
}
if ($mode == "2") {
    magicwords();
}
if ($mode == "3") {
    ootk();
}
else {
    print "sorry!";
        exit;
}

sub gematria () {

system 'clear'; # clear screen
print "Your question please:";
my $question = <STDIN>;
chomp $question;

system 'clear'; # clear screen
print "Whom would you like to ask:";
my $oracle = <STDIN>;
chomp $oracle;

# label for later if statement checking if the following
# choice is correct

NATURE:
# Starting with the Western Standard - The Tree of Life. There needs to be consideration whether the number itself should be used
# as simply the number of numbers generated, or whether we should use it in the RNG seed as well, and if so, should we use it straight
# or opt for a solution with magic squares, or the "Sacred Numbers" of each element.

system 'clear'; # clear screen
print "Of what nature is your question?
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

system 'clear'; # clear screen - windows only; need to look for a solution that'll clear the CMD line on any system.

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

}

sub magicwords () {

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

}

sub ootk () {

    system 'clear';

    my @deck = ("0", "I", "II", "III", "IV", "V", "VI", "VII", "VIII", "IX", "X", "XI", "XII",
                "XIII", "XIV", "XV", "XVI", "XVII", "XVIII", "XIX", "XX", "XI",
            "1W", "2W", "3W", "4W", "5W", "6W", "7W", "8W", "9W", "10W", "PcsW", "PcW", "QW", "KW",
            "1C", "2C", "3C", "4C", "5C", "6C", "7C", "8C", "9C", "10C", "PcsC", "PcC", "QC", "KC",
            "1S", "2S", "3S", "4S", "5S", "6S", "7S", "8S", "9S", "10S", "PcsS", "PcS", "QS", "KS",
            "1D", "2D", "3D", "4D", "5D", "6D", "7D", "8D", "9D", "10D", "PcsD", "PcD", "QD", "KD");

    my @shuffle = shuffle(@deck);

    # IHVH
    print "Operation I: IHVH\n";
    print "Yod:\t";
    for (0...18) {
        print "@shuffle[$_] ";
    }
    print "\nHeh:\t";
    for (19...37) {
        print "@shuffle[$_] ";
    }
    print "\nVav:\t";
    for (38...57) {
        print "@shuffle[$_] ";
    }
    print "\nHeh:\t";
    for (58...77) {
        print "@shuffle[$_] ";
    }

    print "\n\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n";
    # Houses
    @shuffle = shuffle(@deck);

    print "Operation II: Houses\n";
    print "I:\t";
    for (0...6) {
        print "@shuffle[$_] ";
    }
    print "\nII:\t";
    for (7...13) {
        print "@shuffle[$_] ";
    }
    print "\nIII:\t";
    for (14...20) {
        print "@shuffle[$_] ";
    }
    print "\nIV:\t";
    for (21...27) {
        print "@shuffle[$_] ";
    }
    print "\nV:\t";
    for (28...34) {
        print "@shuffle[$_] ";
    }
    print "\nVI:\t";
    for (35...41) {
        print "@shuffle[$_] ";
    }
    print "\nVII:\t";
    for (42...47) {
        print "@shuffle[$_] ";
    }
    print "\nVIII:\t";
    for (48...53) {
        print "@shuffle[$_] ";
    }
    print "\nIX:\t";
    for (54...59) {
        print "@shuffle[$_] ";
    }
    print "\nX:\t";
    for (60...65) {
        print "@shuffle[$_] ";
    }
    print "\nXI:\t";
    for (66...71) {
        print "@shuffle[$_] ";
    }
    print "\nXII:\t";
    for (72...77) {
        print "@shuffle[$_] ";
    }

    print "\n\n=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=\n\n";

    # Zodiac
    @shuffle = shuffle(@deck);

    print "Operation III: Zodiac\n";
    print "Aries:\t\t";
    for (0...6) {
        print "@shuffle[$_] ";
    }
    print "\nTaurus:\t\t";
    for (7...13) {
        print "@shuffle[$_] ";
    }
    print "\nGemini:\t\t";
    for (14...20) {
        print "@shuffle[$_] ";
    }
    print "\nCancer:\t\t";
    for (21...27) {
        print "@shuffle[$_] ";
    }
    print "\nLeo:\t\t";
    for (28...34) {
        print "@shuffle[$_] ";
    }
    print "\nVirgo:\t\t";
    for (35...41) {
        print "@shuffle[$_] ";
    }
    print "\nLibra:\t\t";
    for (42...47) {
        print "@shuffle[$_] ";
    }
    print "\nScorpio:\t";
    for (48...53) {
        print "@shuffle[$_] ";
    }
    print "\nSagittarius:\t";
    for (54...59) {
        print "@shuffle[$_] ";
    }
    print "\nCapricorn:\t";
    for (60...65) {
        print "@shuffle[$_] ";
    }
    print "\nAquarius:\t";
    for (66...71) {
        print "@shuffle[$_] ";
    }
    print "\nPisces:\t\t";
    for (72...77) {
        print "@shuffle[$_] ";
    }

}
