extends Control

@onready var coin_label: Label = $CoinLabel

func _ready() -> void:
	_update_label()

func _process(_delta: float) -> void:
	coin_label.text = str(GameState.coins)

func _update_label() -> void:
	coin_label.text = str(GameState.coins)
