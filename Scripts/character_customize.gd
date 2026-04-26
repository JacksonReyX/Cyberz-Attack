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

# Tab list
@onready var tabs: Array[BaseButton] = [hair_tab, body_tab, eyes_tab, outfit_tab, accessory_tab]

var classes := ["Knight", "Wizard", "Knight 2", "Archer", "Mage"]
var class_index := 0
var is_shop_skin := false############

func _ready() -> void:
	GameState.load_data()
	UISfx.wire_buttons(self)
	class_left.pressed.connect(func(): _change_class(-1))
	class_right.pressed.connect(func(): _change_class(1))

	for t in tabs:
		t.toggle_mode = true
		t.pressed.connect(func(tab := t): _select_tab(tab))

	_select_tab(hair_tab)

	class_index = classes.find(PlayerCustomization.selected_class)
	if class_index == -1:
		class_index = 0

	if not _is_class_unlocked(classes[class_index]):
		class_index = 0

	_apply_class()
	_connect_swatches()


func _connect_swatches() -> void:
	_wire_swatch_panel(hair_panel, "hair")
	_wire_swatch_panel(outfit_panel, "outfit")
	_wire_swatch_panel(accessory_panel, "accessory")
	_wire_swatch_panel(body_panel, "body")
	_wire_swatch_panel(eyes_panel, "eyes")

	for swatch in hair_panel.get_children():
		if not swatch is TextureButton:
			continue
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func(): _pick_color("hair", color))
	for swatch in outfit_panel.get_children():
		if not swatch is TextureButton:
			continue
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func(): _pick_color("outfit", color))
	for swatch in accessory_panel.get_children():
		if not swatch is TextureButton:
			continue
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func(): _pick_color("accessory", color))
	for swatch in body_panel.get_children():
		if not swatch is TextureButton:
			continue
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func(): _pick_color("body", color))
	for swatch in eyes_panel.get_children():
		if not swatch is TextureButton:
			continue
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func(): _pick_color("eyes", color))

func _wire_swatch_panel(panel: Control, layer: String) -> void:
	for swatch in panel.get_children():
		if not swatch is TextureButton:
			continue
		swatch.toggle_mode = true
		var color = swatch.get_node("ColorRect").color
		swatch.pressed.connect(func():
			for s in panel.get_children():
				if s is TextureButton:
					s.button_pressed = false
			swatch.button_pressed = true
			_pick_color(layer, color)
		)

func _pick_color(layer: String, color: Color) -> void:
	if is_shop_skin:##############
		return ############
	
	match layer:
		"outfit":
			PlayerCustomization.color_outfit = color
			outfit.modulate = color
		"accessory":
			PlayerCustomization.color_accessory = color
			accessory.modulate = color
		"body":
			PlayerCustomization.color_body = color
			body.modulate = color
		"eyes":
			PlayerCustomization.color_eyes = color
			eyes.modulate = color
		"hair":
			PlayerCustomization.color_hair = color
			hair.modulate = color

func _select_tab(selected: BaseButton) -> void:
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
	var attempts := 0
	var next := class_index
	while attempts < classes.size():
		next = wrapi(next + dir, 0, classes.size())
		if _is_class_unlocked(classes[next]):
			class_index = next
			break
		attempts += 1
	_apply_class()

func _is_class_unlocked(cname: String) -> bool:
	match cname:
		"Knight", "Wizard":
			return true
		"Knight 2":
			return "skin2" in GameState.owned_skins
		"Archer":
			return "skin1" in GameState.owned_skins
		"Mage":
			return "skin3" in GameState.owned_skins
	return false

func _apply_class() -> void:
	var cname: String = classes[class_index]
	is_shop_skin = cname in ["Knight 2", "Archer", "Mage"] ########
	PlayerCustomization.selected_class = cname
	class_label.text = cname

	match cname:
		"Knight":
			body.texture = null
			eyes.texture = null
			hair.texture = null
			outfit.texture = KNIGHT_OUTFIT
			accessory.texture = KNIGHT_ACCESSORY
		"Wizard":
			body.texture = WIZARD_BODY
			eyes.texture = WIZARD_EYES
			hair.texture = null
			outfit.texture = WIZARD_OUTFIT
			accessory.texture = WIZARD_ACCESSORY
		"Knight 2":
			body.texture = null
			eyes.texture = null
			hair.texture = null
			outfit.texture = preload("res://Scenes/sabella/shopSkins/Knight2image.png")
			accessory.texture = null
		"Archer":
			body.texture = null
			eyes.texture = null
			hair.texture = null
			outfit.texture = preload("res://Scenes/sabella/shopSkins/ArcherImage.png")
			accessory.texture = null
		"Mage":
			body.texture = null
			eyes.texture = null
			hair.texture = null
			outfit.texture = preload("res://Scenes/sabella/shopSkins/MageImage.png")
			accessory.texture = null
	if is_shop_skin:##################
		body.modulate = Color(1, 1, 1, 1)
		outfit.modulate = Color(1, 1, 1, 1)
		eyes.modulate = Color(1, 1, 1, 1)
		accessory.modulate = Color(1, 1, 1, 1)
		hair.modulate = Color(1, 1, 1, 1)##########

func _apply_selected_skin() -> void:
	pass

func _on_play_button_pressed() -> void:
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")

func _on_back_button_pressed() -> void:
	MusicManager.play_menu()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")
