extends Node

@export var click_stream: AudioStream
@export var hover_stream: AudioStream

@export var use_sfx_bus := true
@export var sfx_bus_name := "SFX"

var _player: AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	add_child(_player)
	_player.bus = "UI"
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("UI"), -4.0)

	if use_sfx_bus and AudioServer.get_bus_index(sfx_bus_name) != -1:
		_player.bus = sfx_bus_name
	else:
		_player.bus = "Master"

func play_click() -> void:
	if click_stream == null:
		push_warning("[UISfx] click_stream is NOT set")
		return
	_player.stream = click_stream
	_player.play()

func play_hover() -> void:
	if hover_stream == null:
		push_warning("[UISfx] hover_stream is NOT set")
		return
	_player.stream = hover_stream
	_player.play()

func wire_buttons(root: Node) -> void:
	for child in root.get_children():
		wire_buttons(child)

		if child is BaseButton:
			var b := child as BaseButton

			if not b.pressed.is_connected(play_click):
				b.pressed.connect(play_click)

			# Hover with mouse
			if not b.mouse_entered.is_connected(play_hover):
				b.mouse_entered.connect(play_hover)

			# Optional: hover when keyboard/controller focuses the button
			if not b.focus_entered.is_connected(play_hover):
				b.focus_entered.connect(play_hover)
