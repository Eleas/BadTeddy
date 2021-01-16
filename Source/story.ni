"Bad Teddy" by "Y'Gael of Atrii"
this is a subtitle.

[NOTE:
I am not yet done commenting this code. It starts out organized, then  degenerates near the end into a working but scrambled mess of stuff. I will continue to clean it up, but I figured posting what I have would be better than nothing, and I can tell the cleanup will be a process. Pardon the dust, and enjoy the ride.]


Chapter 1 - Luck and Abstractions
[We want an environment that is random enough to make things difficult for the player, but also plausible in terms of a house layout. In this chapter I:

1. Create a system of luck based on rolling a D20 with an advantage given to the player when they engage in activities that increase their LUCK
2. Create several plausible layouts for items in the house that present greater or lesser challenges based on a roll of the die.
3. Create an indexing system for this layout so that DAD can return any items that the player moves out of position to their original location.]

[Dad is always looking for things that need to be put away.  In order to make this possible, we must set the STARTING POSITION of every moveable item in the house.]

a thing has a room called the starting position.

[Some things in the house are always set up the same way, regardless of how lucky you are.Note that the supporters need special code to identify their starting position. I can't remember why, but I know that it won't work unless I do this.]
to default set up:
	now mom is in a random room that is not nothing;
	now Teddy is in a random room that is not nothing;
	now bobby is in a random room that is not nothing;
	now dad is in a random room that is not nothing;
	now chaser is in a random room that is not nothing;
	now the step stool is in a random room that is not nothing;
	now the starting position of the step stool is the location of the step stool;
	now the high chair is in a random room that is not nothing;
	now the starting position of the high chair is the location of the high chair;
	now the ball is in the dog bed;
	now the dog bed is in a random room that is not nothing;
	now the starting position of the ball is the location of the dog bed;
	if a random chance of 1 in 2 succeeds:
		now the hamper is in the laundry room;
	otherwise:
		now the hamper is in the Your Bedroom;
	if the lucky boxers are dirty:
		now the starting position of the boxers is the location of the hamper;
	otherwise if the lucky boxers are wet:
		now the starting position of the lucky boxers is the laundry room;
	otherwise if the lucky boxers are dry and the lucky boxers are clean:
		now the boxers are in the drawers;
		now the starting position of the lucky boxers is the Your Bedroom;
		

[Other things in the house are set up in advantageous or disadvantageous ways based on a D20 roll with no advantage]
to set up with crit good luck:
	now the ball is carried by chaser;
	now the lucky boxers are in the drawers;
	now the lucky boxers are dry;
	now the lucky boxers are clean;
	
to set up with good luck:
	now the lucky boxers are in the dryer;
	now the lucky boxers are wet;
	now the lucky boxers are clean;

to set up with ok luck:
	now the lucky boxers are in the washer;
	now the lucky boxers are clean;
	now the lucky boxers are wet;
	
to set up with normal luck:
	now the lucky boxers are in the washer;
	now the lucky boxers are dirty;
	now the lucky boxers are dry;
	
to set up with bad luck:
	now the lucky boxers are in the hamper;
	now the lucky boxers are dirty;
	now the lucky boxers are dry;
	
to set up with crit bad luck:
	now the lucky boxers are carried by chaser;
	now the lucky boxers are dirty;
	now the lucky boxers are dry;
	
when play begins:
	default set up;
	say "[line break]DEBUG: default set up.";
	if DICE is greater than 19:
		set up with crit good luck;
		say "[line break]DEBUG: crit good luck setup.";
	otherwise if DICE is greater than 16:
		set up with good luck;
		say "[line break]DEBUG:  good luck setup.";
	otherwise if DICE is greater than 13:
		set up with ok luck;
		say "[line break]DEBUG: ok luck setup.";
	otherwise if DICE is greater than 9:
		set up with normal luck;
		say "[line break]DEBUG: normal luck setup.";
	otherwise if DICE is greater than 1:
		set up with bad luck;
		say "[line break]DEBUG: bad luck setup.";
	otherwise:
		set up with crit bad luck;
		say "[line break]DEBUG: crit bad luck setup.";
	let T be the list of things;
	repeat with item running through T:
		now the starting position of item is the location of item;
		say "[item] starts in [the starting position of item].";
		
[Besides "normal" luck which is executed above, the player can also be extra lucky. This happens if the player wears the lucky boxers while they are dry and clean, for example, but we can use it for anything we like.]

[The player begins with neutral luck]
LUCK is a number that varies. LUCK is 0.

[A D20 roll is used for most random events in the house, with an advantage of LUCK]
to decide which number is DICE:
	let RAND be a random number between 1 and 20;
	increase RAND by LUCK;
	if RAND is at least 20:
		decide on 20;
	otherwise:
		decide on RAND;

[We can use the D20 roll directly to vary the consequences for different rolls, or we can just decide if a "check" roll of a given difficulty succeeds, as shown below]
To decide if a dice roll of difficulty (N - number) succeeds:
	if DICE is greater than N:
		decide yes;
	otherwise:
		decide no;


[The Vicinity and co-location-------------------------]

