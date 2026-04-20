extends Node2D

@onready var pause_menu: Control = $PauseLayer/PauseMenu

@onready var options_button: TextureButton = $HUDLayer/HUDRoot/OptionsButton
@export var battle_scene_pack: PackedScene

func _ready() -> void:
	#load data
	GameState.load_data()
	
	pause_menu.visible = false
	UISfx.wire_buttons($HUDLayer/HUDRoot)
	options_button.pressed.connect(_on_options_button_pressed)
	
	if GameState.returning_from_battle:
		var player_node = get_node_or_null("CharacterBody2D")
		if player_node:
			player_node.global_position = GameState.playerPosition
			GameState.returning_from_battle = false
		for enemy in get_tree().get_nodes_in_group("enemies"):
			if enemy.name in GameState.defeatedEnemies:
				enemy.queue_free()
		
	

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
