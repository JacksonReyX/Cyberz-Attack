extends Node2D

@export var prompt_normal: Texture2D
@export var prompt_pressed: Texture2D

@export var normal_texture: Texture2D
@export var highlight_texture: Texture2D

@onready var prompt: Sprite2D = $Prompt
@onready var main_sprite: Sprite2D = $Sprite2D
@onready var interact_area: Area2D = $InteractArea

var player_in_range := false

func _ready() -> void:
	prompt.visible = false

	if prompt_normal:
		prompt.texture = prompt_normal

	if normal_texture:
		main_sprite.texture = normal_texture

	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range:
		if Input.is_action_just_pressed("interact"):
			if prompt_pressed:
				prompt.texture = prompt_pressed
			interact()

		if Input.is_action_just_released("interact"):
			if prompt_normal:
				prompt.texture = prompt_normal

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = true
		prompt.visible = true

		if highlight_texture:
			main_sprite.texture = highlight_texture

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false

		if normal_texture:
			main_sprite.texture = normal_texture

func interact() -> void:
	print("Interacted with ", name)
