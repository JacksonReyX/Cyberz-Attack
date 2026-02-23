extends CharacterBody2D

@export var speed: float = 95.0
var door_lock := false

# Textures
const KNIGHT_OUTFIT := preload("res://Assets/Characters/Knight/KnightOutfit.png")
const KNIGHT_ACCESSORY := preload("res://Assets/Characters/Knight/KnightAccessory.png")

const WIZARD_BODY := preload("res://Assets/Characters/Wizard/WizardBody.png")
const WIZARD_OUTFIT := preload("res://Assets/Characters/Wizard/WizardOutfit.png")
const WIZARD_EYES := preload("res://Assets/Characters/Wizard/WizardEyes.png")
const WIZARD_ACCESSORY := preload("res://Assets/Characters/Wizard/WizardAccessory.png")

# Visual layers
@onready var visuals: Node2D = $Visuals
@onready var body: Sprite2D = %Body
@onready var outfit: Sprite2D = %Outfit
@onready var eyes: Sprite2D = %Eyes
@onready var accessory: Sprite2D = %Accessory
@onready var hair: Sprite2D = %Hair

func _ready() -> void:
	apply_customization()

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

	# Face left/right by flipping the whole visuals
	if input_vec.x != 0:
		visuals.scale.x = -abs(visuals.scale.x) if input_vec.x < 0 else abs(visuals.scale.x)

func apply_customization() -> void:
	var cname: String = PlayerCustomization.selected_class

	if cname == "Wizard":
		body.texture = WIZARD_BODY
		eyes.texture = WIZARD_EYES
		outfit.texture = WIZARD_OUTFIT
		accessory.texture = WIZARD_ACCESSORY
	else:
		# Knight: no body/eyes
		body.texture = null
		eyes.texture = null
		outfit.texture = KNIGHT_OUTFIT
		accessory.texture = KNIGHT_ACCESSORY

	# Optional: hair layer not used yet
	hair.texture = null
