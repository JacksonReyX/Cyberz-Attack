extends Control

@onready var health_bar: TextureProgressBar = %HealthBar

func update_health(current_health: int, max_health: int) -> void:
	health_bar.max_value = max_health
	health_bar.value = current_health
