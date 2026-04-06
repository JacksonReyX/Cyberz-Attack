extends Node

#FOR COINS
var score = 0
@onready var coin_label: Label = $"../CanvasLayer/Control/HBoxContainer/CoinLabel"


func add_point():
	score += 1
	coin_label.text = str(score)
