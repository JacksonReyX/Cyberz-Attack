extends Node

var coins = 0
var owned_skins = ["default"]
var selected_skin = "default"

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

func load_data():
	if FileAccess.file_exists("user://save.dat"):
		var f = FileAccess.open("user://save.dat", FileAccess.READ)
		var data = f.get_var()
		coins = data.coins
		owned_skins = data.owned_skins
		selected_skin = data.selected_skin
