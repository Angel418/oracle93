# Oracle93
## GPL3 Licensed

- Generates gematric numbers for interpretation (not unlike bibliomancy).
- Pulls random words from a list of words (currently broken).
- Shuffles and delivers complete Opening of the Key tarot spreads (working as intended - ignoring Significators).
- Currently it calls 'clear' on *nix systems, so it's not compatible with Windows. I may or may not end up re-writing it in ncurses, or otherwise modifying it so it works everywhere.

To run, run `perl oracle93.plx`.

It takes one argument:
- `perl oracle93.plx gematria` - leads you through a pseudo-random gematric number generator.
- `perl oracle93.plx magicwords`- pulls random words from a text file (used to be 
- `perl oracle93.plx ootk`- piles, divides and prints the cards (based on the Thoth tarot) for each of the five operations. No interpretations are given, or are planned to be included in the future.

Running the script with no argument leads to a menu which gives you a choice as to what you want.

93/232


