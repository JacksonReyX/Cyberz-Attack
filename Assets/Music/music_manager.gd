extends Node

@export var dungeon_music: AudioStream
@export var combat_music: AudioStream
@export var menu_music: AudioStream

@onready var player: AudioStreamPlayer = $MusicPlayer

func _ready() -> void:
	play_dungeon()

func play_dungeon() -> void:
	_play(dungeon_music)

func play_combat() -> void:
	_play(combat_music)

func play_menu() -> void:
	_play(menu_music)

func stop_music() -> void:
	player.stop()

func _play(stream: AudioStream) -> void:
	if stream == null:
		return
	if player.stream == stream and player.playing:
		return
	player.stream = stream
	player.play()
