extends Control

@onready var DisplayText = $DisplayText
@onready var ListItem = $ItemList
@onready var RestartButton = $Button
@onready var health = $"../health"
@onready var enemyHealthBar = $"../enemyHealth"
@onready var deathTimer = $"../deathTimer"
@onready var winTimer = $"../winTimer"
@onready var buttonFX = $"../buttonFX"
@onready var correctSFX = $"../correctSFX"
@onready var incorrectSFX = $"../incorrectSFX"
@onready var rightAnswer = $"../correctAnswer"
@onready var wrongAnswer = $"../wrongAnswer"
@onready var rightTimer = $"../rightTimer"
@onready var wrongTimer = $"../wrongTimer"


var Items : Array = read_json_file("res://Assets/Questions/virusQuestions.json")
var item : Dictionary
var index_item : int = randi_range(0,1)
var correctCount : float  = 0
var isCorrect : Variant = null 
var healthPercent : int = 100
var enemyHealth : int = 100
var score : int = 0
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_scene()

	
func refresh_scene():
	var greet
	if enemyHealth <= 0:
		ListItem.hide()
		greet = "Congraduations, You Win!"
		DisplayText.text = "{greet} ! Your Score is {score}".format({"greet": greet, "score": score})
		winTimer.start()
	else:
		show_questions()
		
func show_questions():
	ListItem.show()
	#RestartButton.hide()
	ListItem.clear()
	item = Items[index_item]
	if(healthPercent > 0):
		DisplayText.text = item.question
	var options = item.options
	for option in options:
		ListItem.add_item(option)
	health.text = str(healthPercent) + "%"
	enemyHealthBar.text = str(enemyHealth) + "%"

		
		
func show_results():
	ListItem.hide()
	#RestartButton.show()
	var score = round(correctCount / item.size() * 100)
	var greet
	if enemyHealth <= 0:
		greet = "Congraduations, You Win!"
		#winTimer.start()
	else:
		greet = "Oh no"
	DisplayText.text = "{greet} ! Your Score is {score}".format({"greet": greet, "score": score})
	
	
func read_json_file(path):
	var file = FileAccess.open(path, FileAccess.READ)
	var text = file.get_as_text()
	var json_content = JSON.parse_string(text)
	file.close()
	print(json_content)
	return json_content


func _on_item_list_item_selected(index: int) -> void:
	if index == item.correctIndex:
		isCorrect = true
	else:
		isCorrect = false
	buttonFX.play()
	


func _on_button_pressed() -> void:
	if isCorrect:
		correctCount += 1
		enemyHealth -= 60
		index_item = randi_range(0,1)
		score += 10
		correctSFX.play()
		rightAnswer.visible = true
		rightTimer.start()
	else:
		incorrectSFX.play()
		index_item = randi_range(0,1)
		healthPercent -= 20
		wrongAnswer.visible = true
		wrongTimer.start()
		if(score > 5):
			score -= 5
		if(healthPercent <= 0):
			DisplayText.text = "Game Over"
			deathTimer.start()
	isCorrect = null 
	ListItem.deselect_all()
	refresh_scene()
		


func _on_death_timer_timeout() -> void:
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
	#OS.get_executable_path()
	#get_tree().quit()
	


func _on_win_timer_timeout() -> void:
	#GameState.battleReset()
	GameState.defeatedEnemies.append(GameState.active_enemy_name)
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")


func _on_wrong_timer_timeout() -> void:
	wrongAnswer.visible = false


func _on_right_timer_timeout() -> void:
	rightAnswer.visible = false
