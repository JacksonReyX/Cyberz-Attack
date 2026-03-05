extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

@export var dungeon_music: AudioStream
@export var combat_music: AudioStream
@export var menu_music: AudioStream

func play_menu():
	_play(menu_music)

func play_dungeon():
	_play(dungeon_music)

func play_combat():
	_play(combat_music)

func _play(stream: AudioStream):
	if player.stream == stream:
		return
	player.stream = stream
	player.play()
