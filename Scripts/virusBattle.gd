extends Area2D
@onready var enemyID = $id
@export var enemy_id: String 
@onready var textTimer = $"../textTimer"
@onready var textbox = $virusText


func _on_body_entered(body: Node2D) -> void:
	if body.is_in_group("player"):
		# Safely change the scenea
		textbox.show()
		textTimer.start()

func _ready() -> void:
	textbox.hide()
	add_to_group("enemies")


func _on_text_timer_timeout() -> void:
	get_tree().call_deferred("change_scene_to_file", "res://Scenes/JacksonStuff/virusBattle.tscn")
