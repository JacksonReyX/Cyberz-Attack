extends Node

@onready var player: AudioStreamPlayer = $AudioStreamPlayer

func play_music(stream: AudioStream):
	player.stream = stream
	player.play()
