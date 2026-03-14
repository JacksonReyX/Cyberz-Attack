extends Node

@export var click_stream: AudioStream
@export var hover_stream: AudioStream
@export var slider_tick_stream: AudioStream

@export var ui_bus_name := "UI"

var _player: AudioStreamPlayer

func _ready() -> void:
	_player = AudioStreamPlayer.new()
	add_child(_player)

	if AudioServer.get_bus_index(ui_bus_name) != -1:
		_player.bus = ui_bus_name
	else:
		_player.bus = "Master"

	SettingsState.apply_all_buses()

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

			if not b.mouse_entered.is_connected(play_hover):
				b.mouse_entered.connect(play_hover)

			if not b.focus_entered.is_connected(play_hover):
				b.focus_entered.connect(play_hover)
				
func play_slider_tick() -> void:
	if slider_tick_stream == null:
		return
	_player.stream = slider_tick_stream
	_player.play()