[This game needs to make a lot of decisions about whether things are in the location of the player or not. I discovered that if the player is on a supporter, the player is no longer in the location of the player (or the location of the player is no longer a room, I'm not sure), which I previously thought was impossible. I also learned that anything else that is in or on something is also not in the location, even if it is in the same room. We fix this by referring to the following two other concepts in our code instead of "the location" whenever possible]		


To decide which room is the vicinity of (X - thing):
	if X is on a supporter (called the target):
		decide on the location of the target;
	otherwise if X is in a container (called the trap):
		decide on the location of the trap;
	otherwise if X is carried by the player:
		decide on the location of the player;
	otherwise:
		decide on the location of X;
		
To decide if (X - a thing) is co-located with (Y - a thing):
	if the location of X is the location of Y:
		yes;
	otherwise if X is on a supporter (called the target) and the target is in the location of Y:
		yes;
	otherwise if Y is on a supporter (called the target) and the target is in the location of X:
		yes;
	otherwise if X is carried by Y:
		yes;
	otherwise if Y is carried by X:
		yes;
	otherwise:
		no;

		
Chapter 2 - Persons, places, things
[In this chapter, we define everything on the most basic level, simply making them exist. Later, we will give them more interesting features.]

The dog bed is a fixed in place enterable supporter.

Instead of taking a dog bed:
	say "No, Chaser likes his bed in here.";
	
Dad is a person. Dad is in the Your Bedroom.

Chapter 3 - Behaviors
[The house is designed to have only a few dead ends, with many possible paths for our randomized characters to wander around. The goal is to create a map where it is possible to give Teddy the slip while also restricting the travel options of both Teddy and the player when they go into certain rooms]


[Chasing--------------------------------------]
[Sometimes, we want a character to go somewhere on purpose, like if they are following the player from room to room, or fetching the vacuum from the hall closet. Whenever a character is going somewhere with a purpose, we call this chasing]

	
	
[Chase]
To have (P - thing) chase to (R - room):
	let the path be the best route from the location of P to R, using doors;
	if P is Teddy:
		if the path is salted:
			do nothing; [ I have not tested this code yet, and I don't know what will happen if Teddy gets trapped in a salted room with only salted rooms adjacent to him. There may be some redundant code here that needs to be removed.]
		otherwise:
			if the path is not nothing, silently try P going the path;
	otherwise:
		if the path is not nothing, try P going the path;



[Wandering-------------------------------------]
[Other times, we want a character to aimlessly walk around the map. We call this wandering.]

To have (P - thing) wander:
	let the path be the best route from the location of P to a random room adjacent to P;
	if P is Teddy:
		let the saltless path be the best route from the location of P to a random unsalted room adjacent to P;
		if the saltless path is not nothing:
			silently try P going the saltless path;
		otherwise:
			do nothing;
			say "[line break]DEBUG: Teddy cant find a path to a saltless room. Is he surrounded by salt?";
	otherwise:
		try P going the path;
	say "DEBUG: [P] wanders to [the location of P]";

[We can also have things evade the player, going to random rooms specifically away from them]			
To have (P - thing) evade:
	let R be the list of rooms adjacent to P;
	remove the location from R, if present;
	sort R in random order;
	let T be entry 1 of R;
	move P to T;


[Dad-----------------------------------------]
[Dad uses DADVISION to identify anything around him which is not in its starting location. He cannot see what is carried by the player, but if the player alters their environment in any visible way, Dad will fix it. Most noteably, dad pushes a pushable supporter (used to reach the light switches) back to whichever room they randomly started in.]

[NOTE: Dad's code is buggy (I think?). Feel free to experiment with him, especially when it comes to the lucky boxers.]

DADVISION is a list of things that varies.

to have dad take a turn:
	if dad randomly decides to act:
		say "[line break]DEBUG: dadvision is empty";
		let D be the list of things in the vicinity of Dad;
		say "[line break]DEBUG: dad is looking for things";
		if D is not empty:
			repeat with item running through D:
				if item is not in the starting position of item and item is not scenery and item is not a family member and item is not teddy and item is not the player and item is not entry 1 of dadvision:
					add item to DADVISION, if absent;
					say "[line break]DEBUG:adding [item] to DADVISION if absent";
					say "Dad notices that the [item] is out of place.[line break][quotation mark]What's this doing here? I'll put it away.[quotation mark]";
					say "[line break]DEBUG: the stating position of [item] is [the starting position of item]";
					if item is not a supporter:
						try dad taking item;
		if DADVISION is not empty:
			let E be entry 1 of DADVISION;
			if E is not a supporter:
				have Dad chase to the starting position of E;
				say "[line break]DEBUG: Dad is chasing to put away [E]";
				if Dad is in the starting position of E:
					if the location of dad is dark:
						have dad turn on the lights;
					remove E from DADVISION, if present;
					if the starting position of E is the location of the cabinet:
						try dad inserting E into the cabinet;
						now the starting position of E is the location of the cabinet;
					if E is the ball:
						try dad inserting E into the dog bed;
					otherwise if E is the lucky boxers:
						if the lucky boxers are dirty:
							try dad inserting the lucky boxers into the hamper;
						otherwise if the lucky boxers are wet:
							try dad opening the dryer;
							try dad inserting the lucky boxers into the dryer;
							try dad closing the dryer;
						otherwise if the lucky boxers are in the dryer:
							try dad opening the dryer;
							try dad taking the lucky boxers;
							try dad closing the dryer;
						otherwise if the lucky boxers are clean and the lucky boxers are dry:
							try dad inserting the lucky boxers into the drawers;
					otherwise:
						try Dad dropping E;
			otherwise:
				let the path be the best route from the location of E to the starting position of E;
				try dad pushing E to the path;
				if E is in the starting position of E:
					remove E from DADVISION;
		otherwise:
			have dad wander;
			
[Bobby--------------------------]
[Bobby is your older brother. He wants to play with you, wasting your time while Teddy does the dirty business. His code is still pretty buggy. He wants to play the "miss mary mack" hand clap game with you.]



Mary Mack is a recurring scene.
Mary Mack begins when the player is in the location of bobby and the location of bobby is lit and bobby randomly decides to act.

clap-count is a number that varies. clap-count is initially 0.

Mary Mack ends when clap-count is 7 or the location of bobby is dark;

Every turn during Mary Mack:
	if the location is lit: [this line of code should be redundant- consider removing]
		say rhyme;
		
Playing with is an action applying to one thing.
understand "play with [something]" as playing with.

When Mary Mack ends:
	now the clap-count is 0;
	if the location is dark:
		say "Bobby: [quotation mark]Hey! Who turned off the lights?[quotation mark]"
		
instead of doing something other than playing with bobby during Mary Mack:
		complain;

After playing with bobby while Mary Mack is happening:
	if clap-count is 0:
		increment the clap-count;
	otherwise if clap-count is 1:
		say "You: [quotation mark]all dressed in black, black, black...[quotation mark]";
		increment the clap-count;
	otherwise if clap-count is 2:
		say "You: [quotation mark]all down her back, back, back...[quotation mark]";
		increment the clap-count;
	otherwise if clap-count is 3:
		say "You: [quotation mark]for fifteen cents, cents, cents...[quotation mark]";
		increment the clap-count;
	otherwise if clap-count is 4:
		say "You: [quotation mark]jump over the fence, fence, fence... [quotation mark]";
		increment the clap-count;
	otherwise if clap-count is 5:
		say "You: [quotation mark]he reached the sky, sky, sky...[quotation mark]";	
		increment the clap-count;
	otherwise if clap-count is 6:
		say "You continue the rhyme: [quotation mark]'till the fourth of July, -ly, -ly[quotation mark]";
		increment the clap-count;

			
to say rhyme:
	if clap-count is 0:
		say "Bobby looks at you expectantly.[line break]Bobby:[quotation mark]Play the hand clap game with me![quotation mark]";
	otherwise if clap-count is 1:
		say "Bobby: [quotation mark]Miss Mary Mack, Mack, Mack...[quotation mark]";
	otherwise if clap-count is 2:
		say "Bobby: [quotation mark]with silver buttons, buttons, buttons...[quotation mark]";
	otherwise if clap-count is 3:
		say "Bobby: [quotation mark]She asked her mother, mother, mother...[quotation mark]";
	otherwise if clap-count is 4:
		say "Bobby: [quotation mark]to see the elephant, elephant, elephant...[quotation mark]";
	otherwise if clap-count is 5:
		say "[quotation mark]he jumped so high, high, high...[quotation mark]";
	otherwise if clap-count is 6:
		say "Bobby: [quotation mark]and he didn't come back, back, back...[quotation mark]";
		
to complain:
	say "Bobby gives you an angry look. [line break] Bobby:[quotation mark]No! You have to play with me![quotation mark]";
[Teddy----------------------------------]

Teddy is a thing. 

[I honestly can't remember why I made this and I may delete this code]
Teddy has a number called boldness. boldness is usually 0.

[This next bit of code makes Teddy get faster over time, and periodically intimidate you]

when play begins:
	hope fades in 20 turns from now;
	hope fades  in 40 turns from now;
	hope fades in 50 turns from now;
	hope fades in 60 turns from now;

at the time when hope fades:
	increase the boldness of Teddy by 1;
	now the left hand status line is "I'M";
	now the right hand status line is "COMING";

	
[I have no idea why I made this next bit and I will probably delete it]
a thing can be hidden or exposed. A thing is usually exposed. Teddy is hidden.[change this to happen when it needs to later]

[Teddy is hidden in the room, even when present. You cannot see him by looking for him, but he makes his presence known in other ways]
Before listing nondescript items:
	if Teddy is not carried by the player and Teddy is hidden:
		now Teddy is not marked for listing;
		
		
[TEDDY'S TURN--------------------------------]
[Teddy doesn't want to be seen when he kills. He always turns the lights off first, will always kill someone else first if there are two people in a room, and he always leaves if there are more than two people in a room. He will sometimes secretly jump into your inventory before he kills you, which makes it easy for him to follow you from room to room turning off the lights until he is discovered and discarded. You can also use inventory items on Teddy when this happens, but we will get to that later.]

To have Teddy take a turn:
	if the location of Teddy is salted or Teddy is carried by the player and the location of the player is salted:
		have Teddy wander;
		say "[line break]DEBUG: evading salt";
	let T be the list of people in the location of Teddy;
	let R be the list of supporters in the location;
	repeat with stool running through R:
		if the player is on stool:
			add the player to T;		
	now the speed of Teddy is SPEED;
	if Teddy randomly decides to act:
		say " [line break]DEBUG: teddy acts";
		if the number of entries in T is 1:
			if entry 1 of T is the player:
				if the location of Teddy is lit:
					if Teddy is carried by the player:
						have Teddy turn off the lights;
					otherwise if Teddy is not carried by the player:
						now Teddy is carried by the player;
				otherwise if the location of Teddy is dark:
					if Teddy is carried by the player:
						if a dice roll of difficulty 15 succeeds:
							now the left hand status line is "I[quotation mark]M";
							now the right hand status line is "HERE";
						otherwise:
							have Teddy kill the player;
					otherwise if Teddy is not carried by the player:
						now Teddy is carried by the player;					
			otherwise:
				if the location of Teddy is lit:
					have Teddy turn off the lights;
				otherwise if the location of Teddy is dark:
					have Teddy kill entry 1 of T;	
		otherwise if the number of entries in T is 2:
			if the location of Teddy is lit:
				if Teddy is carried by the player:
					have Teddy turn off the lights;
				otherwise if Teddy is not carried by the player:
					if a dice roll of difficulty 10 succeeds:
						have Teddy turn off the lights;
					otherwise:
						now Teddy is carried by the player;
						if a dice roll of difficulty 15 succeeds:
							now the left hand status line is "HUG";
							now the right hand status line is "ME";
						otherwise:
							have teddy turn off the lights;
			otherwise if the location of Teddy is dark:
				if Teddy is carried by the player:
					have Teddy kill entry 2 of T;
				otherwise:
					have Teddy kill entry 2 of T;
		otherwise:
			if the location of Teddy is lit:
				if a dice roll of difficulty 10 succeeds:
					have Teddy wander;
				otherwise:
					have Teddy turn off the lights;
			otherwise if the location of Teddy is dark:
				have Teddy wander; [this used to be "have teddy chase to the location" but  this would mean that when teddy is alone in a dark room, he knows where you are. Only change this back to "chase" if you find that the game is too easy.]
				
[MOM--------------------------------------------]

[Mom is a complex character. This requires some explanation of the code we see later. 

The previous code has made reference to rooms being salted. The character can use the salt shaker to salt the floors in a room. Because Teddy is haunted, this prevents Teddy from being able to enter that room (hints will be placed in the game for this later). The salt shaker has enough salt to protect three rooms. When a room is salted however, if mom finds it, she will vacuum it. She will do this by fetching the vacuum from the closet, going to whichever salted room she finds, and vacuuming it up, then putting the vacuum back. If she catches the player pouring salt on a rug, or if she cannot find the vacuum in the closet and then, upon searching for it, discovers it in the player's posession, she will put the player in time-out. The player is taken to their bedroom and must stay there for 10 turns until they are freed again. As of writing this comment, Mom's code works great, but because it is so complex, it is delicate code. Be careful editing this.]

Mom is a person.

to have mom light-police:
	say "[line break]DEBUG: mom is light-policing";
	if the location of mom is dark:
		if the player is in the location of mom or the player is on a supporter in the location of Mom:
			say "[quotation mark]Who keeps turning off the lights?[quotation mark][line break]Exasperated, Mom switches on the lights.";
		have mom turn on the lights;

momvision is a list of rooms that varies.

to have mom locate salt:
	say " [line break]DEBUG: mom is locating salt";
	if the location of mom is salted:
		add the location of mom to momvision, if absent;
		repeat with foo running through momvision:
			say "mom sees the salt in [foo][line break]";
		if the vacuum is carried by mom:
			now mom is vacuum-doing;
			say "mom is vacuum-doing[line break]";
		otherwise if mom is vacuum-neutral:
			now mom is vacuum-fetching;
			say "mom is vacuum-fetching[line break]";
		otherwise if mom is vacuum-seeking:
			say "mom is vacuum-seeking[line break]";
		otherwise if mom is vacuum-neutral:
			say "mom is vacuum-neutral[line break]";


to have mom fetch the vacuum:
	say "mom is fetching the vacuum [line break]";
	let the path be the best route from the location of mom to the small hall;
	if the path is not nothing and mom is not in the small hall: 
		try mom going the path;
	otherwise if mom is in the small hall:
		try mom opening the hall closet;
		if the vacuum is in the hall closet:
			try mom taking the vacuum cleaner;
			now mom is vacuum-doing;
			say "mom is vacuum-doing[line break]";
		otherwise if the vacuum is not in the hall closet and the vacuum is not carried by mom:
			say "Mom: Where is the vacuum cleaner?";
			now mom is vacuum-seeking;
			say "mom is vacuum-seeking. [line break]";
		try mom closing the hall closet;

mom can be vacuum-neutral, vacuum-fetching, vacuum-seeking, vacuum-returning, or vacuum-doing. Mom is vacuum-neutral.

the Your Bedroom can be either confined or free. The Your Bedroom is free.
		
to have mom seek the vacuum:
	if the vacuum is in the vicinity of mom or the vacuum is carried by the player:
		if the vacuum is carried by the player:
			say "You took my vacuum cleaner!";
			say "Mom takes the vacuum from you and puts you in time-out";
			[now the player is in the dummy bedroom;]
			now the player is in the your bedroom;
			now the your bedroom is confined;
		now the vacuum is carried by mom;
		now mom is vacuum-doing;
		say "mom is vacuum-doing[line break]";
	otherwise:
		have mom wander;

to have mom vacuum:
	let the mess be entry 1 of momvision;
	let the path be the best route from the vicinity of mom to the mess;
	if the path is not nothing:
		try mom going the path;
	if mom is in the mess:
		now the mess is unsalted;
		if the mom is enclosed by the vicinity of the player:
			say "BRRR! Mom vacuums the salt off of the floor.";
		otherwise:
			say "BRRR! You hear the distant sound of the vacuum cleaner.";
		now the location of mom is unsalted;
		remove the location of mom from momvision, if present;
	if momvision is empty:
		now mom is vacuum-returning;
	[otherwise:
		now mom is vacuum-doing; This code should be uneccessary]

to have mom return the vacuum:
	say "mom is returning the vacuum[line break]";
	let the path be the best route from the vicinity of mom to the vicinity of the hall closet;
	if the path is not nothing:
		try mom going the path;
	if mom is in the vicinity of the hall closet:
		try mom opening the hall closet;
		try mom inserting the vacuum into the hall closet;
		try mom closing the hall closet;
		now mom is vacuum-neutral;
	
to have mom take a turn:
	if mom randomly decides to act:
		have mom light-police;
		have mom locate salt;
		if mom is vacuum-neutral:
			have mom wander;
		otherwise if mom is vacuum-fetching:
			have mom fetch the vacuum;
		otherwise if mom is vacuum-seeking:
			have mom seek the vacuum;
		otherwise if mom is vacuum-returning:
			have mom return the vacuum;
		otherwise if mom is vacuum-doing:
			have mom vacuum;
			
			
[CHASER-----------------------------------------]
[Chaser, the family dog, helps the player locate Teddy with the help of his ball, which always begins in the dog bed- first dropped in a randomized location. He also steals the lucky boxers, which have their own set of properties]


the speed of chaser is 30.
			
Chaser is a person.
the description of chaser is "That's Chaser, the family dog.[if the lucky boxers are carried by chaser]He currently chewing on your lucky boxers.[otherwise if the ball is carried by chaser]He is carrying a rubber ball in his mouth.".

to have chaser protecc:
	if the the player is in the vicinity of Teddy:
		say "Chaser finds Teddy! He grabs him in his teeth!";
		now Teddy is carried by chaser;
		have chaser evade;
		have chaser evade;
		now Teddy is in the location of chaser;
		
to have chaser sniff:
	let T be a random thing in the vicinity of chaser;
	if T is not Teddy:
		say "Chaser sniffs [T] curiously";	
	otherwise if T is Teddy and Teddy is carried by the player:
		say "Chaser sniffs [T ]curiously";	
		say "GRRR!";
	otherwise if T is Teddy:
		have chaser alert;

throwing to is an action applying to two visible things. Understand "throw [something] [direction]" as throwing to.

Definition: a direction (called thataway) is viable if the room 
  thataway from the location is a room.

Check throwing to:
	let D be the second noun;
	if D is viable:
		now the salt is in the location;
		silently try the noun going D;
		say "You throw [the noun] to [the second noun]";
		if the noun is the salt shaker:
			now the location of the salt shaker is salted;
			now the salt shaker is saltless;
			now the printed name of the salt shaker is "broken salt shaker";
		otherwise if the noun is the ball:
			if chaser is in the location:
				say "[line break]Chaser bounds after the ball, tail wagging.";
				now Chaser is in the location of the ball;
				if chaser carries the lucky boxers:
					try chaser dropping the lucky boxers;		
	otherwise:
		now the noun is in the location;
		if the noun is throwable and the noun is not the salt shaker and the noun is not the rubber ball:
			say "[the noun] bounces harmlessly off the wall.";
		otherwise if the noun is the rubber ball:
			if chaser is in the location:
				if the lucky boxers are carried by chaser:
					try chaser dropping the lucky boxers;
					say "Chaser catches the rubber ball in mid air. He drops it at your feet and looks at you expectantly.";
			otherwise:
				say "[the noun] bounces harmlessly off the wall.";
		otherwise if the noun is the salt shaker:
			say "The salt shaker slams into the wall and breaks, spilling all of it's contents.";
			now the location is salted;
			now the salt shaker is saltless;
			now the printed name of the salt shaker is "broken salt shaker";
		otherwise:
			say "[the noun] isn't suitable for throwing.";

a thing can be throwable. A thing is usually not throwable.
the rubber ball is throwable. the salt shaker is throwable.
		
the rubber ball is a thing. The rubber ball is carried by chaser;

to have chaser ball beg:
	say "Chaser bounds up to you with a rubber ball in his mouth.";
	try chaser dropping the ball;
	say "He looks up at you expectantly, tail wagging.";
	continue the action;
	
doggy time is a recurring scene. doggy time begins when the player is in the location of chaser and the ball is carried by chaser.

when doggy time begins:
	if the ball is carried by chaser:
		have chaser ball beg;
	otherwise if chaser carries the lucky boxers:
		have chaser boxer guard;
	
to have chaser boxer guard:
	say "Chaser is happily chewing on your lucky boxers.";

instead of taking the lucky boxers when the lucky boxers are carried by chaser:
	say "GRRR![line break]Chaser refuses to give up your lucky boxers.";
	
doggy time ends when the time since the doggy time began is 2 minutes.

to have chaser take a turn:
	if the ball is in the location of chaser:
		if the lucky boxers are carried by chaser:
			try chaser dropping the lucky boxers;
		try chaser taking the ball;
	otherwise if the lucky boxers are in the location of chaser:
		if the ball is carried by chaser:
			try chaser dropping the ball;
		try chaser taking the lucky boxers;
	if chaser randomly decides to act:
		if a random chance of 1 in 2 succeeds:
			have Chaser wander;
			say "DEBUG: Chaser is wandering to [the location of chaser]";
		otherwise:
			if the player is in the location of chaser:
				let RAND be a random number between 1 and 4;
				if the player is not in the vicinity of Teddy:
					if RAND is 1:
						say "Chaser uses his hind leg to scratch his ear.";
					otherwise if RAND is 2:
						say "Chaser rolls on his back, exposing his belly.";
					otherwise if RAND is 3:
						if chaser is carrying nothing:
							say "Chaser trots up to you, and gives you a friendly lick on the cheek.";
						otherwise:
							say "Chaser is chewing happily on your lucky boxers.";
					otherwise if RAND is 4:
						say "Chaser chases his tail for a moment, then lazily slumps in the corner.";
				otherwise if the player is in the vicinity of Teddy:
					if chaser is in the location:
						if RAND is 1:
							have chaser sniff;
						otherwise if RAND is 2:
							have chaser alert;
						otherwise if RAND is 3:
							if a dice roll of difficulty 13 succeeds:
								have chaser protecc;
							otherwise:
								have chaser alert;
				otherwise if chaser is in the vicinity of Teddy:
					if a dice roll of difficulty 13 succeeds:
						say "You hear the distant sound of Chaser barking furiously.";
		
to have chaser alert:
	if a random chance of 1 in 2 succeeds:
		say "Chaser is circling the room. [line break][quotation mark]BARK BARK![quotation mark]";
	otherwise: 
		say "Chaser sniffs around the room furiously.";	
		
After the player taking off the lucky boxers:
	decrease LUCK by boxer power;
	say "DEBUG: luck= [LUCK][line break]";
		
the dry cycle is a recurring scene. The dry cycle begins when the button is switched on.

				
Chapter 4 - Turns
[The house operates on a turn-based system, whereby every turn each actor has an opportunity to do something. The SPEED of a character determines how likely they are to act on a given turn. It can be interpreted as a percentage. A character with a speed of 10 has a 10% chance of acting every turn, for example.]

[Speed-----------------------------------------]

A thing has a number called the speed.
the speed of Mom is 50.
The speed of Chaser is 30.
The speed of Dad is 20.
The speed of Bobby is 30.
[NOTE: Bobby decides to act using a different system than the others.]

[the macro variable SPEED refers only to Teddy's speed. This is different from the "speed of Teddy", which is an irrelevant value, unlike the speed of mom, dad, etc.. I did this because I wanted Teddy to get faster or slower as things happen in the game and I couldn't figure out how to do this with a number belonging to a thing. I may change the name of this variable to T-SPEED later or something similar to disambiguate Teddy's speed from others.]

To decide which number is SPEED:
	Let S be 15;
	Let ABSENT be the number of people who are nowhere;
	increase S by ABSENT * 2;
	Let DARK be the number of rooms which are dark rooms;
	increase S by DARK * 2;
	let BOLD be the boldness of Teddy;
	increase S by BOLD * 3; [Teddy gets bolder when hope fades]
	if a dice roll of difficulty 15 succeeds [teddy "stumbles" this turn, 75% of the time when the player has no luck advantage]:
		decrease S by 3;
	if salty bear is true:
		decrease S by 3;
	decide on S;
		
[Movement---------------------------------------]
[Characters do not act on every turn, but they are more likely to act on any given turn if they are faster]
To decide if (O - something) randomly decides to act:
		let S be the speed of O;
	decide on whether or not a random chance of S in 100 succeeds;
	
[Turns---------------------------------------------]
Every turn:
	now the left hand status line is "[the player's surroundings]";
	now the right hand status line is "[time of day]";
	if dad is not nowhere:
		have dad take a turn;
	if chaser is not nowhere:
		have chaser take a turn;
	if mom is not nowhere:
		have mom take a turn;
	if Teddy is not nowhere:
		have Teddy take a turn;
	say "[line break] DEBUG: Teddy is in [the location of teddy]";
	say "[line break] DEBUG: Chaser is in [the location of Chaser]";
	say "[line break] DEBUG: Dad is in [the location of Dad]";
	say "[line break] DEBUG: Bobby is in [the location of Bobby]";

Chapter 5 - Things with Properties and Associated Actions

[Lights-------------------------------------------]
[The lights are important, because Teddy can only kill you when the lights are off. You are too short to reach the lightswitches on your own, but you can do so with the help of a supporter that is pushable between rooms.]

[Every room has a light switch by the same name. Thus:]
The light switch is a backdrop. The light switch is everywhere.

understand "lights" as light switch.

instead of the player switching on a light switch:
	if the the player is on a supporter:
		have the player turn on the lights;
	otherwise if the player is not on a supporter:
		say "You're too small to reach it.";		

instead of the player switching off a light switch:
	if the the player is on a supporter:
		have the player turn off the lights;
	otherwise if the player is not on a supporter:
		say "You're too small to reach it.";

[The player can always see the light switch and a supporter used for reaching it, even in the dark]
After deciding the scope of the player when the location is a dark room:
	place the light switch in scope;
	place the step stool in scope;

visibility rule when in darkness:
	if doing something to the light switch:
		there is sufficient light;
	if doing something to a supporter:
		there is sufficient light;

[Making an action for switching on a light switch would only be useful if I had a single such device in every room. Instead, I used the backdrop method and use this code to do it]
To have (P - thing) turn on the lights:
	if the vicinity of P is dark:
		now the vicinity of P is lit;
		if the player is in the vicinity of P:
			say  "[quotation mark]Click.[quotation mark] [line break]The lights go on.";
	otherwise if the vicinity of P is lit:
		if the player is P:
			say "The lights are already on.";
 
To have (P - thing) turn off the lights:
	if the vicinity of P is lit:
		now the vicinity of P is dark;
		if the player is in the vicinity of P:
			say  "[quotation mark]Click.[quotation mark] [line break]The lights go off.";
	otherwise if the vicinity of P is dark:
		if the player is P:
			say "The lights are already off.";


	
	
[time out]
[the dummy bedroom is a room with the printed name "Bedroom".
Time-out is a recurring scene. time-out begins when the player is in the dummy bedroom.
Time-out ends when the time since time-out began is 10 minutes.
When time-out begins:
	if Teddy is in the Your Bedroom:
		now Teddy is in the Dummy Bedroom;
When time-out ends:
	now the player is in the Your Bedroom;
	say "time out is over";
	if Teddy is in the dummy bedroom:
		now Teddy is in the Your Bedroom;]
	
Time-out is a recurring scene. time-out begins when the Your Bedroom is confined.
Time-out ends when the time since time-out began is 10 minutes.
When time-out begins:
	say "Mom drags you to a corner of your bedroom for a 10-minute time-out.";
When time-out ends:
	say "Your ten minute time-out ends, and you are now free to leave your bedroom.";
	now the Your Bedroom is free;

Before going to somewhere during time-out, say "You cannot leave your room during time-out." instead.

Before Bobby going to the Your Bedroom during time-out, do nothing instead.
	
a person can be alive or dead. A person is usually alive.



A room can be salted or unsalted. A room is usually unsalted.

			
instead of Teddy going to a salted room:
	let R be a random unsalted room adjacent to Teddy;
	if R is not nothing:
		now teddy is in R;
	otherwise:
		do nothing;

to have Teddy kill (P - person):
	if P is the player:
		end the story saying "Teddy got you.";[this will be something more interesting later]
	otherwise:
		now P is nowhere; 
		say "[line break]DEBUG: Teddy killed [P]";
		if a dice roll of difficulty 5 succeeds:
			now the left hand status line is "GOODBYE";
			now the right hand status line is "[the printed name of P in upper case]";

crying is an action applying to nothing. Understand "cry" as crying.

Check crying:
	say "Tears well up in your eyes as you sob without restraint.";
	if mom is not nowhere:
		if the player is on something (called the supporter):
			now mom is in the location of the supporter;
		otherwise:
			now mom is in the location;
		if time-out is not happening:
			say "[line break]Mom rushes into the room.[line break][quotation mark]What's wrong baby? Are you okay?[quotation mark][line break][line break]Time passes as Mom soothes you.";
		otherwise:
			say "Mom rushes into the room only to scold you for throwing a tantrum during time-out.";
		increment the turn count;
		[increase the time of day by one minute;
		if teddy is not nowhere:
			have teddy chase to the location;][that code should be redundant]
	rule succeeds;



answering someone that is being noisy. asking someone about is being noisy. dropping is being noisy. switching on is being noisy. switching off is being noisy. crying is being noisy. Going to somewhere with a supporter is being noisy;

After being noisy:
	if Teddy is not nowhere:
		have Teddy chase to the location;
		say "DEBUG: Teddy heard you";
	continue the action;

instead of dropping something (called the dropped) while the player is on a supporter:
	now the dropped is in the location;
	say "Dropped.[line break]";

instead of putting Teddy on a supporter:
	now Teddy is in the location;
	say "Teddy slips off and falls to the floor.";


Chapter 6 - Rooms and important things in them

[Note: the code at the beginning of this game randomizes the locations of some of these things, but they still have a starting location in these rooms just for the sake of my sanity]

The Your Bedroom is a room.
	"This is your bedroom. There is a shelf with[if Teddy is in the location and Teddy is not carried by the player] a teddy bear on it. [otherwise] nothing on it.".
	The step stool is an enterable supporter in Your Bedroom. The step stool is pushable between rooms.
		the description of the step stool is
			"Good for reaching high places.".
	your bed is a fixed in place thing in your bedroom. the indefinite article is "your".
	the dresser is a fixed in place thing in Your bedroom.
	the drawers are a closed opaque openable container. the drawers are part of the dresser.
	the description of the dresser is "A dresser with many drawers.".
	understand "drawer" as the drawers.
	The hamper is a container in the your bedroom. [random bedroom vs laundry room]
	The lucky boxers is a wearable thing. The indefinite article is "your". the player carries the lucky boxers.

the description of the lucky boxers is "They're[if the lucky boxers are wet]wet.[otherwise if the lucky boxers are dirty]dirty.[otherwise if the lucky boxers are clean]clean.".

instead of entering your bed:
	say "There's no point.";

[I stole this code from somewhere, but I can't remember where... sorry about that]
After going a direction (called way-pushed) with something (called the thing-pushed):
	say "You push [the thing-pushed] [way-pushed] to [the location].";
	continue the action. 
	

The Shared Bathroom is south of the Your Bedroom.
"You share this bathroom with your brother, Bobby."
The small mirror is a fixed in place thing in the Shared Bathroom.
the description of the small mirror is "I can see myself in it[if Teddy is in the location and Teddy is not carried by the player] with a teddy bear behind me.[otherwise].".
the cabinet is an opaque closed openable fixed in place container in the Shared Bathroom;

Instead of searching the small mirror:
	say "[the description of the small mirror]";

The Bobby's Bedroom is east of the Shared Bathroom and west of the Entry Hall.
	The toybox is an opaque closed fixed in place openable container in Bobby's Bedroom.

The Small Hall is east of the Your Bedroom.
The hall closet is a fixed in place openable closed container in the Small Hall.
The vacuum cleaner is a device in the hall closet.

The Parent's Bedroom is north of the Small Hall.
	the queen-sized bed is a fixed in place thing in the Parent's Bedroom.
	the nightstand is a fixed in place opaque closed openable container in the Parent's Bedroom.
The Parent's Bathroom is west of the Parent's Bedroom.
the large mirror is a fixed in place thing in the Parent's Bathroom.

the description of the large mirror is "I can see myself in it[if Teddy is in the location and Teddy is not carried by the player] with a teddy bear behind me.[otherwise].".

Instead of searching the large mirror:
	say "[the description of the large mirror]";

the Living Room is east of the Small Hall.

The Kitchen is north of the Living Room.
	the pantry is an opaque closed fixed in place openable container in the Kitchen.
	The salt shaker is [in the pantry.]carried by the player.
	the description of the salt shaker is "It is [if the salt shaker is full]full of salt.[otherwise if the salt shaker is two-thirds full]two-thirds full of salt. [otherwise if the salt shaker is one-third full]one-third full of salt.[otherwise]empty.".

	
instead of taking the salt shaker:
	if the salt shaker is in the pantry:
		if the player is on a supporter:
			continue the action;
		otherwise:
			say "It is too high for you to reach." instead;
	otherwise:
		continue the action;
	
instead of pushing a supporter:
	say "Where would you like to push it?";

The Dining Room is east of the Kitchen.
the table is a fixed in place supporter in the dining room.
the high chair is a supporter. The high chair is pushable between rooms.
the description of the high chair is
	"Good for reaching high places."

instead of taking an enterable supporter:
	say "It's too heavy to carry, but you may be able to push it somewhere.";

[The Laundry Room-------------------------------------]
the Laundry Room is south of the Dining Room and east of the Living Room.
	
	

The Entry Hall is south of the Living Room.
the entryway is a door with the printed name "front door". the entryway is south of the Entry Hall.

understand "door" or "front door" as the entryway.

Instead of opening the entryway:
	say "A childproof lock prevents your escape."

The Play Room is south of the Laundry Room and east of the Entry Hall.

The Garage is east of the Play Room.
The car is a fixed in place thing in the Garage.
The garage door is a fixed in place thing in the Garage.
The toolbox is an opaque closed openable container in the garage.








the floor is a backdrop. the floor is everywhere.
understand "carpet" or "rug" or "ground"as the floor.

a room can be salted or unsalted.
a thing can be salty or unsalty. A thing is usually unsalty.

a thing can be pourable or unpourable. a thing is usually unpourable. the salt shaker is pourable.

pouring is an action applying to two things.
understand "pour [something preferably held] on [something]" as pouring.

the salt shaker can be one-third full, two-thirds full, full, or saltless. the salt shaker is full.

instead of pouring the salt shaker:
	if the second noun is Teddy:
		if Teddy is not carried by the player:
			say "You must be carrying Teddy to do that.";
		otherwise:
			continue the action;
	otherwise:
		continue the action;

Check pouring:
	if the noun is not pourable:
		say "That isn't something you can pour.";
		rule fails;
	otherwise if the noun is the salt shaker:
		say "[if the salt shaker is not saltless]You pour some salt on [the second noun].[otherwise]The salt shaker is empty.";
		if the salt shaker is full:
			now the salt shaker is two-thirds full;
		otherwise if the salt shaker is two-thirds full:
			now the salt shaker is one-third full;
		otherwise if the salt shaker is one-third full:
			now the salt shaker is saltless;
		otherwise if the salt shaker is saltless:
			say "There is nothing in the salt shaker to pour.";
			rule fails;
	otherwise:
		say "[line break]DEBUG: Did you make a new thing pourable besides the salt shaker? Update Check Pouring to account for this.";
			
Report pouring:
	if the second noun is the floor:
		now the location of the player is salted;
		say "[the location of the player] is salted.[line break]";
		if mom is enclosed by the vicinity of the player:
			say "Mom sees you pouring salt on the floor.[line break][quotation mark]My floor! No! You're getting a time-out for this right now![quotation mark]";
			now the Your Bedroom is confined;
	otherwise if the second noun is not the floor:
		if the second noun is not Teddy:
			now the second noun is salty;
			now the printed name of the second noun is "a salty [the second noun]";
		otherwise if the second noun is Teddy:
			say "Teddy shrieks and bites your arm with a dozen needle-sharp teeth. You drop the salt shaker, spilling the remainder of its contents. When you look up from your wound, you notice that Teddy is nowhere to be seen.";
			now the location is salted;
			now the salt shaker is saltless;
			move Teddy to a random unsalted room;
			silently try dropping the salt shaker;
			if a family member (called the watcher) is in the location:
				say "[the watcher] seems to be oblivious to your struggle.";
				now salty bear is true;
				
salty bear is a truth state that varies. Salty bear is false.				

a family member is a kind of person.
mom is a family member.
bobby is a family member.
dad is a family member.
chaser is a family member;
	



[act fast]

Taking inventory is acting fast. [add other actions here if needed, but be stingy]

The take rapid actions out of world rule is listed before the every turn stage rule in the turn sequence rules.

This is the take rapid actions out of world rule: if acting fast, rule succeeds.	

petting is an action applying to one thing.

understand "pet [something]" as petting.

check petting:
	if the noun is Chaser:
		say "You rub chaser's belly. [quotation mark]Good boy![quotation mark]";
		if LUCK is less than 1:
			increase LUCK by 1;
		say "[line break]DEBUG: LUCK = [luck]";
		rule succeeds;
	otherwise:
		say "That doesn't need petting.";
		rule fails;

	
	
			
The can't push what's fixed in place rule response (A) is "That's too heavy to move."
The can't pull what's fixed in place rule response (A) is "That's too heavy to move."
The can't take what's fixed in place rule response (A) is "That's too heavy to move."

rule for printing a parser error when the latest parser error is the can't see it at the moment error:
	say "You can't see any such thing.";		


[WASHING AND DRYING-----------------------------]
[The washing machine and the dryer are important, because Teddy can be trapped in either of these during their wash cycle. They can also be used to clean up the lucky boxers, which when worn (if clean and dry) give the character a LUCK boost. If Teddy is trapped in the washer or dryer, he breaks the device upon exiting.]

the dial is a device.
	the dial is part of the washer.
	the printed name of the dial is "washer".
	the washer is a opaque closed openable fixed in place container in the laundry room. the dial is part of the washer.
	the dryer is a opaque closed openable fixed in place container in the laundry room.
	the button is a device.
	the printed name of the button is "dryer".
	the button is part of the dryer.

the description of the dryer is "[if the button is switched on]The dryer is on.[otherwise]The dryer is off.";

the description of the washer is "[if the dial is switched on]The washer is on.[otherwise]The washer is off.";

	
Instead of switching on a container (called the chamber):
	if a device (called the machine) is part of the chamber:
		try switching on the machine;

instead of switching off a container (called the chamber):
	if the chamber is part of a device (called the machine):
		try switching off the machine;

Instead of opening a container (called the chamber):
	if a device (called the machine) is part of the chamber and the machine is switched on:
		say "[the machine] is running. You must wait until the cycle is complete.";
	otherwise:
		continue the action;
		
After switching on the dial:
	say "You turn the washer on";
	
After switching off the dial:
	say "You turn the washer off";
	
After switching on the button:
	say "You turn the dryer on";
	
After switching off the button:
	say "You turn the dryer off";			

a device can be either broken or functional. A device is usually functional.

instead of switching on a broken device:
	say "It's broken.";
	
the wash cycle is a recurring scene. The wash cycle begins when the dial is switched on.

instead of switching on a dial when the wash cycle is happening:
	say "You must wait until the wash cycle is over."

instead of opening the washer when the wash cycle is happening:
	say "You must wait until the wash cycle is over."
	
Every turn during the wash cycle:
	if Teddy is in the washer:
		now Teddy is nowhere;

The wash cycle ends when the time since the wash cycle began is 5 minutes.

When wash cycle ends:
	if Teddy is nowhere:
		now Teddy is in the laundry room;
		now the dial is broken;
		say "[quotation mark]BANG![quotation mark][line break]You hear the sound of something breaking.";
		now the dial is switched off;
	otherwise:
		say "[quotation mark]DING![quotation mark][line break]You hear the sound of the washer completing it's cycle.";
		now the dial is switched off;
		if the salt shaker is in the washer:
			now the salt shaker is saltless;
		if the lucky boxers is in the washer:
			now the lucky boxers is wet;
			now the printed name of the lucky boxers is "wet boxers";

a thing can be wet or dry. A thing is usually dry.
a thing can be dirty or clean. A thing is usually clean.

boxer power is a number that varies.

When play begins:
	let RAND be a random number between 1 and 20;
	if RAND is 20:
		now boxer power is 5;
	otherwise if RAND is greater than 11:
		now boxer power is 3;
	otherwise:
		now boxer power is 2;


After the player wearing the lucky boxers:
	if the lucky boxers are dry and the lucky boxers are clean:
		increase LUCK by boxer power;
		say "You put on your lucky boxers. What were you wearing before?";
		say "DEBUG: luck= [LUCK][line break]";
	otherwise if the lucky boxers are wet:
		say "You question your life choices as you slide into the cold, soggy boxers.";
	otherwise if the lucky boxers are dirty:
		say "You feel a tinge of regret as you slip on the smelly, unwashed boxers.";
		decrease LUCK by boxer power;
		say "DEBUG: luck= [LUCK][line break]";



instead of switching on a button when the dry cycle is happening:
	say "You must wait until the dry cycle is over."

instead of opening the dryer when the dry cycle is happening:
	say "You must wait until the dry cycle is over."
	
Every turn during the dry cycle:
	if Teddy is in the dryer:
		now Teddy is nowhere;

The dry cycle ends when the time since the dry cycle began is 10 minutes.

When dry cycle ends:
	if Teddy is nowhere:
		now Teddy is in the laundry room;
		now the button is broken;
		say "[quotation mark]BANG![quotation mark][line break]You hear the sound of something breaking.";
	otherwise:
		say "[quotation mark]BUZZ![quotation mark][line break]You hear the sound of the dryer completing it's cycle.";
	if the lucky boxers are in the dryer:
		if the lucky boxers are wet:
			now the lucky boxers are dry;
			now the printed name of the boxers is "clean boxers";
			now the starting position of the boxers is the Your Bedroom;	
