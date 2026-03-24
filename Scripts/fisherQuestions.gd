extends Control

@onready var DisplayText = $DisplayText
@onready var ListItem = $ItemList
@onready var RestartButton = $Button
@onready var health = $"../health"
@onready var deathTimer = $"../deathTimer"

var Items : Array = read_json_file("res://Assets/Questions/questions.json")
var item : Dictionary
var index_item : int = 0
var correctCount : float  = 0
var isCorrect : bool 
var healthPercent : int = 100
# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	refresh_scene()

	
func refresh_scene():
	if index_item >= Items.size():
		show_results()
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
		
		
func show_results():
	ListItem.hide()
	#RestartButton.show()
	var score = round(correctCount / item.size() * 100)
	var greet
	if score >= 60:
		greet = "Congraduations"
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
	


func _on_button_pressed() -> void:
	if isCorrect:
		correctCount += 1
		index_item += 1
	else:
		healthPercent -= 20
		if(healthPercent <= 0):
			DisplayText.text = "Game Over"
			deathTimer.start()
	refresh_scene()
		


func _on_death_timer_timeout() -> void:
	#get_tree().reload_current_scene()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
