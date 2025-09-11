# midnight-stealth
is a game about you trying to finish your due assignments at night while your
crazy parents are walking around the house. This is a *FNAF-esque + typing* game,
so I do apologize if your hands aren't fast enough for Midnight Stealth. Made in *Godot* for *Siege Hackathon* :)

![](https://github.com/vempr/midnight-stealth/blob/dd002d472cfec3be2e5436f5fca91c7575394f1a/assets/readme/week-2.jpg)

## How to beat MS

Your parents are walking around the house and pass through your room.
The objective is to know what to do for each enemy (spoilers):
- For DAD, you must close the door before he reaches your room
	- Also, if you fail to complete the DOG minigame, he will also kill you
- For MOM, you must open the door and shut down your laptop before she reaches your room
- You also can't keep your door closed because you will run out of oxygen

-> One game hour corresponds to one minute, so you have 6 minutes to type out your assignments

## Installation

To play online, just visit https://vempr.itch.io/midnight-stealth.

### For a local installation:

1. Clone the repository:

`git clone https://www.github.com/vempr/midnight-stealth`

2. Import the folder in Godot Game Engine

3. Done!

## Brainstorming (my personal workspace to write out ideas to execute)
### Dad/Mom AI
- fundament: dad enemy occurs more than mom enemy
- dad occurs every 30-35s, walking state for 15s, 5s reaction time/5s door has to be closed/5s walk away
- mom occurs every 70-90s, walking state for 10s, 2s reaction time/5s door has to be open/3s walk away
- maybe oxygen meter since only one threat can be present?
	- oxygen depletes after 60s, 0 to full after 30s
	- dad walks more often, so..
- ok new idea:
	- dad & oxygen are one threat
	- mom stays the same, but laptop has to be turnt off when she is looking during middle phase (5s door has to be open)

`end of notes`

## Assets & Sources
- Font from https://www.dafont.com/vcr-osd-mono.font
- Laptop from https://pngtree.com/free-png-vectors/laptop
- Laptop SFX from..
	- https://www.myinstants.com/en/instant/correct-answer-gameshow/
	- https://www.myinstants.com/en/instant/wrong-answer-gameshow/
	- https://www.myinstants.com/en/instant/windows-xp-shutdown/
	- https://www.myinstants.com/en/instant/windows-xp-startup-sound-58970/
- Dog SFX from..
	- https://pixabay.com/sound-effects/little-dog-snoring-23603/
	- https://freesound.org/people/keweldog/sounds/181767/
- Walking SFX from..
	- https://pixabay.com/sound-effects/footsteps-stairs-fast-90220/
	- https://pixabay.com/sound-effects/footsteps-in-old-house-26198/
	- https://pixabay.com/sound-effects/01-24-footsteps-rug-slippers-slow-pace-73912/
	- https://www.myinstants.com/en/instant/loud-footsteps-47200/
- Door SFX from..
	- https://pixabay.com/sound-effects/door-closed-382707/
	- https://www.myinstants.com/en/instant/door-open-sound-effect-8564/
- Jumpscare SFX from https://www.myinstants.com/en/instant/nightmare-fnaf-99968/
- Background SFX from..
	- https://www.youtube.com/watch?v=1nD3Sp_saz4
	- https://www.youtube.com/watch?v=KF1eWXwP73U
- Assignment texts from..
	- https://en.wikipedia.org/wiki/Central_limit_theorem
	- https://en.wikipedia.org/wiki/Romeo_and_Juliet
