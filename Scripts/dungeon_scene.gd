extends Node2D

@onready var pause_menu: Control = $PauseLayer/PauseMenu

@onready var options_button: TextureButton = $HUDLayer/HUD/OptionsButton

func _ready() -> void:
	pause_menu.visible = false
	UISfx.wire_buttons($HUDLayer/HUD)
	options_button.pressed.connect(_on_options_button_pressed)

func _unhandled_input(event: InputEvent) -> void:
	if event.is_action_pressed("Pause"):
		_toggle_pause()

func _toggle_pause() -> void:
	get_tree().paused = not get_tree().paused
	pause_menu.visible = get_tree().paused

	if get_tree().paused:
		pause_menu.main_buttons.visible = true
		pause_menu.volume_panel.visible = false
		
func _on_options_button_pressed() -> void:
	if not get_tree().paused:
		_toggle_pause()
