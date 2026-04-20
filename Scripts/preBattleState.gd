extends Node2D
@onready var player = $"../../CharacterBody2D"
@onready var enemyID = $id
var playerPosition : Vector2

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	playerPosition = player.position
	#GameState.playerPosition = playerPosition
	#GameState.defeatedEnemyID = enemyID.text
	




# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
