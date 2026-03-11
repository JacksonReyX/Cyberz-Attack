extends Node

@export var sign_stream: AudioStream
@export var chest_stream: AudioStream
@export var coin_stream: AudioStream
@export var door_stream: AudioStream

@export var sfx_bus_name := "SFX"

func _ready() -> void:
	AudioServer.set_bus_volume_db(AudioServer.get_bus_index("SFX"), -2.0)

func play(stream: AudioStream) -> void:
	if stream == null:
		push_warning("[Sfx] stream is null")
		return

	var p := AudioStreamPlayer.new()
	add_child(p)
	p.stream = stream

	if AudioServer.get_bus_index(sfx_bus_name) != -1:
		p.bus = sfx_bus_name
	else:
		p.bus = "Master"

	print("[Sfx] playing:", stream, " on bus:", p.bus)

	p.finished.connect(func(): p.queue_free())
	p.play()

func chest() -> void:
	print("[Sfx] sign() called. sign_stream =", sign_stream)
	play(sign_stream)
