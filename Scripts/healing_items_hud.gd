extends Control
@onready var potion_icon: TextureRect = $GreenHealthPotion
@onready var potion_label: Label = $GreenHealthPotionLabel
@onready var pickup_label: Label = $"25HPLabel"

var showing_message := false  

func _process(_delta):

	var potions = GameState.health_potions

	if potions > 0:
		potion_icon.visible = true
		potion_label.visible = true
		potion_label.text = str(potions)
	else:
		potion_icon.visible = false
		potion_label.visible = false

func show_potion_message():
	print("SHOW MESSAGE CALLED") 
	if showing_message:
		return
	
	showing_message = true
	pickup_label.text = "Healing Potion (+25 HP)"
	pickup_label.visible = true
	
	await get_tree().create_timer(3.0).timeout
	
	pickup_label.visible = false
	showing_message = false
