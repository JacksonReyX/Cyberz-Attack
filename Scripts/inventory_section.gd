extends Control

# --- SLOT 1 (Potion) ---
@onready var potion_icon: TextureRect = $Slot1/ItemIcon
@onready var potion_label: Label = $Slot1/GreenHealthPotionLabel
@onready var pickup_label: Label = $"Slot1/25HPLabel"

# --- SLOT 2 (Key) ---
@onready var key_message: Label = $Slot2/FindLockedDoorLabel

# Separate flags for potion/key messages
var showing_potion_message := false
var showing_key_message := false

func _process(_delta):
	# Potion count
	var potions = GameState.health_potions
	if potions > 0:
		potion_icon.visible = true
		potion_label.visible = true
		potion_label.text = str(potions)
	else:
		potion_icon.visible = false
		potion_label.visible = false

# --- Show potion message ---
func show_potion_message():
	if showing_potion_message:
		return
	showing_potion_message = true
	pickup_label.text = "Healing Potion (+25 HP)"
	pickup_label.visible = true
	await get_tree().create_timer(3.0).timeout
	pickup_label.visible = false
	showing_potion_message = false

# --- Show key message ---
func show_key_message():
	if showing_key_message:
		return
	showing_key_message = true
	key_message.visible = true
	await get_tree().create_timer(3.5).timeout
	key_message.visible = false
	showing_key_message = false
