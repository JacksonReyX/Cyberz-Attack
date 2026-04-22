extends CharacterBody2D

const SPEED = 20

var direction = 1 

@onready var up: RayCast2D = $RayCast2D
@onready var down: RayCast2D = $RayCast2D2
@onready var spider: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	# Only flip if moving UP and hit something above
	if direction == -1 and up.is_colliding():
		direction = 1
		spider.flip_v = false

	# Only flip if moving DOWN and hit something below
	elif direction == 1 and down.is_colliding():
		direction = -1
		spider.flip_v = true

	velocity.x = 0
	velocity.y = direction * SPEED
	move_and_slide()
