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




var Items : Array = read_json_file("res://Assets/Questions/witchQuestions.json")
var item : Dictionary
var index_item : int 
var used_indices : Array = [] # Tracks questions already asked
var correctCount : float = 0
var isCorrect : Variant = null
var healthPercent : int = 100
var enemyHealth : int = 100
var score : int = 0

func _ready() -> void:
	pick_new_question() # Initial pick
	refresh_scene()

func pick_new_question():
	# If we ran out of questions, clear the list or handle endgame
	if used_indices.size() >= Items.size():
		used_indices.clear() # Optional: Reset if you want to loop
	
	var new_index = randi() % Items.size()
	while used_indices.has(new_index):
		new_index = randi() % Items.size()
	
	index_item = new_index
	used_indices.append(index_item)

func refresh_scene():
	health.text = str(healthPercent) + "%"
	enemyHealthBar.text = str(enemyHealth) + "%"
	
	if enemyHealth <= 0:
		enemyHealthBar.text = "0%" 
		ListItem.hide()
		RestartButton.disabled = true
		var greet = "Congratulations, You Win!"
		DisplayText.text = greet
		winTimer.start()
	elif healthPercent <= 0:
		RestartButton.disabled = true
		health.text = "0%"
		DisplayText.text = "Game Over"
		deathTimer.start()
	else:
		show_questions()
		
func show_questions():
	ListItem.show()
	
	if ListItem.item_count == 0 or DisplayText.text != Items[index_item].question:
		ListItem.clear()
		item = Items[index_item]
		DisplayText.text = item.question
		for option in item.options:
			ListItem.add_item(option)
	
func read_json_file(path):
	if not FileAccess.file_exists(path): return []
	var file = FileAccess.open(path, FileAccess.READ)
	var json_content = JSON.parse_string(file.get_as_text())
	return json_content

func _on_item_list_item_selected(index: int) -> void:
	if index == item.correctIndex:
		isCorrect = true
	else:
		isCorrect = false
	buttonFX.play()

func _on_button_pressed() -> void:
	if isCorrect == null: return

	if isCorrect:
		correctCount += 1
		enemyHealth -= 30
		score += 10
		correctSFX.play()
		rightAnswer.visible = true
		rightTimer.start()
		
		ListItem.clear()
		pick_new_question()
	else:
		var selected_indices = ListItem.get_selected_items()
		if selected_indices.size() > 0:
			var idx = selected_indices[0]
			ListItem.set_item_disabled(idx, true)
			ListItem.set_item_custom_fg_color(idx, Color(0.5, 0.2, 0.2, 1.0)) # Dark Red
		
		incorrectSFX.play()
		healthPercent -= 20
		wrongAnswer.visible = true
		wrongTimer.start()
		if score > 5: score -= 5
		
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
