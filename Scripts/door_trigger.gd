extends Area2D

@export var target_marker: NodePath
@export var lock_seconds: float = 0.35
@export var prompt_normal: Texture2D
@export var prompt_pressed: Texture2D

@onready var prompt: Sprite2D = $EPrompt

var player_in_range: bool = false
var player_ref: Node = null

func _ready() -> void:
	prompt.visible = false
	if prompt_normal:
		prompt.texture = prompt_normal
	body_entered.connect(_on_body_entered)
	body_exited.connect(_on_body_exited)

func _on_body_entered(body: Node) -> void:
	var p: Node = body
	while p and not p.is_in_group("player"):
		p = p.get_parent()
	if p == null:
		return
	player_in_range = true
	player_ref = p
	prompt.visible = true

func _on_body_exited(body: Node) -> void:
	var p: Node = body
	while p and not p.is_in_group("player"):
		p = p.get_parent()
	if p == null:
		return
	player_in_range = false
	player_ref = null
	prompt.visible = false
	if prompt_normal:
		prompt.texture = prompt_normal

func _process(_delta: float) -> void:
	if player_in_range and player_ref != null:
		if Input.is_action_just_pressed("interact"):
			await _use_door()

func _use_door() -> void:
	if player_ref == null:
		return
	if player_ref.door_lock:
		return
		
	var marker := get_node_or_null(target_marker) as Node2D
	if marker == null:
		push_warning("Door target not set.")
		return

	# Store local reference so it persists through awaits
	var p = player_ref

	if prompt and prompt_pressed:
		prompt.texture = prompt_pressed

	p.door_lock = true
	await get_tree().create_timer(0.15).timeout
	p.global_position = marker.global_position
	if prompt:
		prompt.visible = false
	await get_tree().create_timer(lock_seconds).timeout
	p.door_lock = false
	if prompt and prompt_normal:
		prompt.texture = prompt_normal
