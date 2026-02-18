extends Area2D

@onready var key_manager: Node = %KeyManager

func _on_body_entered(body: Node2D) -> void:
	key_manager.key_found()
	queue_free()
