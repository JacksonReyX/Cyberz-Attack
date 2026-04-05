extends Node2D

@onready var skin_1: Node = $SkinContainer/Skin1
@onready var skin_2: Node = $SkinContainer/Skin2
@onready var skin_3: Node = $SkinContainer/Skin3
@onready var back_button: TextureButton = $BackButton/BackButton


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _on_back_button_pressed():
	print("clicked")
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")


func _on_skin_1_button_pressed() -> void:
	if GameData.buy_skin("skin1", 100):
		print("Skin1 bought!")
	else:
		print("Not enough coins")


func _on_skin_2_button_pressed() -> void:
	if GameData.buy_skin("skin2", 100):
		print("Skin2 bought!")
	else:
		print("Not enough coins")
		
		
func _on_skin_3_button_pressed() -> void:
	if GameData.buy_skin("skin3", 100):
		print("Skin3 bought!")
	else:
		print("Not enough coins")
