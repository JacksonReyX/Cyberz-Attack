extends Area2D
@onready var textTimer = $"../textTimer"
@onready var textbox = $Textbox
signal battle_triggered(enemy_node)

# In your Area2D Collision Script
func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		if GameState.returning_from_battle:
			return
		
		# GET THE PARENT NAME
		# If your hierarchy is Enemy(Node2D) -> Area2D, 
		# then get_parent().name is the unique name (e.g., "Fisher1")
		var actual_enemy_name = get_parent().name
		GameState.active_enemy_name = actual_enemy_name
		
		GameState.playerPosition = body.global_position
		GameState.returning_from_battle = true
		
		textbox.show()
		textTimer.start()
		
		
func _ready() -> void:
	textbox.hide()
	add_to_group("enemies")


func _on_text_timer_timeout() -> void:
	textbox.hide()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/JacksonStuff/fisherBattle.tscn")
