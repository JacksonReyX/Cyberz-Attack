extends CharacterBody2D

@export var speed: float = 65.0
var door_lock := false

const KNIGHT_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/KnightOutfitFrames.tres")
const KNIGHT_ACCESSORY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/KnightAccessoryFrames.tres")
const WIZARD_OUTFIT_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardOutfitFrames.tres")
const WIZARD_BODY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardBodyFrames.tres")
const WIZARD_EYES_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardEyesFrames.tres")
const WIZARD_ACCESSORY_FRAMES := preload("res://Assets/Characters/CharactersAnimations/WizardAccessoryFrames.tres")

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
	print("apply_customization called with class: ", cname)
	print("outfit node: ", outfit)
	print("outfit frames: ", outfit.sprite_frames if outfit else "NULL NODE")

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
