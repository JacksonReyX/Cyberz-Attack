extends Node

var enemies = {
	"Phisher": {
		"display_name": "Phisher",
		"description": "A sneaky cyber criminal who steals your info!",
		"animation_frames": "res://Assets/Characters/Enemies/PhisherFrames.tres",
		"health": 3,
		"questions": [
			{
				"question": "What is phishing?",
				"options": [
					"A type of fishing sport",
					"A scam to steal your personal info",
					"A computer virus",
					"A safe website"
				],
				"correct": 1
			},
			{
				"question": "Which is a sign of a phishing email?",
				"options": [
					"It comes from your best friend",
					"It has perfect spelling",
					"It asks for your password urgently",
					"It has no links"
				],
				"correct": 2
			},
			{
				"question": "What should you do with a suspicious email?",
				"options": [
					"Click all the links",
					"Reply with your password",
					"Delete it and tell a trusted adult",
					"Forward it to everyone"
				],
				"correct": 2
			}
		]
	},
	"Hacker": {
		"display_name": "Hacker",
		"description": "Tries to break into your accounts!",
		"animation_frames": "res://Assets/Characters/Enemies/HackerFrames.tres",
		"health": 3,
		"questions": [
			{
				"question": "What makes a strong password?",
				"options": [
					"Your name and birthday",
					"password123",
					"A mix of letters numbers and symbols",
					"Your pet's name"
				],
				"correct": 2
			},
			{
				"question": "How often should you change important passwords?",
				"options": [
					"Never",
					"Every few months",
					"Only when you forget them",
					"Once a year"
				],
				"correct": 1
			},
			{
				"question": "What is two-factor authentication?",
				"options": [
					"Having two passwords",
					"A second step to verify your identity",
					"Logging in twice",
					"Using two devices"
				],
				"correct": 1
			}
		]
	},
	"Malware": {
		"display_name": "Malware",
		"description": "Nasty software that damages your computer!",
		"animation_frames": "res://Assets/Characters/Enemies/MalwareFrames.tres",
		"health": 3,
		"questions": [
			{
				"question": "What is malware?",
				"options": [
					"A helpful computer program",
					"Software designed to cause damage",
					"A type of hardware",
					"An internet browser"
				],
				"correct": 1
			},
			{
				"question": "How can you protect against malware?",
				"options": [
					"Download everything you see",
					"Turn off your computer",
					"Install antivirus software",
					"Share your files with everyone"
				],
				"correct": 2
			},
			{
				"question": "Which is a sign your device has malware?",
				"options": [
					"It runs faster than usual",
					"It shuts down unexpectedly",
					"The screen gets brighter",
					"Your keyboard types faster"
				],
				"correct": 1
			}
		]
	},
	"Scammer": {
		"display_name": "Scammer",
		"description": "Tricks you into giving away money or info!",
		"animation_frames": "res://Assets/Characters/Enemies/ScammerFrames.tres",
		"health": 3,
		"questions": [
			{
				"question": "Someone online offers you a free gaming console. What do you do?",
				"options": [
					"Give them your address immediately",
					"It is probably a scam ignore it",
					"Send them money to cover shipping",
					"Share it with all your friends"
				],
				"correct": 1
			},
			{
				"question": "A pop-up says you won a prize. What should you do?",
				"options": [
					"Click it immediately",
					"Enter your personal info",
					"Close it and tell a trusted adult",
					"Share the link"
				],
				"correct": 2
			},
			{
				"question": "What is a telltale sign of an online scam?",
				"options": [
					"The offer sounds too good to be true",
					"The website looks professional",
					"The email has your name in it",
					"The message is short"
				],
				"correct": 0
			}
		]
	}
}
