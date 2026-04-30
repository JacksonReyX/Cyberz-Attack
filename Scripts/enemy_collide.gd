extends Area2D

@export var encounter_text: String = "I need your clicks"
@export var enemy_name_override: String = "Phisherman"

@onready var textTimer: Timer = $"../textTimer"
@onready var textbox = $"../Textbox"

func _ready() -> void:
	textbox.hide_text()
	add_to_group("enemies")

func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		print("body node: ", body.name)
		print("body script: ", body.get_script())
		print("has movement_locked: ", "movement_locked" in body)
		if GameState.returning_from_battle:
			return
		


		var actual_enemy_name = get_parent().name
		GameState.active_enemy_name = actual_enemy_name

		var direction_away = (body.global_position - global_position).normalized()
		GameState.playerPosition = body.global_position + direction_away * 40

		GameState.returning_from_battle = true

		# Freeze player completely
		body.set_physics_process(false)
		body.set_process(false)
		body.velocity = Vector2.ZERO
		body.movement_locked = true

		textbox.show_text(encounter_text)
		textTimer.start()

func _on_text_timer_timeout() -> void:
	textbox.hide_text()
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/KianStuff/BattleScene.tscn")
	
