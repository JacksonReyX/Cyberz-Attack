extends Node2D

@export var full_texture: Texture2D
@export var heal_flash_texture: Texture2D
@export var empty_texture: Texture2D

@onready var sprite: Sprite2D = $Sprite2D

var original_position: Vector2
var is_full := true

func _ready() -> void:
	original_position = position
	if full_texture:
		sprite.texture = full_texture
	visible = true

func set_full() -> void:
	is_full = true
	visible = true
	position = original_position
	modulate = Color(1, 1, 1, 1)
	if full_texture:
		sprite.texture = full_texture

func set_empty() -> void:
	is_full = false
	visible = false
	position = original_position
	modulate = Color(1, 1, 1, 1)
	if empty_texture:
		sprite.texture = empty_texture

func play_lose_animation() -> void:
	if not is_full:
		return

	is_full = false
	visible = true

	if full_texture:
		sprite.texture = full_texture

	var tween := create_tween()
	tween.set_parallel(false)

	# small pop upward/right
	tween.tween_property(self, "position", original_position + Vector2(3, -4), 0.08)

	# fall downward/right
	tween.tween_property(self, "position", original_position + Vector2(5, 6), 0.14)

	# fade while falling
	var fade_tween := create_tween()
	fade_tween.tween_property(self, "modulate:a", 0.0, 0.22)

	await tween.finished
	await fade_tween.finished

	visible = false
	position = original_position
	modulate = Color(1, 1, 1, 1)

	if empty_texture:
		sprite.texture = empty_texture

func play_heal_animation() -> void:
	if heal_flash_texture:
		sprite.texture = heal_flash_texture

	visible = true
	position = original_position
	modulate = Color(1, 1, 1, 1)

	var tween := create_tween()
	tween.tween_property(self, "modulate:a", 0.4, 0.06)
	tween.tween_property(self, "modulate:a", 1.0, 0.06)
	tween.tween_property(self, "modulate:a", 0.4, 0.06)
	tween.tween_property(self, "modulate:a", 1.0, 0.06)

	await tween.finished

	is_full = true
	if full_texture:
		sprite.texture = full_texture
