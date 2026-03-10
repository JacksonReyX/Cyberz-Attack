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
@onready var hair: Sprite2D = %Hair

# Tabs
@onready var hair_tab: TextureButton = %HairTab
@onready var body_tab: TextureButton = %BodyTab
@onready var eyes_tab: TextureButton = %EyesTab
@onready var outfit_tab: TextureButton = %OutfitTab
@onready var accessory_tab: TextureButton = %AccessoryTab

# Panels
@onready var hair_panel: Control = %HairPanel
@onready var body_panel: Control = %BodyPanel
@onready var eyes_panel: Control = %EyesPanel
@onready var outfit_panel: Control = %OutfitPanel
@onready var accessory_panel: Control = %AccessoryPanel

# Label for class name
@onready var class_label: Label = %ClassLabel

# Class arrows
@onready var class_left: TextureButton = %ClassLeft
@onready var class_right: TextureButton = %ClassRight

# Tab list (for forced exclusivity)
@onready var tabs: Array[BaseButton] = [hair_tab, body_tab, eyes_tab, outfit_tab, accessory_tab]

var classes := ["Knight", "Wizard"]
var class_index := 0

func _ready() -> void:
	UISfx.wire_buttons(self)

	# Class change buttons
	class_left.pressed.connect(func(): _change_class(-1))
	class_right.pressed.connect(func(): _change_class(1))

	# Force tabs to behave like a real tab bar
	for t in tabs:
		t.toggle_mode = true
		# Use pressed (not toggled) so we only react when user selects a tab
		t.pressed.connect(func(tab := t): _select_tab(tab))

	# Default selected tab
	_select_tab(hair_tab)

	# Load saved class
	class_index = classes.find(PlayerCustomization.selected_class)
	if class_index == -1:
		class_index = 0
	_apply_class()

func _select_tab(selected: BaseButton) -> void:
	# Make ONLY the selected tab pressed; others unpressed (returns them to dim normal)
	for t in tabs:
		t.button_pressed = (t == selected)

	_update_tab_panels()

func _update_tab_panels() -> void:
	hair_panel.visible = hair_tab.button_pressed
	body_panel.visible = body_tab.button_pressed
	eyes_panel.visible = eyes_tab.button_pressed
	outfit_panel.visible = outfit_tab.button_pressed
	accessory_panel.visible = accessory_tab.button_pressed

func _change_class(dir: int) -> void:
	class_index = wrapi(class_index + dir, 0, classes.size())
	_apply_class()

func _apply_class() -> void:
	var cname: String = classes[class_index]
	PlayerCustomization.selected_class = cname
	class_label.text = cname

	if cname == "Knight":
		body.texture = null
		eyes.texture = null
		hair.texture = null
		outfit.texture = KNIGHT_OUTFIT
		accessory.texture = KNIGHT_ACCESSORY
	else:
		body.texture = WIZARD_BODY
		eyes.texture = WIZARD_EYES
		hair.texture = null
		outfit.texture = WIZARD_OUTFIT
		accessory.texture = WIZARD_ACCESSORY

func _on_play_button_pressed() -> void:
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")

func _on_back_button_pressed() -> void:
	MusicManager.play_menu()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")
