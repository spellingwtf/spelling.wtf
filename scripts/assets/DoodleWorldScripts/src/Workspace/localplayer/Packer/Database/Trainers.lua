-- Decompiled with the Synapse X Luau decompiler.

return {
	Class = {}, 
	Battles = { {
			Class = "DoodleCo", 
			Name = "Professor", 
			Model = "DoodleRep", 
			Party = { {
					Name = "Tortles", 
					Level = 2, 
					Moves = { "Harden" }, 
					Ability = "Rejuvenator"
				} }, 
			BattleScene = "GenericIndoors", 
			LoseBattle = { "I don't know how you lost to me." }, 
			WinBattle = { "You certainly picked a strong Doodle!" }, 
			Cash = 250
		}, {
			Class = "Rich Boy", 
			Name = "Quincy", 
			Party = { {
					Name = "Shelldo", 
					Level = 4, 
					Ability = "Molt", 
					Moves = { "Smack", "Scrutinize" }
				} }, 
			BattleScene = "GenericIndoors", 
			LoseBattle = { "Haha! Your doodle is mine." }, 
			WinBattle = { "...my special doodle lost? Impossible..." }, 
			Cash = 1500
		}, {
			Class = "Shinobi", 
			Name = "\"Inari\"", 
			Party = { {
					Name = "Kitsen", 
					Level = 7, 
					Ability = "Premonition", 
					Moves = { "Boo!", "Mind Power", "Befuddlement" }, 
					Stars = 2
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "Now you have to keep this a secret!" }, 
			WinBattle = { "W-w-wait!" }, 
			Cash = 100
		}, {
			Class = "Kid", 
			Name = "Johhny", 
			Party = { {
					Name = "Nibblen", 
					Level = 3
				}, {
					Name = "Rosebug", 
					Level = 3
				} }, 
			BattleScene = "Route1", 
			Interact = { "If two tamer's eyes meet, a battle starts!" }, 
			BeatenInteract = { "That was a courtesy win!" }, 
			WinBattle = { "You're pretty strong!" }, 
			LoseBattle = { "I win, let's go!" }, 
			Cash = 250, 
			Song = ""
		}, {
			Class = "Lass", 
			Name = "Rachel", 
			Party = { {
					Name = "Bunsweet", 
					Level = 4
				} }, 
			Music = "DefaultTrainer", 
			BattleScene = "Route1", 
			Interact = { "I got this Doodle from my father!" }, 
			BeatenInteract = { "My daddy will buy me a better doodle when I get older!" }, 
			LoseBattle = { "Thanks for the powerful Doodle, Dad!" }, 
			WinBattle = { "My daddy will buy me a better doodle when I get older!" }, 
			Cash = 400
		}, {
			Class = "Crusher", 
			Name = "Brandon", 
			Party = { {
					Name = "Toxipupa", 
					Level = 4
				}, {
					Name = "Borbo", 
					Level = 5
				} }, 
			BattleScene = "Route1", 
			Interact = { "I take pride in beating new tamers!" }, 
			BeatenInteract = { "I lost to you! What has happened to my skill?" }, 
			LoseBattle = { "Another rookie crushed!" }, 
			WinBattle = { "...I lost to a rookie..." }, 
			Cash = 600
		}, {
			Class = "Cool Teen", 
			Name = "Beckett", 
			Party = { {
					Name = "Glimmew", 
					Level = 6
				} }, 
			BattleScene = "Route1", 
			Interact = { "'Sup, kid? I can't let you pass!" }, 
			BeatenInteract = { "Carry on." }, 
			WinBattle = { "You pass the test!" }, 
			LoseBattle = { "Get stronger." }, 
			Cash = 800
		}, {
			Class = "Hiker", 
			Name = "Miles", 
			Party = { {
					Name = "Squed", 
					Level = 6
				} }, 
			BattleScene = "Route1", 
			Interact = { "My goal is to climb all the mountains in the world!!" }, 
			BeatenInteract = { "I won't be able to climb Grizzly Peak if I don't get stronger." }, 
			WinBattle = { "Looks like you are a mountain I can't climb!" }, 
			LoseBattle = { "I'm ready to climb Grizzly Peak!" }, 
			Cash = 800
		}, {
			Class = "Kid", 
			Name = "Bobby", 
			Party = { {
					Name = "Borbo", 
					Level = 6
				}, {
					Name = "Plipo", 
					Level = 6
				} }, 
			BattleScene = "Route1", 
			Interact = { "We're almost at the end of this route. Let's get a quick battle in!" }, 
			BeatenInteract = { "Meh..." }, 
			LoseBattle = { "I win, let's go!" }, 
			WinBattle = { "Meh..." }, 
			Cash = 750
		}, {
			Class = "Businessman", 
			Name = "Douglas", 
			Party = { {
					Name = "Ruffire", 
					Level = 6
				} }, 
			BattleScene = "Route1", 
			Interact = { "Do you know your way around? I'm lost!" }, 
			BeatenInteract = { "...I'm going to get fired..." }, 
			LoseBattle = { "My boss won't fire me!" }, 
			WinBattle = { "...I'm going to get fired..." }, 
			Cash = 1250
		}, {
			Class = "Kid", 
			Name = "Billy", 
			Party = { {
					Name = "Needling", 
					Level = 6
				} }, 
			BattleScene = "Route1", 
			Interact = { "Look at this Doodle that you've probably never seen before!" }, 
			BeatenInteract = { "I got my Needling at a desert!" }, 
			LoseBattle = { "Were you surprised by my Doodle?" }, 
			WinBattle = { "Drats, I lost!" }, 
			Cash = 500
		}, {
			Class = "Lass", 
			Name = "Alyssa", 
			Party = { {
					Name = "Tortles", 
					Level = 5, 
					Moves = { "Smack" }
				}, {
					Name = "Tortles", 
					Level = 6, 
					Moves = { "Smack" }
				} }, 
			BattleScene = "Route1", 
			Interact = { "Boo! Did I scare you?!" }, 
			BeatenInteract = { "My tactic didn't work on you this time, but it will work next time!" }, 
			LoseBattle = { "You were too scared to fight at your full potential." }, 
			WinBattle = { "My scare tactic didn't work!" }, 
			Cash = 600
		}, {
			Class = "Monk", 
			Name = "Girish", 
			Party = { {
					Name = "Roscoon", 
					Level = 5
				}, {
					Name = "Partybug", 
					Level = 5
				}, {
					Name = "Plipo", 
					Level = 5
				} }, 
			BattleScene = "Route1", 
			Interact = { "Calm and collected. Get ready to fight!" }, 
			BeatenInteract = { "I am at peace with my loss." }, 
			LoseBattle = { "My mind as calm as still water." }, 
			WinBattle = { "I am at peace with this loss." }, 
			Cash = 750
		}, {
			Class = "Kid", 
			Name = "Ryan", 
			Party = { {
					Name = "Rosebug", 
					Level = 4
				}, {
					Name = "Roscoon", 
					Level = 5
				}, {
					Name = "Nibblen", 
					Level = 6
				}, {
					Name = "Toxipupa", 
					Level = 7
				} }, 
			BattleScene = "Route1", 
			Interact = { "I want to be an insect-type tamer!" }, 
			BeatenInteract = { "Maybe insect-types aren't the strongest..." }, 
			LoseBattle = { "Insect-types are strong!" }, 
			WinBattle = { "Maybe insect-types aren't the strongest..." }, 
			Cash = 650
		}, {
			Class = "Triplet", 
			Name = "Rouge", 
			Party = { {
					Name = "Rosebug", 
					Level = 7
				}, {
					Name = "Agotoad", 
					Level = 7
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "Another win for the triplets." }, 
			WinBattle = { "You're going to lose to Bleu, I can feel it." }, 
			Cash = 600
		}, {
			Class = "Triplet", 
			Name = "Bleu", 
			Party = { {
					Name = "Larvennae", 
					Level = 8
				}, {
					Name = "Muttish", 
					Level = 8
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "I-I-I won...?" }, 
			WinBattle = { "Noooooo!" }, 
			Cash = 1000
		}, {
			Class = "Triplet", 
			Name = "Noir", 
			Party = { {
					Name = "Nibblen", 
					Level = 8
				}, {
					Name = "Rosebug", 
					Level = 8
				}, {
					Name = "Larvennae", 
					Level = 8
				}, {
					Name = "Borbo", 
					Level = 8
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "Predictable." }, 
			WinBattle = { "The chest is yours." }, 
			Cash = 2000
		}, {
			Class = "Kid", 
			Name = "Vert", 
			Party = { {
					Name = "Rosebug", 
					Level = 2
				}, {
					Name = "Rosebug", 
					Level = 2
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "Yes!!! I can finally join the triplets!!!" }, 
			WinBattle = { "I guess I will never be able to join the triplets, huh..." }, 
			Cash = 400
		}, {
			Class = "Cool Teen", 
			Name = "Flynn", 
			Party = { {
					Name = "Glimmew", 
					Level = 9
				}, {
					Name = "Skrappey", 
					Level = 9
				} }, 
			BattleScene = "Route1", 
			Interact = { "I can't get to Route 4 because the roads are blocked! Let's pass the time by battling!" }, 
			BeatenInteract = { "DoodleCo sure is a great company..." }, 
			LoseBattle = { "Haha, good battle." }, 
			WinBattle = { "I can't really complain about these results..." }, 
			Cash = 850
		}, {
			Class = "Beauty", 
			Name = "Sarah", 
			Party = { {
					Name = "Wydling", 
					Level = 10, 
					Moves = { "Disarm", "Spirit Orb" }
				} }, 
			BattleScene = "Route1", 
			Interact = { "Look at my Doodle, isn't it incredibly sweet?" }, 
			BeatenInteract = { "..." }, 
			LoseBattle = { "Haha, good battle." }, 
			WinBattle = { "I can't really complain about these results..." }, 
			Cash = 1000
		}, {
			Class = "Kid", 
			Name = "Dubley", 
			Party = { {
					Name = "Roscoon", 
					Level = 9
				}, {
					Name = "Toxipupa", 
					Level = 9
				} }, 
			Format = "Doubles", 
			BattleScene = "Route1", 
			Interact = { "I will only do double battles! Get ready!" }, 
			BeatenInteract = { "My strategy didn't work..." }, 
			LoseBattle = { "Yes!!! Another doubles win!" }, 
			WinBattle = { "My strategy didn't work..." }, 
			Cash = 800
		}, {
			Class = "Businessman", 
			Name = "Barney", 
			Party = { {
					Name = "Borbo", 
					Level = 9
				}, {
					Name = "Vipember", 
					Level = 9
				} }, 
			BattleScene = "Route1", 
			Interact = { "Time is money, kid. I've made over $3,500 during this conversaion!" }, 
			BeatenInteract = { "At least I still have my money..." }, 
			LoseBattle = { "Just made some more money!" }, 
			WinBattle = { "At least I still have my money..." }, 
			Cash = 3500
		}, {
			Class = "Hiker", 
			Name = "Axel", 
			Party = { {
					Name = "Pebblett", 
					Level = 9
				}, {
					Name = "Pupskey", 
					Level = 9
				} }, 
			BattleScene = "Route1", 
			Interact = { "Hiking!" }, 
			BeatenInteract = { "Hiking!" }, 
			LoseBattle = { "Hiking!" }, 
			WinBattle = { "Hiking!" }, 
			Cash = 1500
		}, {
			Class = "Monk", 
			Name = "Baldy", 
			Party = { {
					Name = "Wiglet", 
					Level = 9
				}, {
					Name = "Tabbolt", 
					Level = 9
				} }, 
			BattleScene = "Route1", 
			Interact = { "I can't believe my parents named me this..." }, 
			BeatenInteract = { "My parents knew I would lose my hair..." }, 
			LoseBattle = { "I won, but I'm still bald, so am I really a winner?" }, 
			WinBattle = { "My parents knew I would lose my hair..." }, 
			Cash = 2000
		}, {
			Class = "Lackey", 
			Name = "Number 3", 
			Party = { {
					Name = "Partybug", 
					Ability = "Careless", 
					Level = 11, 
					Star = 4
				}, {
					Name = "Ruffire", 
					Level = 12, 
					Star = 4, 
					Moves = { "Bite", "Firebolt", "Howl" }
				} }, 
			Music = "RiffraffTheme", 
			BattleScene = "Route1", 
			LoseBattle = { "I'm telling you, he wasn't kidnapped!" }, 
			WinBattle = { "Argh..." }, 
			Cash = 1200
		}, {
			Class = "Mister", 
			Name = "Riffraff", 
			Party = { {
					Name = "Riffrat", 
					Gender = "M", 
					Nickname = "Number Four", 
					Shiny = true, 
					Moves = { "Swipe", "Scrutinize", "Heckle" }, 
					Ability = "Premonition", 
					Level = 11, 
					Star = 5
				}, {
					Name = "Partybug", 
					Gender = "M", 
					Ability = "Careless", 
					Level = 12, 
					Stars = 4
				}, {
					Name = "Dramask", 
					Gender = "M", 
					Ability = "Whimsical", 
					Level = 13, 
					Stars = 4, 
					Moves = { "Spirit Orb", "Smack", "Whisper", "Flare" }
				} }, 
			Music = "RiffraffTheme", 
			BattleScene = "GenericIndoors", 
			LoseBattle = { "You're not too bad of a battler." }, 
			WinBattle = { "Looks like my fun is over for now." }, 
			Cash = 2000
		}, {
			Class = "Fan Club President", 
			Name = "Portia", 
			Party = { {
					Name = "Squed", 
					Gender = "F", 
					Moves = { "Pebble", "Trap", "Headbutt" }, 
					Ability = "Durable", 
					Level = 12, 
					Star = 5
				}, {
					Name = "Borbek", 
					Gender = "F", 
					Ability = "Pecking Order", 
					Level = 13, 
					Stars = 4
				}, {
					Name = "Glummish", 
					Gender = "F", 
					Ability = "Gloomy", 
					Level = 15, 
					Stars = 4, 
					Moves = { "Sad Zone", "Shadowbolt", "Sleep Spores", "Plant Sap" }
				} }, 
			Music = "Portia", 
			BattleScene = "Route4", 
			LoseBattle = { "Why didn't you give your Doodle to Quincy?" }, 
			WinBattle = { "My other Doodles were confiscated..." }, 
			Cash = 1500
		}, {
			Class = "Cool Teen", 
			Name = "Bradley", 
			Party = { {
					Name = "Snobat", 
					Level = 13
				}, {
					Name = "Moss", 
					Level = 13
				} }, 
			BattleScene = "Route4", 
			Interact = { "It's time to b-b-b-battle!" }, 
			BeatenInteract = { "Meh." }, 
			LoseBattle = { "Mind crush!" }, 
			WinBattle = { "Wow!" }, 
			Cash = 1000
		}, {
			Class = "Beauty", 
			Name = "Alice", 
			Party = { {
					Name = "Riffrat", 
					Level = 12
				}, {
					Name = "Klydaskunk", 
					Level = 12
				}, {
					Name = "Mold", 
					Level = 12
				} }, 
			BattleScene = "Route4", 
			Interact = { "Aren't my Doodles cute?!" }, 
			BeatenInteract = { "I went sewer-hunting for these..." }, 
			LoseBattle = { "My doodles are cute AND powerful!" }, 
			WinBattle = { "I went sewer-hunting for these..." }, 
			Cash = 800
		}, {
			Class = "Hiker", 
			Name = "Smith", 
			Party = { {
					Name = "Boulduo", 
					Level = 15
				} }, 
			BattleScene = "Route4", 
			Interact = { "Why did it start raining all of a sudden?" }, 
			BeatenInteract = { "If it wasn't raining, I would've won!" }, 
			LoseBattle = { "I won, despite it raining!" }, 
			WinBattle = { "If it wasn't raining, I would've won!" }, 
			Cash = 1250
		}, {
			Class = "Kid", 
			Name = "Timmy", 
			Party = { {
					Name = "Roscoon", 
					Level = 12
				}, {
					Name = "Webennae", 
					Level = 12
				}, {
					Name = "Toxipupa", 
					Level = 12
				}, {
					Name = "Thornet", 
					Level = 13
				} }, 
			BattleScene = "Route4", 
			Format = "Doubles", 
			Interact = { "I'm trying to perfect my Doubles strategy!" }, 
			BeatenInteract = { "My strategy is still a work in progress." }, 
			LoseBattle = { "Did I stumble across the perfect strategy?" }, 
			WinBattle = { "My strategy is still a work in progress." }, 
			Cash = 1250
		}, {
			Class = "Hooligans", 
			Name = "Ben and Pete", 
			Party = { {
					Name = "Moss", 
					Level = 11, 
					Moves = { "Waterbolt", "Leaf Sap" }, 
					Ability = "Tangled", 
					Star = 3
				}, {
					Name = "Muttish", 
					Level = 13, 
					Ability = "Storm Surge", 
					Moves = { "Bite", "Waterbolt" }, 
					Star = 3
				}, {
					Name = "Tadappole", 
					Level = 12, 
					Ability = "Sickly Sweet", 
					Moves = { "Bullet Corn", "Rust" }, 
					Star = 3
				}, {
					Name = "Lilbulb", 
					Level = 12, 
					Ability = "Electrocute", 
					Moves = { "Shock", "Laser" }, 
					Star = 3
				} }, 
			Music = "Pvptheme", 
			BattleScene = "Route1", 
			Format = "Doubles", 
			LoseBattle = { "Ben: We did it, Pete!" }, 
			WinBattle = { "Pete: Our perfect teamwork was... countered?" }, 
			Cash = 2000
		}, {
			Class = "Hooligan", 
			Name = "Carson", 
			Party = { {
					Name = "Snobat", 
					Gender = "F", 
					Moves = { "Tempest", "Jet Strike", "Snowball" }, 
					Ability = "Concentrated", 
					Level = 12, 
					Star = 5
				}, {
					Name = "Wiglet", 
					Gender = "M", 
					Moves = { "Headbutt" }, 
					Ability = "Routine", 
					Level = 13, 
					Star = 3
				}, {
					Name = "Agotoad", 
					Gender = "M", 
					Moves = { "Firebolt", "Mud Spit", "Croak" }, 
					Ability = "Steam Guard", 
					Level = 15, 
					Star = 3
				}, {
					Name = "Ruffire", 
					Gender = "M", 
					Moves = { "Bite", "Howl", "Firebolt" }, 
					Ability = "Savage", 
					Level = 16, 
					Star = 6
				} }, 
			BattleScene = "Route4", 
			LoseBattle = { "I told you so." }, 
			WinBattle = { "..." }, 
			Cash = 1500
		}, {
			Class = "Wayfarer", 
			Name = "Jack", 
			Party = { {
					Name = "Partybug", 
					Gender = "F", 
					Moves = { "Magical Shield", "Mind Power", "Bite" }, 
					Ability = "Spell Shield", 
					Level = 16, 
					Star = 6
				}, {
					Name = "Kowosu", 
					Gender = "M", 
					Moves = { "Sword Sweep" }, 
					Ability = "Stabby Stabby", 
					Level = 17, 
					Star = 6
				}, {
					Name = "Blossafaun", 
					Gender = "M", 
					Moves = { "Sleep Spores", "Entangling Vines", "Parasitic Seeds", "Leaf Sap" }, 
					Ability = "Pollen Armor", 
					Level = 18, 
					Star = 6
				}, {
					Name = "Snobat", 
					Gender = "M", 
					Moves = { "Tempest", "Jet Strike", "Snowball" }, 
					Ability = "Concentrated", 
					Level = 19, 
					Star = 6
				}, {
					Name = "Pompaboar", 
					Gender = "M", 
					Moves = { "Headbutt", "Retribution" }, 
					Ability = "Menacing Snarl", 
					Level = 20, 
					Star = 6
				}, {
					Name = "Marigrimm", 
					Gender = "M", 
					Moves = { "Siren Song", "Spirit Orb", "Harmony" }, 
					Ability = "Serenade", 
					Level = 21, 
					Star = 6
				} }, 
			BattleScene = "Route4", 
			LoseBattle = { "...You aren't quite on my level yet." }, 
			WinBattle = { "Finally!" }, 
			Cash = 2500
		}, {
			Class = "Kid", 
			Name = "Rodney", 
			Party = { {
					Name = "Glimmew", 
					Level = 14
				}, {
					Name = "Glowcat", 
					Level = 15
				} }, 
			BattleScene = "Crossroads", 
			Interact = { "Hello!" }, 
			BeatenInteract = { "Bye..." }, 
			LoseBattle = { "Goodbye!" }, 
			WinBattle = { "...Goodbye..." }, 
			Cash = 1650
		}, {
			Class = "Hiker", 
			Name = "Adam", 
			Party = { {
					Name = "Agotoad", 
					Level = 14
				}, {
					Name = "Agotoad", 
					Level = 14
				} }, 
			BattleScene = "Crossroads", 
			Interact = { "I love my Agotoads!" }, 
			BeatenInteract = { "Even though I lost, I still love my Agotoads!" }, 
			LoseBattle = { "My Agotoads are the best!" }, 
			WinBattle = { "How did my Agotoads lose?" }, 
			Cash = 2000
		}, {
			Class = "Hiker", 
			Name = "Tom", 
			Party = { {
					Name = "Louis", 
					Level = 10, 
					Ability = "Balloon Pop"
				}, {
					Name = "Louis", 
					Level = 12, 
					Ability = "Balloon Pop"
				}, {
					Name = "Louis", 
					Level = 14
				} }, 
			BattleScene = "Crossroads", 
			Interact = { "Have you ever considered the superiority of Louis?" }, 
			BeatenInteract = { "Louis is still the supreme form of all Doodles." }, 
			LoseBattle = { "Are you convinced?" }, 
			WinBattle = { "Louis is still the supreme form of all Doodles." }, 
			Cash = 2500
		}, {
			Class = "Businesswoman", 
			Name = "Jane", 
			Party = { {
					Name = "Kitsen", 
					Level = 16
				}, {
					Name = "Ruffire", 
					Level = 16
				} }, 
			BattleScene = "Crossroads", 
			Interact = { "I'm not really a battler, but I'll fight you!" }, 
			BeatenInteract = { "I need practice." }, 
			LoseBattle = { "Maybe... I have potential?" }, 
			WinBattle = { "I need practice." }, 
			Cash = 3200
		}, {
			Class = "Rebattler", 
			Name = "Riley", 
			Party = { {
					Name = "Wiglet", 
					Level = 20
				}, {
					Name = "Schiwi", 
					Level = 20
				}, {
					Name = "Lilbulb", 
					Level = 20
				}, {
					Name = "Twigon", 
					Level = 20
				} }, 
			Rebattle = true, 
			Music = "Battlefield4", 
			BattleScene = "Crossroads", 
			Interact = { "..." }, 
			BeatenInteract = { "..." }, 
			LoseBattle = { "..." }, 
			WinBattle = { "..." }, 
			Cash = 750
		}, {
			Class = "Lol", 
			Name = "Wow", 
			Party = { {
					Name = "Maelzuri", 
					Level = 10000
				}, {
					Name = "Maelzuri", 
					Level = 10000
				}, {
					Name = "Maelzuri", 
					Level = 10000
				}, {
					Name = "Maelzuri", 
					Level = 10000
				}, {
					Name = "Maelzuri", 
					Level = 10000
				}, {
					Name = "Maelzuri", 
					Level = 10000
				} }, 
			Rebattle = true, 
			Music = "Battlefield4", 
			BattleScene = "Crossroads", 
			Interact = { "..." }, 
			BeatenInteract = { "..." }, 
			LoseBattle = { "..." }, 
			WinBattle = { "..." }, 
			Cash = 0
		}, {
			Class = "Bandit", 
			Name = "Craig", 
			Party = { {
					Name = "Glowcat", 
					Moves = { "Crystal Wall", "Quick Strike", "Subterfuge" }, 
					Ability = "Nitelite", 
					Level = 17
				}, {
					Name = "Shadark", 
					Moves = { "Dark Slash", "Sharpen", "Subterfuge" }, 
					Ability = "Slash Expert", 
					Level = 18
				}, {
					Name = "Kidere", 
					Moves = { "Aurora Flash", "Snowball", "Gem Blast" }, 
					Ability = "Guilt", 
					Level = 19
				} }, 
			Music = "MoonlightBattle", 
			BattleScene = "CrystalCavern", 
			LoseBattle = { "Goodbye, forever." }, 
			WinBattle = { "...all my planning... all my work... foiled by one outsider?" }, 
			Cash = 7500
		}, {
			Class = "Tamer", 
			Name = "Cassidy", 
			Party = { {
					Name = "Moss", 
					Moves = { "Waterbolt", "Leaf Sap", "Agitate" }, 
					Ability = "Storm Surge", 
					Level = 16
				}, {
					Name = "Cacmeow", 
					Moves = { "Needle Spike", "Earth Lance", "Parasitic Seeds" }, 
					Ability = "Storm Surge", 
					Level = 17
				}, {
					Name = "Kibara", 
					Moves = { "Mind Drain", "Gem Blast", "Sad Zone" }, 
					Ability = "Unbreakable", 
					Level = 18
				} }, 
			Music = "Pvptheme", 
			BattleScene = "Route1", 
			LoseBattle = { "Kinda unexpected, to be honest." }, 
			WinBattle = { "I expected this battle to end this way." }, 
			Cash = 4000
		}, {
			Class = "Businesswoman", 
			Name = "Alexis", 
			Party = { {
					Name = "Gemin", 
					Level = 17
				}, {
					Name = "Gemin", 
					Level = 17
				} }, 
			BattleScene = "CrystalCavern", 
			Interact = { "My Doodles have a special way to evolve." }, 
			BeatenInteract = { "I know it needs the Swag Juice equipment... but what else?" }, 
			WinBattle = { "If I figured out how to evolve my Doodles, I would've won!" }, 
			LoseBattle = { "I know Gemin needs the Swag Juice equipment... but what else?" }, 
			Cash = 1800
		}, {
			Class = "Kid", 
			Name = "Willy", 
			Party = { {
					Name = "Crystik", 
					Level = 17
				}, {
					Name = "Muttish", 
					Level = 17
				}, {
					Name = "Needling", 
					Ability = "Arid", 
					Level = 17
				} }, 
			BattleScene = "CrystalCavern", 
			Interact = { "Grinding my chain out here!" }, 
			BeatenInteract = { "Grinding my chain out here!" }, 
			LoseBattle = { "My grinding paid off." }, 
			WinBattle = { "Wow..." }, 
			Cash = 1550
		}, {
			Class = "Monk", 
			Name = "Igleo", 
			Party = { {
					Name = "Gummelia", 
					Level = 18
				}, {
					Name = "Grimeleon", 
					Level = 18
				} }, 
			BattleScene = "CrystalCavern", 
			Interact = { "Crystal Caverns is the perfect training ground!" }, 
			BeatenInteract = { "Still have a long way to go." }, 
			LoseBattle = { "I wonder if this is my peak." }, 
			WinBattle = { "Clearly, still have a long way to go." }, 
			Cash = 1300
		}, {
			Class = "Beauty", 
			Name = "Kylie", 
			Party = { {
					Name = "Dramask", 
					Level = 19
				}, {
					Name = "Dramask", 
					Level = 19
				} }, 
			BattleScene = "CrystalCavern", 
			Interact = { "I love my Doodle!" }, 
			BeatenInteract = { "I still love my Doodle!" }, 
			LoseBattle = { "I love my Doodle!" }, 
			WinBattle = { "I still love my Doodle!" }, 
			Cash = 1300
		}, {
			Class = "Shinobi", 
			Name = "\"Inari\"", 
			Party = { {
					Name = "Mawthra", 
					Level = 20, 
					Ability = "Poisonous Skin", 
					Moves = { "Lingering Poison", "Crush", "Swarm" }, 
					Star = 5, 
					Equip = {
						Amulet = "6"
					}
				}, {
					Name = "Skorpent", 
					Level = 21, 
					Ability = "Firewall", 
					Moves = { "Flame Rattle", "Hiss", "Retribution" }, 
					Star = 5, 
					Equip = {
						Artifact = "1"
					}, 
					HeldItem = "Used Timber"
				}, {
					Name = "Grufflin", 
					Level = 22, 
					Ability = "Caloric Deficit", 
					Moves = { "Sylphid", "Sugar Kiss", "Air Strike" }, 
					Star = 5, 
					Equip = {
						Artifact = "6"
					}
				}, {
					Name = "Squed", 
					Level = 23, 
					Ability = "Durable", 
					Moves = { "Pebble", "Headbutt", "Trap" }, 
					Star = 5, 
					Equip = {
						Artifact = "7"
					}
				}, {
					Name = "Groato", 
					Level = 24, 
					Ability = "Careless", 
					Moves = { "Capsize", "Screech", "Headbutt" }, 
					Star = 5, 
					HeldItem = "Used Crayons"
				}, {
					Name = "Kitsen", 
					Level = 25, 
					Ability = "Magician", 
					Moves = { "Burning Orb", "Fiery Bite", "Harmony", "Mind Power" }, 
					Star = 5, 
					HeldItem = "Used Timber"
				} }, 
			BattleScene = "CrystalCavern", 
			LoseBattle = { "My training paid off." }, 
			WinBattle = { "Okay, fine, you can have the orb back." }, 
			Cash = 6000
		}, {
			Class = "Tamer", 
			Name = "TJ", 
			Party = { {
					Name = "Wvyarn", 
					Level = 20, 
					HeldItem = "Air Taffy", 
					Ability = "Stitching", 
					Moves = { "Air Strike" }, 
					Star = 5
				}, {
					Name = "Needling", 
					Level = 19, 
					HeldItem = "Used Crayons", 
					Ability = "Arid", 
					Moves = { "Parasitic Seeds", "Protect", "Life Sap" }, 
					Star = 5
				}, {
					Name = "Elektiel", 
					Level = 19, 
					HeldItem = "Glasses", 
					Ability = "Conductor", 
					Moves = { "Taser", "Shock", "Air Strike" }, 
					Star = 5
				}, {
					Name = "Boulduo", 
					Level = 18, 
					HeldItem = "Earth Taffy", 
					Ability = "Rugged", 
					Tint = { 2, 6, 7 }, 
					Moves = { "Pebble", "Icy Bite", "Double Bite" }
				} }, 
			BattleScene = "Route1", 
			LoseBattle = { "I won!" }, 
			WinBattle = { "This was the only way I could've obtained this key." }, 
			Cash = 3000
		}, {
			Class = "Rich Boy", 
			Name = "Quincy", 
			Party = { {
					Name = "Flaskit", 
					Level = 17, 
					Ability = "Crystaline", 
					Moves = { "Roll", "Crystal Dust" }, 
					Star = 5
				}, {
					Name = "Louis", 
					Level = 17, 
					Moves = { "Sharpen", "Heckle", "Quick Strike" }, 
					Star = 5
				}, {
					Name = "Shadark", 
					Moves = { "Dark Slash", "Sharpen", "Subterfuge" }, 
					Ability = "Slash Expert", 
					Level = 18
				} }, 
			BattleScene = "Temple", 
			LoseBattle = { "Yes! I beat you!" }, 
			WinBattle = { "..." }, 
			Cash = 10000
		}, {
			Class = "Hermit", 
			Name = "Nimbus", 
			Party = { {
					Name = "Aspark", 
					Level = 19, 
					HeldItem = "Determination Jelly", 
					Ability = "Heavy Storms", 
					Moves = { "Rainmaker", "Taser", "Shock Wave", "Dark Slash" }, 
					Star = 5
				}, {
					Name = "Angerler", 
					Level = 19, 
					Ability = "Bright Lights", 
					Moves = { "Waterbolt", "Laser" }, 
					Star = 5
				}, {
					Name = "Bunswirl", 
					Level = 18, 
					HeldItem = "Food Taffy", 
					Ability = "Restless", 
					Moves = { "Glaze Punch", "Fast Food" }
				}, {
					Name = "Elektiel", 
					Level = 19, 
					HeldItem = "Used Crayons", 
					Ability = "Conductor", 
					Moves = { "Taser", "Shock", "Air Strike" }, 
					Star = 5
				} }, 
			BattleScene = "Temple", 
			LoseBattle = { "You put up a good fight." }, 
			WinBattle = { "I've gotten rusty." }, 
			Cash = 4000
		}, {
			Class = "Student", 
			Name = "Julia", 
			Party = { {
					Name = "Statikeet", 
					Level = 17
				}, {
					Name = "Borbek", 
					Level = 17
				} }, 
			BattleScene = "Route1", 
			Interact = { "I'm lost!" }, 
			BeatenInteract = { "I'm lost!" }, 
			LoseBattle = { "Can you help find my home?" }, 
			WinBattle = { "Can you help find my home?" }, 
			Cash = 1600
		}, {
			Class = "Student", 
			Name = "Rob", 
			Party = { {
					Name = "Archuma", 
					Level = 19
				} }, 
			BattleScene = "Route1", 
			Interact = { "Where am I?" }, 
			BeatenInteract = { "Where am I?" }, 
			LoseBattle = { "...I don't remember." }, 
			WinBattle = { "How did I get here?" }, 
			Cash = 1600
		}, {
			Class = "Hiker", 
			Name = "Oscar", 
			Party = { {
					Name = "Pebblett", 
					Level = 19
				}, {
					Name = "Squed", 
					Level = 19
				} }, 
			BattleScene = "Route1", 
			Interact = { "Exploring this land is rewarding!" }, 
			BeatenInteract = { "Exploring this land is rewarding!" }, 
			LoseBattle = { "Lame." }, 
			WinBattle = { "How I lose?" }, 
			Cash = 1800
		}, {
			Class = "Tourist", 
			Name = "Alaina", 
			Party = { {
					Name = "Shelldo", 
					Level = 15
				}, {
					Name = "Shelldo", 
					Level = 15
				}, {
					Name = "Shelldo", 
					Level = 15
				}, {
					Name = "Shelldo", 
					Level = 15
				} }, 
			BattleScene = "Route1", 
			Interact = { "I'm hungry, gotta crack some eggs." }, 
			BeatenInteract = { "...still hungry." }, 
			LoseBattle = { "Wait, those were Shelldo?!" }, 
			WinBattle = { "Wait, those were Shelldo?!" }, 
			Cash = 1800
		}, {
			Class = "Tourist", 
			Name = "Chris", 
			Party = { {
					Name = "Gemin", 
					Level = 15
				}, {
					Name = "Webennae", 
					Level = 15
				}, {
					Name = "Toxipupa", 
					Level = 15
				}, {
					Name = "Roscoon", 
					Level = 15
				} }, 
			BattleScene = "Route1", 
			Interact = { "The best offense is defense!" }, 
			BeatenInteract = { "I guess you need a little bit of offense..." }, 
			LoseBattle = { "I told you so!" }, 
			WinBattle = { "I guess you need a little bit of offense...'" }, 
			Cash = 1800
		} }
};
