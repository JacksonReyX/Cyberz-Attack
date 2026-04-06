extends Node2D

@onready var skin_1: Button = $SkinContainer/Skin1/Skin1Button
@onready var skin_2: Button = $SkinContainer/Skin2/Skin2Button
@onready var skin_3: Button = $SkinContainer/Skin3/Skin3Button
@onready var back_button: TextureButton = $BackButton/BackButton
@onready var coin_label: Label = $PlayerCoinCountLabel

func _ready() -> void:
	GameState.load_data()
	update_coin_display()
	_update_ui()
	#reset item shop
	#GameState.reset_data()

func _update_ui():
	if "skin1" in GameState.owned_skins:
		skin_1.text = "Owned"
		skin_1.disabled = true
	else:
		skin_1.disabled = GameState.coins < 100

	if "skin2" in GameState.owned_skins:
		skin_2.text = "Owned"
		skin_2.disabled = true
	else:
		skin_2.disabled = GameState.coins < 100

	if "skin3" in GameState.owned_skins:
		skin_3.text = "Owned"
		skin_3.disabled = true
	else:
		skin_3.disabled = GameState.coins < 100

func update_coin_display():
	coin_label.text = str(GameState.coins)

func _process(_delta: float) -> void:
	pass

func _on_back_button_pressed():
	get_tree().change_scene_to_file("res://Scenes/KianStuff/MainMenu.tscn")

func _on_skin_1_button_pressed() -> void:
	if GameState.buy_skin("skin1", 100):
		print("Skin1 bought!")
		update_coin_display()
		_update_ui()
	else:
		print("Not enough coins")

func _on_skin_2_button_pressed() -> void:
	if GameState.buy_skin("skin2", 100):
		print("Skin2 bought!")
		update_coin_display()
		_update_ui()
	else:
		print("Not enough coins")

func _on_skin_3_button_pressed() -> void:
	if GameState.buy_skin("skin3", 100):
		print("Skin3 bought!")
		update_coin_display()
		_update_ui()
	else:
		print("Not enough coins")
