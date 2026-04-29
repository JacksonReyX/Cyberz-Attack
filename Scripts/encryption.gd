extends Area2D

@onready var prompt: Sprite2D = $Eprompt
@onready var arrow: AnimatedSprite2D = $arrow
@onready var textbox = $Textbox

var e_idle = preload("res://assets/Menus/Buttons/prompt_normal.png")
var e_pressed = preload("res://assets/Menus/Buttons/prompt_pressed.png")
var player_in_range = false
var is_talking = false

# Dialogue lines — add as many as you want
var dialogue_lines = [
	"Encyrption and Hashing are both ways of\nsecurely storing and transfering data",
	"Encyption is a 2 way process",
	"It uses an algorithm to change your\ndata to anunreadable\nformat of characters",
	"It then uses a key to decrypt the data and\nchange it back to its original form",
	"This is used to store data\nthat needs to be\nretreieved such as emails and credit cards!",
	"Hashing is another way of storing data",
	"It is a 1 way process", 
	"Similar to encryption\nit uses an algorithm to change your \ndata to anunreadable jumble\nof characters", 
	"The difference is once\na value is hashed\nit can not be changed back to\nits original data", 
	"The same input is always hashed\nto the same value.\nSo the same password will hash\nto the same hash valye",
	"This is used to store data that\ndoesn't need to be \nretrieved just checked against",
	"A common example would be passwords", 
	"Understanding how your data is stored\nis important to internet safety and\ndata security"
	
]
var current_line = 0

func _ready():
	prompt.visible = false
	prompt.texture = e_idle
	arrow.visible = true
	arrow.play("default")
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		arrow.visible = false
		prompt.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false
		arrow.visible = true
		# Reset dialogue when player leaves
		current_line = 0
		textbox.hide_text()
		is_talking = false

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if not is_talking:
			prompt.texture = e_pressed
			is_talking = true
			current_line = 0
			textbox.show_text(dialogue_lines[current_line])
		elif not textbox.is_done():
			# Skip typing animation to end
			textbox.skip_to_end()
		elif textbox.is_done():
			# Advance to next line or close
			current_line += 1
			if current_line < dialogue_lines.size():
				textbox.show_text(dialogue_lines[current_line])
			else:
				textbox.hide_text()
				prompt.texture = e_idle
				prompt.visible = true
				is_talking = false
