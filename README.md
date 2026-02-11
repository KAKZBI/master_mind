# Mastermind - Ruby Revision

This is my version of the Mastermind game. I first worked on this back in 2023, but I’ve recently come back to it to clean up the code, organize the files properly, and make the computer a bit smarter.

## 📺 See it in action
Since this is a terminal game, I used **asciinema** to record how it looks when you're actually playing. It's much easier than downloading the code just to see the board!

* **Playing as the Breaker:** [https://asciinema.org/a/Z80tG1lMrqlOZfc1]
* **Playing as the Maker:** [https://asciinema.org/a/785664]

## 🛠 What I did in this version
I tried to move away from just having one big file and broke things down into classes:
- **Game Logic:** Handles the turns and the "secret agent" theme.
- **Board:** Manages all those Unicode circles and colors so it looks decent in the terminal.
- **Players:** I made a Human player (me) and a Computer player.

### The "Pretended Intelligence"
I didn't want the computer to just guess randomly every time. I wrote some logic so that if the computer gets a "Red Peg" (correct color, correct spot), it remembers it for the next round. If it gets a "White Peg," it knows the color is right but tries a different position. It’s not a perfect "AI," but it feels much more like playing against a person.

## 🚀 How to run it
If you have Ruby installed:

1. Clone this repo.
2. Run `bundle install` to get the `colorize` gem.
3. Run `ruby main.rb` to start the game.

## 🚧 What's next?
The code is a lot better than it was in 2023, but I'd still like to:
- Make the computer "remember" hits from more than just the previous round.
- Maybe add a way to save the game halfway through.