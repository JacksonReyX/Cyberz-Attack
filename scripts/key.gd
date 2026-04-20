extends Area2D

@onready var animation_player: AnimationPlayer = $AnimationPlayer
@onready var key_icon: TextureRect = $"../../../HUDLayer/HUDRoot/InventorySection/Slot2/ItemIcon"

@onready var key_hud: Control = $"../../../HUDLayer/HUDRoot/InventorySection"

@onready var key_pickup_sound: AudioStreamPlayer2D = $AudioStreamPlayer2D

func _on_body_entered(body: Node2D) -> void:
	GameState.keys += 1
	key_icon.visible = true
	key_hud.show_key_message()
	
	key_pickup_sound.get_parent().remove_child(key_pickup_sound)
	get_tree().current_scene.add_child(key_pickup_sound)
	key_pickup_sound.play()
	
	queue_free()
