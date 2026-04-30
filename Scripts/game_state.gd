extends Node

var coins: int = 0
var health_potions: int = 0
var keys: int = 0
var playerPosition = Vector2.ZERO
var defeatedEnemies = []
var active_enemy_name: String = ""
var returning_from_battle = false

# Player health — separate from enemy health
var current_health: int = 12
var max_health: int = 12

func setScene():
	playerPosition = Vector2.ZERO
	defeatedEnemies = []
	active_enemy_name = ""
	returning_from_battle = false

func get_label():
	return get_node_or_null("/root/DungeonScene/HUDLayer/HUDRoot/CoinSection/CoinsForItemShopLabel")

func add_coins(amount: int) -> void:
	coins += amount
	if coins == 1:
		var label = get_label()
		if label:
			label.visible = true
			await get_tree().create_timer(3.0).timeout
			label.visible = false
		else:
			print("Label not found!")
	save_data()

var owned_skins: Array = ["default"]
var selected_skin: String = "default"

func buy_skin(skin_name: String, cost: int) -> bool:
	if coins >= cost:
		coins -= cost
		if skin_name not in owned_skins:
			owned_skins.append(skin_name)
		selected_skin = skin_name
		save_data()
		return true
	return false

func save_data():
	var f = FileAccess.open("user://save.dat", FileAccess.WRITE)
	f.store_var({
		"coins": coins,
		"owned_skins": owned_skins,
		"selected_skin": selected_skin,
		"current_health": current_health
	})
	print("SAVING:", coins)

func load_data():
	if not FileAccess.file_exists("user://save.dat"):
		return
	var f = FileAccess.open("user://save.dat", FileAccess.READ)
	if f == null:
		print("Failed to open save file")
		return
	if f.get_length() == 0:
		print("Save file empty")
		return
	var data = f.get_var()
	if typeof(data) != TYPE_DICTIONARY:
		print("Corrupted save file")
		return
	coins = data.get("coins", 0)
	owned_skins = data.get("owned_skins", ["default"])
	selected_skin = data.get("selected_skin", "default")
	current_health = data.get("current_health", max_health)

func reset_data():
	coins = 0
	owned_skins = ["default"]
	selected_skin = "default"
	returning_from_battle = false
	playerPosition = Vector2.ZERO
	defeatedEnemies = []
	active_enemy_name = ""
	current_health = max_health
	save_data()
	print("Progress reset!")
