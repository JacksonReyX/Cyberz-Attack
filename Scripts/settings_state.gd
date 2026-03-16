extends Node

var master_percent: float = 50.0
var music_percent: float = 50.0
var sfx_percent: float = 50.0
var ui_percent: float = 50.0

func percent_to_db(percent: float) -> float:
	if percent <= 0.0:
		return -80.0
	return lerpf(-30.0, 0.0, percent / 100.0)

func set_master_percent(value: float) -> void:
	master_percent = value
	_apply_bus("Master", master_percent)

func set_music_percent(value: float) -> void:
	music_percent = value
	_apply_bus("Music", music_percent)

func set_sfx_percent(value: float) -> void:
	sfx_percent = value
	_apply_bus("SFX", sfx_percent)

func set_ui_percent(value: float) -> void:
	ui_percent = value
	_apply_bus("UI", ui_percent)

func apply_all_buses() -> void:
	_apply_bus("Master", master_percent)
	_apply_bus("Music", music_percent)
	_apply_bus("SFX", sfx_percent)
	_apply_bus("UI", ui_percent)

func _apply_bus(bus_name: String, percent: float) -> void:
	var bus_index := AudioServer.get_bus_index(bus_name)
	if bus_index == -1:
		push_warning("Bus not found: " + bus_name)
		return

	AudioServer.set_bus_volume_db(bus_index, percent_to_db(percent))
