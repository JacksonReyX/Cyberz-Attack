extends Area2D


@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound



func _on_body_entered(body: Node2D) -> void:
	GameState.add_coins(1)
	
	pickup_sound.get_parent().remove_child(pickup_sound)
	get_tree().current_scene.add_child(pickup_sound)
	pickup_sound.play()
	
	queue_free()
