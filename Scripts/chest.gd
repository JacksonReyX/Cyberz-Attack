extends Area2D

@export var prompt_normal: Texture2D
@export var prompt_pressed: Texture2D

@onready var prompt: Sprite2D = $Prompt

var player_in_range := false

func _ready() -> void:
	prompt.visible = false
	prompt.texture = prompt_normal

	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			prompt.texture = prompt_pressed
			interact()

		if Input.is_action_just_released("interact"):
			prompt.texture = prompt_normal

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		prompt.visible = true

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false

func interact() -> void:
	print("Interacted with:", name)
