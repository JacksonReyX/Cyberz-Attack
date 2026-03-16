extends Control
@onready var potion_icon: TextureRect = $GreenHealthPotion
@onready var potion_label: Label = $GreenHealthPotionLabel

func _process(_delta):

	var potions = GameState.health_potions

	if potions > 0:
		potion_icon.visible = true
		potion_label.visible = true
		potion_label.text = str(potions)
	else:
		potion_icon.visible = false
		potion_label.visible = false
