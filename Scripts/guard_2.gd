extends Area2D

@onready var prompt: Sprite2D = $Eprompt
@onready var dialogue_label: Label = $Label
@onready var arrow: AnimatedSprite2D = $arrow

var e_idle = preload("res://assets/Menus/Buttons/prompt_normal.png")
var e_pressed = preload("res://assets/Menus/Buttons/prompt_pressed.png")

var player_in_range = false
var is_talking = false

func _ready():
	prompt.visible = false
	prompt.texture = e_idle

	dialogue_label.visible = false

	arrow.visible = true
	arrow.play("default")

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)


func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true

		if not is_talking:
			arrow.visible = false
			prompt.visible = true


func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false

		# DO NOT cancel dialogue here
		# Only hide prompt
		prompt.visible = false


func _process(_delta):
	if player_in_range and not is_talking and Input.is_action_just_pressed("interact"):
		start_dialogue()


func start_dialogue():
	is_talking = true

	prompt.texture = e_pressed
	prompt.visible = false

	arrow.visible = false

	await get_tree().create_timer(0.15).timeout

	dialogue_label.visible = true
	await type_text("Congrats! You've made it this far... but tougher enemies lie ahead.")

	await get_tree().create_timer(3.5).timeout

	end_dialogue()


func end_dialogue():
	dialogue_label.visible = false
	prompt.texture = e_idle

	is_talking = false

	# Decide final UI state AFTER dialogue ends
	if player_in_range:
		prompt.visible = true
	else:
		arrow.visible = true


func type_text(text: String) -> void:
	dialogue_label.text = ""

	for word in text.split(" "):
		dialogue_label.text += word + " "
		await get_tree().create_timer(0.25).timeout
