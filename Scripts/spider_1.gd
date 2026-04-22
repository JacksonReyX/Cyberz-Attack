extends StaticBody2D

const SPEED = 20

var direction = 1
@onready var right: RayCast2D = $RayCast2D
@onready var left: RayCast2D = $RayCast2D2
@onready var spider: AnimatedSprite2D = $AnimatedSprite2D

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	if right.is_colliding():
		direction = -1
		spider.flip_h = true
	if left.is_colliding():
		direction = 1
		spider.flip_h = false
	position.x += direction * SPEED * delta
	
	
