extends Node


var coins: int = 0
var health_potions: int = 0
var keys: int = 0
var playerPosition = Vector2.ZERO
var defeatedEnemies = []
var active_enemy_name : String = ""
var returning_from_battle = false


func setScene():
	playerPosition = Vector2.ZERO
	defeatedEnemies = []
	active_enemy_name = ""
	returning_from_battle = false

func add_coins(amount: int) -> void:
	coins += amount
	save_data()

##### item shop
var owned_skins: Array = ["default"]
var selected_skin: String = "default" # no longer used by customization, kept for save compatibility

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
	f.store_var({"coins": coins, "owned_skins": owned_skins, "selected_skin": selected_skin})
	print("SAVING:", coins)

# In GameState.gd
func load_data():
	if FileAccess.file_exists("user://save.dat"):
		var f = FileAccess.open("user://save.dat", FileAccess.READ)
		var data = f.get_var()
		# We ONLY load persistent things like coins and skins
		coins = data.get("coins", 0)
		owned_skins = data.get("owned_skins", ["default"])
		selected_skin = data.get("selected_skin", "default")
		# DO NOT load defeatedEnemies here. 
		# Keeping it out of this function ensures they respawn on a fresh launch.
	
func battleReset(): 
	if GameState.playerPosition != null:
		$CharacterBody2D.position = GameState.playerPosition
	if GameState.defeatedEnemyID != "":
		for enemy in get_tree().get_nodes_in_group("enemies"):
			if enemy.defeatedEnemyID == GameState.defeatedEnemyID:
				enemy.queue_free()
				break
		GameState.defeatedEnemyID = ""
#reset data
#func reset_data():
	#coins = 0
	#owned_skins = ["default"]
	#selected_skin = "default"
	#save_data()
