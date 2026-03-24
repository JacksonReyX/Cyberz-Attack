extends Control

@export var full_heart_texture: Texture2D
@export var empty_heart_texture: Texture2D

@onready var heart_overlay: TextureRect = %HeartOverlay

@onready var segments: Array = [
	%Segment1,
	%Segment2,
	%Segment3,
	%Segment4,
	%Segment5,
	%Segment6,
	%Segment7,
	%Segment8,
	%Segment9,
	%Segment10,
	%Segment11,
	%Segment12
]

var max_health := 12
var current_health := 12

func _ready() -> void:
	for segment in segments:
		segment.set_full()
		
	await get_tree().create_timer(1.0).timeout
	await damage(1)
	await get_tree().create_timer(0.5).timeout
	await damage(2)
	await get_tree().create_timer(0.8).timeout
	await heal(1)
	await get_tree().create_timer(0.8).timeout
	await heal(2)
	await get_tree().create_timer(0.8).timeout
	await damage(12)

	_update_heart()

func set_health(new_health: int) -> void:
	new_health = clampi(new_health, 0, max_health)

	if new_health == current_health:
		return

	if new_health < current_health:
		await _lose_health(current_health, new_health)
	elif new_health > current_health:
		await _gain_health(current_health, new_health)

	current_health = new_health
	_update_heart()

func damage(amount: int) -> void:
	await set_health(current_health - amount)

func heal(amount: int) -> void:
	await set_health(current_health + amount)

func _lose_health(old_health: int, new_health: int) -> void:
	for i in range(old_health - 1, new_health - 1, -1):
		await segments[i].play_lose_animation()

func _gain_health(old_health: int, new_health: int) -> void:
	for i in range(old_health, new_health):
		await segments[i].play_heal_animation()

func _update_heart() -> void:
	if current_health <= 0:
		if empty_heart_texture:
			heart_overlay.texture = empty_heart_texture
	else:
		if full_heart_texture:
			heart_overlay.texture = full_heart_texture
