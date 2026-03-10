extends Area2D

@onready var coin_manager: Node = $"../../CoinManager"
@onready var animation_player: AnimationPlayer = $AnimationPlayer

func _on_body_entered(body: Node2D) -> void:
	coin_manager.add_point()
	animation_player.play("pickup")
