extends CharacterBody2D

@export var speed: float = 140.0

@export var tex_down: Texture2D
@export var tex_up: Texture2D
@export var tex_left: Texture2D
@export var tex_right: Texture2D

@onready var sprite: Sprite2D = $Sprite2D
@onready var health_bar: ProgressBar = $HealthBar


func _ready() -> void:
	if tex_down:
		sprite.texture = tex_down

func _physics_process(_delta: float) -> void:
	var input_vec := Vector2.ZERO

	if Input.is_action_pressed("move_right"):
		input_vec.x += 1
	if Input.is_action_pressed("move_left"):
		input_vec.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vec.y += 1
	if Input.is_action_pressed("move_up"):
		input_vec.y -= 1

	# Smooth diagonal movement
	input_vec = input_vec.normalized()

	velocity = input_vec * speed
	move_and_slide()

	# Change facing sprite based on last direction pressed
	if input_vec != Vector2.ZERO:
		if abs(input_vec.x) > abs(input_vec.y):
			sprite.texture = tex_right if input_vec.x > 0 else tex_left
		else:
			sprite.texture = tex_down if input_vec.y > 0 else tex_up
