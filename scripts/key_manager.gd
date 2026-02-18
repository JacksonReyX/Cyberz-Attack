extends Node

var collected_key = "find key"
@onready var key_label: Label = $KeyLabel

func key_found():
	collected_key = "found"
	key_label.text = "find key: " + str(collected_key)
