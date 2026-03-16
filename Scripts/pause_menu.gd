extends Control

@export_file("*.tscn") var main_menu_scene := "res://Scenes/KianStuff/MainMenu.tscn"

@onready var main_buttons: Control = %MainButtons
@onready var volume_panel: Control = %VolumePanel

@onready var resume_button: TextureButton = %ResumeButton
@onready var volume_button: TextureButton = %VolumeButton
@onready var main_menu_button: TextureButton = %MainMenuButton
@onready var quit_button: TextureButton = %QuitButton
@onready var back_button: TextureButton = %BackButton

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISFXSlider

@onready var master_value_label: Label = %MasterValueLabel
@onready var music_value_label: Label = %MusicValueLabel
@onready var sfx_value_label: Label = %SFXValueLabel
@onready var ui_value_label: Label = %UISFXValueLabel

var _last_tick_time := 0.0
const TICK_COOLDOWN := 0.03

func _ready() -> void:
	UISfx.wire_buttons(self)

	main_buttons.visible = true
	volume_panel.visible = false

	# Main pause buttons
	resume_button.pressed.connect(_on_resume_button_pressed)
	volume_button.pressed.connect(_on_volume_button_pressed)
	main_menu_button.pressed.connect(_on_main_menu_button_pressed)
	quit_button.pressed.connect(_on_quit_button_pressed)
	back_button.pressed.connect(_on_back_button_pressed)

	# Sliders
	master_slider.value_changed.connect(_on_master_slider_changed)
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	ui_slider.value_changed.connect(_on_ui_slider_changed)

	# Optional slider hover sound
	master_slider.mouse_entered.connect(UISfx.play_hover)
	music_slider.mouse_entered.connect(UISfx.play_hover)
	sfx_slider.mouse_entered.connect(UISfx.play_hover)
	ui_slider.mouse_entered.connect(UISfx.play_hover)

	# Optional drag-end focus clear
	master_slider.drag_ended.connect(_on_slider_drag_ended.bind(master_slider))
	music_slider.drag_ended.connect(_on_slider_drag_ended.bind(music_slider))
	sfx_slider.drag_ended.connect(_on_slider_drag_ended.bind(sfx_slider))
	ui_slider.drag_ended.connect(_on_slider_drag_ended.bind(ui_slider))

	# Load saved settings
	master_slider.value = SettingsState.master_percent
	music_slider.value = SettingsState.music_percent
	sfx_slider.value = SettingsState.sfx_percent
	ui_slider.value = SettingsState.ui_percent

	_update_volume_labels()
	SettingsState.apply_all_buses()

func _on_resume_button_pressed() -> void:
	get_tree().paused = false
	visible = false

func _on_volume_button_pressed() -> void:
	main_buttons.visible = false
	volume_panel.visible = true

func _on_back_button_pressed() -> void:
	volume_panel.visible = false
	main_buttons.visible = true

func _on_main_menu_button_pressed() -> void:
	get_tree().paused = false
	MusicManager.play_menu()
	get_tree().change_scene_to_file(main_menu_scene)

func _on_quit_button_pressed() -> void:
	get_tree().quit()

func _on_master_slider_changed(value: float) -> void:
	SettingsState.set_master_percent(value)
	master_value_label.text = str(int(value)) + "%"
	_play_slider_tick()

func _on_music_slider_changed(value: float) -> void:
	SettingsState.set_music_percent(value)
	music_value_label.text = str(int(value)) + "%"
	_play_slider_tick()

func _on_sfx_slider_changed(value: float) -> void:
	SettingsState.set_sfx_percent(value)
	sfx_value_label.text = str(int(value)) + "%"
	_play_slider_tick()

func _on_ui_slider_changed(value: float) -> void:
	SettingsState.set_ui_percent(value)
	ui_value_label.text = str(int(value)) + "%"
	_play_slider_tick()

func _update_volume_labels() -> void:
	master_value_label.text = str(int(master_slider.value)) + "%"
	music_value_label.text = str(int(music_slider.value)) + "%"
	sfx_value_label.text = str(int(sfx_slider.value)) + "%"
	ui_value_label.text = str(int(ui_slider.value)) + "%"

func _play_slider_tick() -> void:
	var now := Time.get_ticks_msec() / 1000.0
	if now - _last_tick_time > TICK_COOLDOWN:
		UISfx.play_slider_tick()
		_last_tick_time = now

func _on_slider_drag_ended(_value_changed: bool, slider: HSlider) -> void:
	slider.release_focus()
