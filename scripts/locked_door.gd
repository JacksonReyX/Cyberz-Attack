extends Area2D

@onready var sprite: AnimatedSprite2D = $AnimatedSprite2D
@onready var prompt: Sprite2D = $buttonPrompt
@onready var collision_shape_2d: CollisionShape2D = $StaticBody2D/CollisionShape2D


var player_in_range = false

func _ready():
	prompt.visible = false 
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _process(_delta):
	if player_in_range and Input.is_action_just_pressed("interact"):
		if GameState.keys > 0:
			GameState.keys -= 1
			sprite.play("open")
			collision_shape_2d.disabled = true
			prompt.visible = false
		else:
			print("Find key to unlock")

func _on_body_entered(body):
	if body.is_in_group("player"):
		player_in_range = true
		prompt.visible = true

func _on_body_exited(body):
	if body.is_in_group("player"):
		player_in_range = false
		prompt.visible = false
