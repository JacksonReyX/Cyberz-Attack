extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

@export var dungeon_music: AudioStream
@export var combat_music: AudioStream
@export var menu_music: AudioStream

func _ready() -> void:
	player.bus = "Music"
	SettingsState.apply_all_buses()

func play_menu() -> void:
	_play(menu_music)

func play_dungeon() -> void:
	_play(dungeon_music)

func play_combat() -> void:
	_play(combat_music)

func _play(stream: AudioStream) -> void:
	if stream == null:
		return
	if player.stream == stream and player.playing:
		return
	player.stream = stream
	player.play()
