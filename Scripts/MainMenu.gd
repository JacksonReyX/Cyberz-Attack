extends Control

@export_file("*.tscn") var character_customize_scene := "res://Scenes/KianStuff/CharacterCustomize.tscn"
@export_file("*.tscn") var info_scene := "res://Scenes/KianStuff/Info.tscn"

@onready var start_btn: TextureButton = $UILayer/Start
@onready var info_btn: TextureButton = $UILayer/Info
@onready var quit_btn: TextureButton = $UILayer/Quit

func _ready() -> void:
	MusicManager.play_menu()

	start_btn.pressed.connect(_on_start_pressed)
	info_btn.pressed.connect(_on_info_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(character_customize_scene)

func _on_info_pressed() -> void:
	get_tree().change_scene_to_file(info_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
