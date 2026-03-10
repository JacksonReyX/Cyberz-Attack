extends Node2D

@export var prompt_normal: Texture2D
@export var prompt_pressed: Texture2D

@export var sign: Texture2D

@onready var prompt: Sprite2D = $Prompt
@onready var sign_sprite: Sprite2D = $Sprite2D
@onready var interact_area: Area2D = $InteractArea

var player_in_range := false
var opened := false
var opening := false

func _ready() -> void:
	prompt.visible = false
	prompt.texture = prompt_normal

	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range and not opened and not opening:
		if Input.is_action_just_pressed("interact"):
			prompt.texture = prompt_pressed
			interact()

		if Input.is_action_just_released("interact"):
			prompt.texture = prompt_normal

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not opened:
		player_in_range = true
		prompt.visible = true
		prompt.texture = prompt_normal

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false

func interact() -> void:
	if opened or opening:
		return

	opening = true
	prompt.visible = false
	Sfx.sign()

	opening = false
	opened = true
	print("Sign opened")
