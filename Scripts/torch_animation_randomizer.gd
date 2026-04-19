extends StaticBody2D

@onready var animated_sprite_2d: AnimatedSprite2D = $AnimatedSprite2D
const animations = ["animation1", "animation2"]
@onready var light: PointLight2D = $PointLight2D


func _ready() -> void:
	animated_sprite_2d.play(animations.pick_random())

func disable_torch():
	light.visible = false
