extends Node2D

@onready var back_btn: TextureButton = $BackButton

func _ready() -> void:
	UISfx.wire_buttons(self)
	MusicManager.play_menu()
	
	
	back_btn.pressed.connect(_on_back_button_pressed)
	

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")
