extends Node

@export var normal_cursor: Texture2D
@export var clicked_cursor: Texture2D
@export var hotspot: Vector2 = Vector2.ZERO

func _ready() -> void:
	_set_normal_cursor()

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		if event.pressed:
			_set_clicked_cursor()
		else:
			_set_normal_cursor()

func _set_normal_cursor() -> void:
	if normal_cursor:
		Input.set_custom_mouse_cursor(normal_cursor, Input.CURSOR_ARROW, hotspot)

func _set_clicked_cursor() -> void:
	if clicked_cursor:
		Input.set_custom_mouse_cursor(clicked_cursor, Input.CURSOR_ARROW, hotspot)
