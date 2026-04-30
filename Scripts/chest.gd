extends Node2D

@export var chest_id: String = ""
@export var prompt_normal: Texture2D
@export var prompt_pressed: Texture2D
@export var chest_closed: Texture2D
@export var chest_closed_highlight: Texture2D
@export var chest_mid: Texture2D
@export var chest_open: Texture2D

@onready var prompt: Sprite2D = $Prompt
@onready var chest_sprite: Sprite2D = $Sprite2D
@onready var interact_area: Area2D = $InteractArea

var player_in_range := false
var opened := false
var opening := false

func _ready() -> void:
	prompt.visible = false
	prompt.texture = prompt_normal

	# If chest was already opened before battle, show it as open
	if chest_id != "" and chest_id in GameState.defeatedEnemies:
		chest_sprite.texture = chest_open
		opened = true
		return

	chest_sprite.texture = chest_closed
	interact_area.body_entered.connect(_on_body_entered)
	interact_area.body_exited.connect(_on_body_exited)

func _process(_delta: float) -> void:
	if player_in_range and not opened and not opening:
		if Input.is_action_just_pressed("interact"):
			prompt.texture = prompt_pressed
			interact()
		if Input.is_action_just_released("interact"):
			prompt.texture = prompt_normal

func _on_body_entered(body: Node) -> void:
	if body.is_in_group("player") and not opened:
		player_in_range = true
		prompt.visible = true
		chest_sprite.texture = chest_closed_highlight

func _on_body_exited(body: Node) -> void:
	if body.is_in_group("player") and not opened:
		player_in_range = false
		prompt.visible = false
		chest_sprite.texture = chest_closed

func interact() -> void:
	if opened or opening:
		return
	opening = true
	prompt.visible = false
	Sfx.chest()
	await _open_chest_animation()
	GameState.add_coins(20)
	GameState.health_potions += 1

	# Save chest as opened
	if chest_id != "" and chest_id not in GameState.defeatedEnemies:
		GameState.defeatedEnemies.append(chest_id)

	var ui = get_tree().get_root().get_node("DungeonScene/HUDLayer/HUDRoot/InventorySection")
	ui.show_potion_message()
	opening = false
	opened = true
	print("Chest opened: ", chest_id)

func _open_chest_animation() -> void:
	if chest_mid:
		chest_sprite.texture = chest_mid
		await get_tree().create_timer(0.2).timeout
	if chest_open:
		chest_sprite.texture = chest_open
