extends CharacterBody2D

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
	
func _on_area_2d_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		die()
		
func die():
	var splatter = preload("res://Scenes/sabella/splatter.tscn").instantiate()
	splatter.global_position = global_position
	get_parent().add_child(splatter)

	queue_free()
