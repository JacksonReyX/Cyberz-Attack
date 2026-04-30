extends Node2D

@onready var enemy_sprite: AnimatedSprite2D = $EnemySection/EnemySprite
@onready var enemy_name_label: Label = $EnemySection/EnemyNameLabel
@onready var question_label: Label = $QuestionSection/QuestionBox/QuestionLabel
@onready var feedback_label: Label = $QuestionSection/FeedbackBox/Label
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
var enemy_current_health: int = 3
var answer_selected: bool = false

func _ready() -> void:
	MusicManager.play_combat()
	UISfx.wire_buttons(self)

	# Tint enemy health bar purple
	enemy_health_bar.modulate = Color(0.7, 0.3, 1.0)

	# Hide feedback box initially
	feedback_box.visible = false

	# Load enemy data
	var enemy_key = _get_enemy_key()
	if EnemyData.enemies.has(enemy_key):
		enemy_data = EnemyData.enemies[enemy_key]
	else:
		enemy_data = EnemyData.enemies.values()[0]

	enemy_current_health = enemy_data.health
	enemy_name_label.text = enemy_data.display_name

	# Load enemy animation
	if enemy_data.has("animation_frames"):
		var frames = load(enemy_data.animation_frames)
		if frames:
			enemy_sprite.sprite_frames = frames
			enemy_sprite.play("idle")

	# Wire answer buttons
	for i in range(answer_buttons.size()):
		var btn = answer_buttons[i]
		var idx = i
		btn.pressed.connect(func(): _on_answer_selected(idx))

	_load_question()

func _get_enemy_key() -> String:
	var name = GameState.active_enemy_name
	if "isher" in name or "ish" in name:
		return "Phisher"
	elif "ack" in name or "acker" in name:
		return "Hacker"
	elif "alware" in name or "irus" in name:
		return "Malware"
	elif "cam" in name or "cammer" in name:
		return "Scammer"
	return "Phisher"

func _load_question() -> void:
	# Reset all buttons
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
	enemy_current_health -= 1

	# Disable all buttons
	for btn in answer_buttons:
		btn.disabled = true

	# Show correct feedback
	feedback_label.text = "Correct!"
	feedback_label.modulate = Color.GREEN
	feedback_box.visible = true

	await get_tree().create_timer(1.5).timeout
	feedback_box.visible = false

	if enemy_current_health <= 0:
		await _win()
	else:
		_load_question()

func _wrong_answer(index: int) -> void:
	# Grey out just the wrong button
	answer_buttons[index].disabled = true
	answer_buttons[index].modulate = Color(0.4, 0.4, 0.4, 1.0)

	# Show wrong feedback
	feedback_label.text = "Wrong! Try again!"
	feedback_label.modulate = Color.RED
	feedback_box.visible = true

	# Damage player health
	await health_hud.damage(1)
	GameState.current_health = health_hud.current_health

	await get_tree().create_timer(1.0).timeout
	feedback_box.visible = false

	# Check if player dead
	if GameState.current_health <= 0:
		await _lose()

func _win() -> void:
	for btn in answer_buttons:
		btn.disabled = true

	feedback_label.text = "You defeated the " + enemy_data.display_name + "!"
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

	feedback_label.text = "You were defeated!"
	feedback_label.modulate = Color.RED
	feedback_box.visible = true

	await get_tree().create_timer(2.0).timeout
	MusicManager.play_dungeon()
	get_tree().change_scene_to_file("res://Scenes/KianStuff/DungeonScene.tscn")
