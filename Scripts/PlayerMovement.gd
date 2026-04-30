extends CharacterBody2D

@export var speed: float = 65.0
var door_lock := false
var movement_locked := false

const KNIGHT_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/KnightOutfitFrames.tres")
const KNIGHT_ACCESSORY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/KnightAccessoryFrames.tres")
const WIZARD_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardOutfitFrames.tres")
const WIZARD_BODY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardBodyFrames.tres")
const WIZARD_EYES_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardEyesFrames.tres")
const WIZARD_ACCESSORY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardAccessoryFrames.tres")
const DEMON_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/MonsterOutfitFrames.tres")
const DEMON_BODY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/MonsterBodyFrames.tres")
const DEMON_EYES_FRAMES := preload("res://Assets/Characters/CharactersAnimations/MonsterEyesFrames.tres")
const DEMON_ACCESSORY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/MonsterAccessoryFrames.tres")
const HUMAN_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/HumanOutfitFrames.tres")
const HUMAN_BODY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/HumanBodyFrames.tres")
const HUMAN_EYES_FRAMES := preload("res://Assets/Characters/CharactersAnimations/HumanEyesFrames.tres")
const HUMAN_HAIR_FRAMES := preload("res://Assets/Characters/CharactersAnimations/HumanHairFrames.tres")

@onready var visuals: Node2D = $Visuals
@onready var body: AnimatedSprite2D = %Body
@onready var outfit: AnimatedSprite2D = %Outfit
@onready var eyes: AnimatedSprite2D = %Eyes
@onready var accessory: AnimatedSprite2D = %Accessory
@onready var hair: AnimatedSprite2D = %Hair

var active_layers: Array[AnimatedSprite2D] = []

func _ready() -> void:
	await get_tree().process_frame
	apply_customization()
	await get_tree().process_frame
	play_all("idle", true)

func _physics_process(_delta: float) -> void:
	if movement_locked:
		velocity = Vector2.ZERO
		move_and_slide()
		return

	var input_vec := Vector2.ZERO
	if Input.is_action_pressed("move_right"):
		input_vec.x += 1
	if Input.is_action_pressed("move_left"):
		input_vec.x -= 1
	if Input.is_action_pressed("move_down"):
		input_vec.y += 1
	if Input.is_action_pressed("move_up"):
		input_vec.y -= 1
	input_vec = input_vec.normalized()
	velocity = input_vec * speed
	move_and_slide()

	if input_vec.x != 0:
		visuals.scale.x = -abs(visuals.scale.x) if input_vec.x < 0 else abs(visuals.scale.x)

	var anim := "run" if input_vec.length() > 0 else "idle"
	play_all(anim)

func apply_customization() -> void:
	var cname: String = PlayerCustomization.selected_class

	body.visible = false
	eyes.visible = false
	hair.visible = false
	accessory.visible = false
	outfit.visible = false
	active_layers.clear()

	match cname:
		"Knight":
			outfit.sprite_frames = KNIGHT_OUTFIT_FRAMES
			accessory.sprite_frames = KNIGHT_ACCESSORY_FRAMES
			outfit.visible = true
			accessory.visible = true
			active_layers = [outfit, accessory]
		"Wizard":
			outfit.sprite_frames = WIZARD_OUTFIT_FRAMES
			body.sprite_frames = WIZARD_BODY_FRAMES
			eyes.sprite_frames = WIZARD_EYES_FRAMES
			accessory.sprite_frames = WIZARD_ACCESSORY_FRAMES
			outfit.visible = true
			body.visible = true
			eyes.visible = true
			accessory.visible = true
			active_layers = [outfit, body, eyes, accessory]
		"Demon":
			outfit.sprite_frames = DEMON_OUTFIT_FRAMES
			body.sprite_frames = DEMON_BODY_FRAMES
			eyes.sprite_frames = DEMON_EYES_FRAMES
			accessory.sprite_frames = DEMON_ACCESSORY_FRAMES
			outfit.visible = true
			body.visible = true
			eyes.visible = true
			accessory.visible = true
			active_layers = [outfit, body, eyes, accessory]
		"Human":
			outfit.sprite_frames = HUMAN_OUTFIT_FRAMES
			body.sprite_frames = HUMAN_BODY_FRAMES
			eyes.sprite_frames = HUMAN_EYES_FRAMES
			hair.sprite_frames = HUMAN_HAIR_FRAMES
			outfit.visible = true
			body.visible = true
			eyes.visible = true
			hair.visible = true
			active_layers = [outfit, body, eyes, hair]

	play_all("idle")

	outfit.modulate = PlayerCustomization.color_outfit
	accessory.modulate = PlayerCustomization.color_accessory
	body.modulate = PlayerCustomization.color_body
	eyes.modulate = PlayerCustomization.color_eyes
	hair.modulate = PlayerCustomization.color_hair

func play_all(anim: String, force: bool = false) -> void:
	for layer in active_layers:
		if layer.sprite_frames and layer.sprite_frames.has_animation(anim):
			if force or layer.animation != anim:
				layer.play(anim)

func _unhandled_input(event: InputEvent) -> void:
	if event is InputEventKey and event.pressed and not event.echo:
		if event.keycode == KEY_1:
			await _use_potion()

func _use_potion() -> void:
	if GameState.health_potions <= 0:
		return
	if GameState.current_health >= GameState.max_health:
		return

	var heal_amount := 3
	GameState.health_potions -= 1
	GameState.current_health = min(GameState.current_health + heal_amount, GameState.max_health)

	var hud = get_tree().get_root().get_node_or_null("DungeonScene/HUDLayer/HUDRoot/TopLeftPanel/HealthHud")
	if hud:
		await hud.heal(heal_amount)
	else:
		print("HealthHUD not found — check path")
