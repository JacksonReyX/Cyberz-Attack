extends Control

@export var health_full_texture: Texture2D
@export var health_empty_texture: Texture2D

@export var heart_full_texture: Texture2D
@export var heart_empty_texture: Texture2D

@onready var health_bar_background: Sprite2D = %HealthBarBackground
@onready var heart_overlay: Sprite2D = %HeartOverlay

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
	max_health = GameState.max_health
	current_health = GameState.current_health
	if health_bar_background and health_full_texture:
		health_bar_background.texture = health_full_texture
	if heart_overlay and heart_full_texture:
		heart_overlay.texture = heart_full_texture
	# Show correct number of segments based on saved health
	for i in range(segments.size()):
		if segments[i]:
			if i < current_health:
				segments[i].set_full()
			else:
				segments[i].set_empty()
	_update_bar_and_heart()
			
	

func set_health(new_health: int) -> void:
	new_health = clampi(new_health, 0, max_health)
	if new_health == current_health:
		return
	if new_health < current_health:
		await _lose_health(current_health, new_health)
	elif new_health > current_health:
		await _gain_health(current_health, new_health)
	current_health = new_health
	GameState.current_health = current_health  # Save to GameState
	_update_bar_and_heart()

func damage(amount: int) -> void:
	await set_health(current_health - amount)

func heal(amount: int) -> void:
	await set_health(current_health + amount)

func _lose_health(old_health: int, new_health: int) -> void:
	for i in range(old_health - 1, new_health - 1, -1):
		if segments[i]:
			await segments[i].play_lose_animation()

func _gain_health(old_health: int, new_health: int) -> void:
	for i in range(old_health, new_health):
		if segments[i]:
			await segments[i].play_heal_animation()

func _update_bar_and_heart() -> void:
	if current_health <= 0:
		if health_bar_background and health_empty_texture:
			health_bar_background.texture = health_empty_texture

		if heart_overlay and heart_empty_texture:
			heart_overlay.texture = heart_empty_texture
	else:
		if health_bar_background and health_full_texture:
			health_bar_background.texture = health_full_texture

		if heart_overlay and heart_full_texture:
			heart_overlay.texture = heart_full_texture
