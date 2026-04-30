extends Area2D

@export var coin_id: String = ""
@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var pickup_sound: AudioStreamPlayer2D = $PickupSound

func _ready() -> void:
	# Hide if already collected
	if coin_id != "" and coin_id in GameState.defeatedEnemies:
		queue_free()

func _on_body_entered(body: Node2D) -> void:
	GameState.add_coins(1)
	if coin_id != "":
		GameState.defeatedEnemies.append(coin_id)
	pickup_sound.get_parent().remove_child(pickup_sound)
	get_tree().current_scene.add_child(pickup_sound)
	pickup_sound.play()
	queue_free()
