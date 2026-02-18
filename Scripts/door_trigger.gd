extends Area2D

@export var target_marker: NodePath
@export var lock_seconds: float = 0.35

func _ready() -> void:
	body_entered.connect(_on_body_entered)

func _on_body_entered(body: Node) -> void:
	# Find the player in case a child collider enters
	var p: Node = body
	while p and not p.is_in_group("player"):
		p = p.get_parent()
	if p == null:
		return

	# Use the door_lock directly
	if p.door_lock:
		return

	var marker := get_node_or_null(target_marker) as Node2D
	if marker == null:
		push_warning("Door target not set.")
		return

	# Lock + teleport
	p.door_lock = true
	p.global_position = marker.global_position

	await get_tree().create_timer(lock_seconds).timeout
	p.door_lock = false
