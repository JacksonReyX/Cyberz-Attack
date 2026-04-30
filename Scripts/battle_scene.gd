extends Node2D

@onready var enemy_sprite = $EnemySection/EnemySprite
@onready var enemy_name_label: Label = $EnemySection/EnemyNameLabel
@onready var question_label: Label = $QuestionSection/QuestionBox/QuestionLabel
@onready var feedback_label: Label = $QuestionSection/FeedbackBox/FeedbackLabel
@onready var feedback_box: TextureRect = $QuestionSection/FeedbackBox
@onready var answer_buttons: Array = [
	$QuestionSection/Answer1,
	$QuestionSection/Answer2,
	$QuestionSection/Answer3,
	$QuestionSection/Answer4
]
@onready var health_hud = $PlayerSection/HealthHud
@onready var enemy_health_bar = $EnemyHealthBar

var enemy_data: Dictionary = {}
var current_question: Dictionary = {}
var used_questions: Array = []
var enemy_current_health: int = 12
var damage_per_correct: int = 4
var answer_selected: bool = false

func _ready() -> void:
	MusicManager.play_combat()
	UISfx.wire_buttons(self)

	# Mark enemy bar so it doesn't overwrite player health in GameState
	enemy_health_bar.is_enemy_bar = true
	enemy_health_bar.modulate = Color(0.7, 0.3, 1.0)

	feedback_box.visible = false

	# Load enemy data FIRST before anything else
	var enemy_key = _get_enemy_key()
	if EnemyData.enemies.has(enemy_key):
		enemy_data = EnemyData.enemies[enemy_key]
	else:
		enemy_data = EnemyData.enemies.values()[0]

	# Debug prints AFTER loading enemy data
	print("active enemy: ", GameState.active_enemy_name)
	print("enemy key: ", enemy_key)
	print("animation path: ", enemy_data.get("animation_frames", "NO PATH"))

	enemy_current_health = enemy_data.health
	damage_per_correct = enemy_data.get("damage_per_correct", 4)
	enemy_name_label.text = enemy_data.display_name

	# Initialize enemy health bar
	enemy_health_bar.max_health = enemy_data.health
	enemy_health_bar.current_health = enemy_data.health
	for i in range(enemy_health_bar.segments.size()):
		if enemy_health_bar.segments[i]:
			enemy_health_bar.segments[i].position = enemy_health_bar.segments[i].original_position
			if i < enemy_data.health:
				enemy_health_bar.segments[i].set_full()
			else:
				enemy_health_bar.segments[i].set_empty()

	# Load enemy animation AFTER enemy_data is populated
	if enemy_data.has("animation_frames"):
		var frames = load(enemy_data.animation_frames)
		print("frames loaded: ", frames)
		if frames:
			enemy_sprite.sprite_frames = frames
			enemy_sprite.play("idle")
		else:
			print("WARNING: Could not load frames from: ", enemy_data.animation_frames)

	# Wire answer buttons
	for i in range(answer_buttons.size()):
		var btn = answer_buttons[i]
		var idx = i
		btn.pressed.connect(func(): _on_answer_selected(idx))

	_load_question()

func _get_enemy_key() -> String:
	var ename = GameState.active_enemy_name
	if "Fisher" in ename:
		return "Phisher"
	elif "Hacker" in ename:
		return "Hacker"
	elif "Malware" in ename:
		return "Malware"
	elif "Scammer" in ename:
		return "Scammer"
	elif "Virus" in ename:
		return "Virus"
	elif "Spyware" in ename:
		return "Spyware"
	elif "Troller" in ename:
		return "Troller"
	elif "DataThief" in ename:
		return "DataThief"
	elif "Ransomware" in ename:
		return "Ransomware"
	return "Phisher"

func _load_question() -> void:
	for btn in answer_buttons:
		btn.disabled = false
		btn.modulate = Color.WHITE

	feedback_box.visible = false

	if used_questions.size() >= enemy_data.questions.size():
		used_questions.clear()

	var available = []
	for i in range(enemy_data.questions.size()):
		if i not in used_questions:
			available.append(i)

	var idx = available[randi() % available.size()]
	used_questions.append(idx)
	current_question = enemy_data.questions[idx]

	question_label.text = current_question.question

	for i in range(answer_buttons.size()):
		if i < current_question.options.size():
			answer_buttons[i].visible = true
			answer_buttons[i].get_node("Label").text = current_question.options[i]
			answer_buttons[i].disabled = false
			answer_buttons[i].modulate = Color.WHITE
		else:
			answer_buttons[i].visible = false

	answer_selected = false

func _on_answer_selected(index: int) -> void:
	if answer_selected:
		return
	if index == current_question.correct:
		await _correct_answer()
	else:
		await _wrong_answer(index)

func _correct_answer() -> void:
	answer_selected = true
	enemy_current_health -= damage_per_correct
	enemy_current_health = max(enemy_current_health, 0)

	for btn in answer_buttons:
		btn.disabled = true

	feedback_label.text = "Correct!"
	feedback_label.modulate = Color.GREEN
	feedback_box.visible = true

	await enemy_health_bar.set_health(enemy_current_health)

	await get_tree().create_timer(1.5).timeout
	feedback_box.visible = false

	if enemy_current_health <= 0:
		await _win()
	else:
		_load_question()

func _wrong_answer(index: int) -> void:
	answer_buttons[index].disabled = true
	answer_buttons[index].modulate = Color(0.4, 0.4, 0.4, 1.0)

	feedback_label.text = "Wrong!"
	feedback_label.modulate = Color.RED
	feedback_box.visible = true

	await health_hud.damage(1)

	await get_tree().create_timer(1.0).timeout
	feedback_box.visible = false

	if GameState.current_health <= 0:
		await _lose()

func _win() -> void:
	for btn in answer_buttons:
		btn.disabled = true

	feedback_label.text = "You won!"
	feedback_label.modulate = Color.YELLOW
	feedback_box.visible = true

	GameState.defeatedEnemies.append(GameState.active_enemy_name)
	GameState.add_coins(10)

	await get_tree().create_timer(2.0).timeout
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")

func _lose() -> void:
	for btn in answer_buttons:
		btn.disabled = true

	feedback_label.text = "You lost!"
	feedback_label.modulate = Color.RED
	feedback_box.visible = true

	await get_tree().create_timer(2.0).timeout
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
