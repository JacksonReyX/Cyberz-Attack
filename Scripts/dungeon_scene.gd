extends Node2D

@onready var pause_menu: Control = $PauseLayer/PauseMenu

@onready var options_button: TextureButton = $HUDLayer/HUDRoot/OptionsButton
@export var battle_scene_pack: PackedScene

# In DungeonScene.gd
# In DungeonScene.gd
func _ready() -> void:
	# 1. Force the menu hidden IMMEDIATELY
	pause_menu.hide() 
	pause_menu.visible = false
	
	GameState.load_data()
	UISfx.wire_buttons($HUDLayer/HUDRoot)
	options_button.pressed.connect(_on_options_button_pressed)
	
	# 2. NOW wait for the frame to process enemies
	await get_tree().process_frame
	
	if GameState.returning_from_battle:
		var player_node = get_node_or_null("CharacterBody2D")
		if player_node:
			player_node.global_position = GameState.playerPosition
		
		for enemy_area in get_tree().get_nodes_in_group("enemies"):
			var enemy_root = enemy_area.get_parent()
			if enemy_root.name in GameState.defeatedEnemies:
				enemy_root.queue_free()
		
		GameState.returning_from_battle = false
	

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
