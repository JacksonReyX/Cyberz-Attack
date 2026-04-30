extends TextureButton



# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_pressed() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/KianStuff/MainMenu.tscn")
