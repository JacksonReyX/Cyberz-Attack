extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer

@onready var key_hud: Control = %KeyHUD
@onready var key_icon: TextureRect = %KeyIcon


func _on_body_entered(body: Node2D) -> void:
	print("key found")
	GameState.keys += 1
	animation_player.play("pickup")
	key_icon.visible = true
	
	key_hud.show_key_message()
