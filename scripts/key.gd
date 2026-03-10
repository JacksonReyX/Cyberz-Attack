extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var key_icon: TextureRect = $"../../CanvasLayer/KeyHUD/KeyIcon"

func _on_body_entered(body: Node2D) -> void:
	print("key found")
	animation_player.play("pickup")
	key_icon.visible = true
