extends Control


func _on_play_button_pressed() -> void:
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
	



func _on_back_button_pressed() -> void:
	MusicManager.play_menu()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")
