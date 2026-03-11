extends Control

@export_file("*.tscn") var main_menu_scene := "res://Scenes/KianStuff/MainMenu.tscn"

@onready var main_buttons: Control = %MainButtons
@onready var volume_panel: Control = %VolumePanel
@onready var back_button: TextureButton = %BackButton

@onready var resume_button: TextureButton = %ResumeButton
@onready var volume_button: TextureButton = %VolumeButton
@onready var main_menu_button: TextureButton = %MainMenuButton
@onready var quit_button: TextureButton = %QuitButton

func _ready() -> void:
	UISfx.wire_buttons(self)

	main_buttons.visible = true
	volume_panel.visible = false
	
	back_button.pressed.connect(_on_back_pressed)
	resume_button.pressed.connect(_on_resume_button_pressed)
	volume_button.pressed.connect(_on_volume_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false
	
	print("Resume clicked")
	get_tree().paused = false
	visible = false

func _on_volume_button_pressed() -> void:
	main_buttons.visible = false
	volume_panel.visible = true

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	MusicManager.play_menu()
	get_tree().change_scene_to_file(main_menu_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()
	
func _on_back_pressed() -> void:
	volume_panel.visible = false
	main_buttons.visible = true
