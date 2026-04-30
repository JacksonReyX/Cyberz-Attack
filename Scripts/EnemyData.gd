extends Node

var enemies = {
	"Phisher": {
		"display_name": "Phisher",
		"description": "A sneaky cyber criminal who steals your info!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/FisherEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 4,
		"questions": [
			{
				"question": "What is phishing?",
				"options": [
					"A fishing sport",
					"A scam for your info",
					"A computer virus",
					"A safe website"
				],
				"correct": 1
			},
			{
				"question": "A phishing email often...",
				"options": [
					"Comes from a friend",
					"Has perfect spelling",
					"Asks for your password",
					"Has no links"
				],
				"correct": 2
			},
			{
				"question": "What do you do with a suspicious email?",
				"options": [
					"Click all links",
					"Reply with info",
					"Delete and tell an adult",
					"Forward to everyone"
				],
				"correct": 2
			},
			{
				"question": "What does a phisher want?",
				"options": [
					"Your homework",
					"Your personal info",
					"Your video games",
					"Your lunch"
				],
				"correct": 1
			},
			{
				"question": "A site asks your address for a prize. You...",
				"options": [
					"Enter it right away",
					"Ask a trusted adult",
					"Share with friends",
					"Enter a fake one"
				],
				"correct": 1
			}
		]
	},
	"Hacker": {
		"display_name": "Hacker",
		"description": "Tries to break into your accounts!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/HackerEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 3,
		"questions": [
			{
				"question": "What makes a strong password?",
				"options": [
					"Your birthday",
					"password123",
					"Letters numbers symbols",
					"Your pet's name"
				],
				"correct": 2
			},
			{
				"question": "How often should you change passwords?",
				"options": [
					"Never",
					"Every few months",
					"Only if forgotten",
					"Once a year"
				],
				"correct": 1
			},
			{
				"question": "What is two-factor authentication?",
				"options": [
					"Two passwords",
					"A second identity check",
					"Logging in twice",
					"Two devices"
				],
				"correct": 1
			},
			{
				"question": "Should you share your password?",
				"options": [
					"Yes always",
					"Only with friends",
					"Never share passwords",
					"Only for games"
				],
				"correct": 2
			},
			{
				"question": "If your account is hacked you should...",
				"options": [
					"Ignore it",
					"Tell an adult and change it",
					"Delete the app",
					"Make a new account"
				],
				"correct": 1
			}
		]
	},
	"Malware": {
		"display_name": "Malware",
		"description": "Nasty software that damages your files!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/MalwareEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 3,
		"questions": [
			{
				"question": "What is malware?",
				"options": [
					"A helpful program",
					"Software that causes damage",
					"A type of hardware",
					"A browser"
				],
				"correct": 1
			},
			{
				"question": "How do you protect against malware?",
				"options": [
					"Download everything",
					"Turn off computer",
					"Use antivirus software",
					"Share your files"
				],
				"correct": 2
			},
			{
				"question": "A sign your device has malware is...",
				"options": [
					"Runs faster",
					"Shuts down randomly",
					"Brighter screen",
					"Faster keyboard"
				],
				"correct": 1
			},
			{
				"question": "Where can malware come from?",
				"options": [
					"Only emails",
					"Unknown websites",
					"Playing games",
					"Watching videos"
				],
				"correct": 1
			},
			{
				"question": "Before downloading a file you should...",
				"options": [
					"Download right away",
					"Check it is trusted",
					"Share with friends",
					"Open it immediately"
				],
				"correct": 1
			}
		]
	},
	"Scammer": {
		"display_name": "Scammer",
		"description": "Tricks you into giving away money!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/ScammerEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 2,
		"questions": [
			{
				"question": "Someone offers a free console online. You...",
				"options": [
					"Give your address",
					"Ignore it is a scam",
					"Send shipping money",
					"Tell all friends"
				],
				"correct": 1
			},
			{
				"question": "A pop-up says you won a prize. You...",
				"options": [
					"Click it right away",
					"Enter your info",
					"Close and tell an adult",
					"Share the link"
				],
				"correct": 2
			},
			{
				"question": "A sign of an online scam is...",
				"options": [
					"Too good to be true",
					"Professional website",
					"Has your name",
					"Short message"
				],
				"correct": 0
			},
			{
				"question": "Someone online wants you to keep a deal secret. You...",
				"options": [
					"Keep the secret",
					"Tell your parents",
					"Ask friends",
					"Agree to deal"
				],
				"correct": 1
			},
			{
				"question": "Never send someone online your...",
				"options": [
					"Favorite song",
					"Funny picture",
					"Home address",
					"Game username"
				],
				"correct": 2
			}
		]
	},
	"Virus": {
		"display_name": "Virus",
		"description": "Spreads and infects your files!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/VirusEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 4,
		"questions": [
			{
				"question": "What does a computer virus do?",
				"options": [
					"Speeds up computer",
					"Spreads and damages files",
					"Protects your data",
					"Cleans computer"
				],
				"correct": 1
			},
			{
				"question": "How can a virus reach your computer?",
				"options": [
					"Watching videos",
					"Infected email attachments",
					"Charging device",
					"Using headphones"
				],
				"correct": 1
			},
			{
				"question": "What protects you from viruses?",
				"options": [
					"Downloading lots of apps",
					"Turning up volume",
					"Updated antivirus",
					"Using more tabs"
				],
				"correct": 2
			},
			{
				"question": "Should you open unknown email attachments?",
				"options": [
					"Yes always",
					"If it looks interesting",
					"No it could be a virus",
					"Only on weekends"
				],
				"correct": 2
			},
			{
				"question": "If your computer acts strangely you should...",
				"options": [
					"Ignore it",
					"Download more programs",
					"Tell a trusted adult",
					"Turn volume down"
				],
				"correct": 2
			}
		]
	},
	"Spyware": {
		"display_name": "Spyware",
		"description": "Secretly watches everything you do!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/SpywareEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 3,
		"questions": [
			{
				"question": "What does spyware do?",
				"options": [
					"Speeds up computer",
					"Secretly monitors you",
					"Protects passwords",
					"Downloads games"
				],
				"correct": 1
			},
			{
				"question": "How do you avoid spyware?",
				"options": [
					"Download from anywhere",
					"Only use trusted sources",
					"Share your screen",
					"Turn off firewall"
				],
				"correct": 1
			},
			{
				"question": "What might spyware steal?",
				"options": [
					"Your favorite color",
					"Passwords and info",
					"Your playlist",
					"Game scores"
				],
				"correct": 1
			},
			{
				"question": "How do you protect against spyware?",
				"options": [
					"Same password everywhere",
					"Click every ad",
					"Keep software updated",
					"Share location always"
				],
				"correct": 2
			},
			{
				"question": "An app asks for too many permissions. You...",
				"options": [
					"Allow everything",
					"Question and ask adult",
					"Delete all apps",
					"Ignore it"
				],
				"correct": 1
			}
		]
	},
	"Troller": {
		"display_name": "Troller",
		"description": "Tries to upset and bully people online!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/TrollerEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 3,
		"questions": [
			{
				"question": "Someone is mean to you online. You...",
				"options": [
					"Be mean back",
					"Tell adult and block them",
					"Share their messages",
					"Keep it secret"
				],
				"correct": 1
			},
			{
				"question": "What is cyberbullying?",
				"options": [
					"Playing games online",
					"Using tech to bully someone",
					"Making friends online",
					"Sharing videos"
				],
				"correct": 1
			},
			{
				"question": "You see someone bullied online. You...",
				"options": [
					"Join in",
					"Ignore it",
					"Report and support them",
					"Share the posts"
				],
				"correct": 2
			},
			{
				"question": "Should you reply to mean messages?",
				"options": [
					"Yes be meaner",
					"No block and tell adult",
					"Yes defend yourself",
					"Share with friends"
				],
				"correct": 1
			},
			{
				"question": "Online content makes you feel unsafe. You...",
				"options": [
					"Keep scrolling",
					"Share it",
					"Tell a trusted adult",
					"Reply to it"
				],
				"correct": 2
			}
		]
	},
	"DataThief": {
		"display_name": "Data Thief",
		"description": "Steals your personal data silently!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/DataThiefEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 2,
		"questions": [
			{
				"question": "What is personal data?",
				"options": [
					"Your favorite games",
					"Info that identifies you",
					"Your grades",
					"Your music taste"
				],
				"correct": 1
			},
			{
				"question": "Which is safe to share online?",
				"options": [
					"Home address",
					"Phone number",
					"Favorite color",
					"School name"
				],
				"correct": 2
			},
			{
				"question": "Why protect your personal data?",
				"options": [
					"It is not important",
					"Prevent theft stay safe",
					"Get more followers",
					"Win prizes"
				],
				"correct": 1
			},
			{
				"question": "Before sharing info on a site you should...",
				"options": [
					"Share everything",
					"Ask adult if safe",
					"Post on social media",
					"Ignore privacy settings"
				],
				"correct": 1
			},
			{
				"question": "What is identity theft?",
				"options": [
					"Forgetting password",
					"Someone pretends to be you",
					"Sharing photos",
					"Making new account"
				],
				"correct": 1
			}
		]
	},
	"Ransomware": {
		"display_name": "Ransomware",
		"description": "Locks your files and demands payment!",
		"animation_frames": "res://Assets/Characters/CharactersAnimations/RansomwareEnemyIdle.tres",
		"health": 12,
		"damage_per_correct": 2,
		"questions": [
			{
				"question": "What does ransomware do?",
				"options": [
					"Speeds up computer",
					"Locks files demands money",
					"Protects your data",
					"Downloads movies"
				],
				"correct": 1
			},
			{
				"question": "How do you protect from ransomware?",
				"options": [
					"Pay when asked",
					"Back up files regularly",
					"Share files online",
					"Download unknown programs"
				],
				"correct": 1
			},
			{
				"question": "Ransomware locks your computer. You...",
				"options": [
					"Pay the ransom",
					"Tell adult and authorities",
					"Ignore it",
					"Download more programs"
				],
				"correct": 1
			},
			{
				"question": "What is a backup?",
				"options": [
					"A second computer",
					"A safe copy of files",
					"A type of virus",
					"A password manager"
				],
				"correct": 1
			},
			{
				"question": "Which habit helps against ransomware?",
				"options": [
					"Open all attachments",
					"Update software back up files",
					"Share files publicly",
					"Use weak passwords"
				],
				"correct": 1
			}
		]
	}
}
