extends Control

@onready var key_message: Label = $FindLockDoorLabel

func show_key_message():
	key_message.visible = true
	await get_tree().create_timer(3.5).timeout
	key_message.visible = false
