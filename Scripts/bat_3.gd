extends CharacterBody2D

const SPEED = 20

var direction = 1

@onready var left: RayCast2D = $left
@onready var right: RayCast2D = $right
@onready var bat: AnimatedSprite2D = $AnimatedSprite2D

func _physics_process(delta: float) -> void:
	if right.is_colliding():
		direction = -1
		bat.flip_h = false
		
	elif left.is_colliding():
		direction = 1
		bat.flip_h = true

	velocity.x = direction * SPEED
	move_and_slide()
