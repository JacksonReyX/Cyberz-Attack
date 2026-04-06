extends Control

@export_file("*.tscn") var character_customize_scene := "res://Scenes/KianStuff/CharacterCustomize.tscn"
@export_file("*.tscn") var info_scene := "res://Scenes/KianStuff/Info.tscn"
@export_file("*.tscn") var options_scene := "res://Scenes/KianStuff/Options.tscn"
@export_file("*.tscn") var item_shop_scene := "res://Scenes/sabella/ItemShop.tscn"

@onready var start_btn: TextureButton = $UILayer/Start
@onready var info_btn: TextureButton = $UILayer/Info
@onready var quit_btn: TextureButton = $UILayer/Quit
@onready var options_btn: TextureButton = $UILayer/Options
@onready var item_shop: Button = $UILayer/ItemShop


func _ready() -> void:
	UISfx.wire_buttons(self)
	MusicManager.play_menu()

	start_btn.pressed.connect(_on_start_pressed)
	info_btn.pressed.connect(_on_info_pressed)
	quit_btn.pressed.connect(_on_quit_pressed)
	options_btn.pressed.connect(_on_options_pressed)
	item_shop.pressed.connect(_on_item_shop_pressed)

func _on_start_pressed() -> void:
	get_tree().change_scene_to_file(character_customize_scene)

func _on_info_pressed() -> void:
	get_tree().change_scene_to_file(info_scene)

func _on_quit_pressed() -> void:
	get_tree().quit()
	
func _on_options_pressed() -> void:
	get_tree().change_scene_to_file(options_scene)

func _on_item_shop_pressed() -> void:
	get_tree().change_scene_to_file(item_shop_scene)

	
