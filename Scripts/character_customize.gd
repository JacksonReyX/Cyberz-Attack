extends Control

# Knight
const KNIGHT_OUTFIT := preload("res://Assets/Characters/Knight/KnightOutfit.png")
const KNIGHT_ACCESSORY := preload("res://Assets/Characters/Knight/KnightAccessory.png")

# Wizard
const WIZARD_BODY := preload("res://Assets/Characters/Wizard/WizardBody.png")
const WIZARD_OUTFIT := preload("res://Assets/Characters/Wizard/WizardOutfit.png")
const WIZARD_EYES := preload("res://Assets/Characters/Wizard/WizardEyes.png")
const WIZARD_ACCESSORY := preload("res://Assets/Characters/Wizard/WizardAccessory.png")

@onready var body: Sprite2D = %Body
@onready var outfit: Sprite2D = %Outfit
@onready var eyes: Sprite2D = %Eyes
@onready var accessory: Sprite2D = %Accessory

# Optional label (if you have it)
@onready var class_label: Label = get_node_or_null("%ClassLabel")

# Your UI buttons (Unique Name in Owner recommended, or use paths)
@onready var class_left: TextureButton = %ClassLeft
@onready var class_right: TextureButton = %ClassRight

var classes := ["Knight", "Wizard"]
var class_index := 0

func _ready() -> void:
	# Hook up buttons (do this OR use editor signals, not both)
	class_left.pressed.connect(func(): _change_class(-1))
	class_right.pressed.connect(func(): _change_class(1))

	# Load saved choice from autoload
	class_index = classes.find(PlayerCustomization.selected_class)
	if class_index == -1:
		class_index = 0

	_apply_class()

func _change_class(dir: int) -> void:
	class_index = wrapi(class_index + dir, 0, classes.size())
	_apply_class()

func _apply_class() -> void:
	var cname: String = classes[class_index]
	PlayerCustomization.selected_class = cname

	if class_label:
		class_label.text = cname

	if cname == "Knight":
		# Knight uses only outfit + accessory
		body.texture = null
		eyes.texture = null
		outfit.texture = KNIGHT_OUTFIT
		accessory.texture = KNIGHT_ACCESSORY
	else:
		# Wizard uses all four
		body.texture = WIZARD_BODY
		eyes.texture = WIZARD_EYES
		outfit.texture = WIZARD_OUTFIT
		accessory.texture = WIZARD_ACCESSORY

func _on_play_button_pressed() -> void:
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")

func _on_back_button_pressed() -> void:
	MusicManager.play_menu()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")
