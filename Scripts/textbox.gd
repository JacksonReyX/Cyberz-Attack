extends CanvasLayer

@onready var label: Label = $TextureRect/Label
@onready var continue_label: Label = $TextureRect/ContinueLabel

@export var typing_sound_1: AudioStream
@export var typing_sound_2: AudioStream

var typing_player_1: AudioStreamPlayer
var typing_player_2: AudioStreamPlayer
var current_tween: Tween
var last_visible_chars: int = 0

func _ready() -> void:
	typing_player_1 = AudioStreamPlayer.new()
	typing_player_1.bus = "SFX"
	add_child(typing_player_1)

	typing_player_2 = AudioStreamPlayer.new()
	typing_player_2.bus = "SFX"
	add_child(typing_player_2)

	continue_label.visible = false
	hide()

func show_text(text: String) -> void:
	label.text = text
	label.visible_ratio = 0.0
	last_visible_chars = 0
	continue_label.visible = false
	show()

	if current_tween:
		current_tween.kill()

	current_tween = create_tween()
	current_tween.tween_method(
		_on_letter_revealed,
		0.0,
		1.0,
		text.length() * 0.05
	)
	current_tween.finished.connect(func():
		continue_label.visible = true
	, CONNECT_ONE_SHOT)

func _on_letter_revealed(ratio: float) -> void:
	label.visible_ratio = ratio
	var current_chars = int(ratio * label.text.length())
	if current_chars > last_visible_chars:
		last_visible_chars = current_chars
		_play_random_typing_sound()

func _play_random_typing_sound() -> void:
	if typing_sound_1 == null and typing_sound_2 == null:
		return
	var use_sound_1 = randi() % 2 == 0
	if use_sound_1 and typing_sound_1:
		typing_player_1.stream = typing_sound_1
		typing_player_1.play()
	elif typing_sound_2:
		typing_player_2.stream = typing_sound_2
		typing_player_2.play()

func hide_text() -> void:
	if current_tween:
		current_tween.kill()
	label.visible_ratio = 0.0
	continue_label.visible = false
	hide()

func skip_to_end() -> void:
	if current_tween:
		current_tween.kill()
	label.visible_ratio = 1.0
	last_visible_chars = label.text.length()
	continue_label.visible = true

func is_done() -> bool:
	return label.visible_ratio >= 1.0
