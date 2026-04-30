extends Node2D

@onready var loading_label: Label = $LoadingLabel
@onready var char1: AnimatedSprite2D = $CharactersRow/Character1/AnimatedSprite2D
@onready var char2: AnimatedSprite2D = $CharactersRow/Character2/AnimatedSprite2D
@onready var char3: AnimatedSprite2D = $CharactersRow/Character3/AnimatedSprite2D

var dot_count := 1
var dot_cycles := 0
var max_cycles := 2

func _ready() -> void:
	char1.play("run")
	char2.play("run")
	char3.play("run")
	loading_label.text = "Loading."
	_animate_dots()

func _animate_dots() -> void:
	while dot_cycles < max_cycles * 3:
		await get_tree().create_timer(0.4).timeout
		dot_count += 1
		if dot_count > 3:
			dot_count = 1
			dot_cycles += 1
		loading_label.text = "Loading" + ".".repeat(dot_count)

	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
