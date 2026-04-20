extends Area2D
@onready var textTimer = $"../textTimer"
@onready var textbox = $Textbox
signal battle_triggered(enemy_node)

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		battle_triggered.emit(self)
		
		#save game state 
		GameState.playerPosition = body.global_position
		GameState.active_enemy_name = self.name
		GameState.returning_from_battle = true
		
		textbox.show()
		textTimer.start()
		
		
func _ready() -> void:
	textbox.hide()
	add_to_group("enemies")


func _on_text_timer_timeout() -> void:
	textbox.hide()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/JacksonStuff/fisherBattle.tscn")
