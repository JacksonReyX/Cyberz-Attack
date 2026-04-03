extends Control

@export_file("*.tscn") var main_menu_scene := "res://Scenes/KianStuff/MainMenu.tscn"

@onready var master_slider: HSlider = %MasterSlider
@onready var music_slider: HSlider = %MusicSlider
@onready var sfx_slider: HSlider = %SFXSlider
@onready var ui_slider: HSlider = %UISFXSlider
@onready var back_button: TextureButton = %BackButton

@onready var master_value_label: Label = %MasterValueLabel
@onready var music_value_label: Label = %MusicValueLabel
@onready var sfx_value_label: Label = %SFXValueLabel
@onready var ui_value_label: Label = %UISFXValueLabel

func _ready() -> void:
	UISfx.wire_buttons(self)

	master_slider.value_changed.connect(_on_master_slider_changed)
	music_slider.value_changed.connect(_on_music_slider_changed)
	sfx_slider.value_changed.connect(_on_sfx_slider_changed)
	ui_slider.value_changed.connect(_on_ui_slider_changed)
	back_button.pressed.connect(_on_back_button_pressed)
	
	master_slider.drag_ended.connect(_on_slider_drag_ended.bind(master_slider))
	music_slider.drag_ended.connect(_on_slider_drag_ended.bind(music_slider))
	sfx_slider.drag_ended.connect(_on_slider_drag_ended.bind(sfx_slider))
	ui_slider.drag_ended.connect(_on_slider_drag_ended.bind(ui_slider))
	
	master_slider.mouse_entered.connect(UISfx.play_hover)
	music_slider.mouse_entered.connect(UISfx.play_hover)
	sfx_slider.mouse_entered.connect(UISfx.play_hover)
	ui_slider.mouse_entered.connect(UISfx.play_hover)

	# Load saved values instead of resetting
	master_slider.value = SettingsState.master_percent
	music_slider.value = SettingsState.music_percent
	sfx_slider.value = SettingsState.sfx_percent
	ui_slider.value = SettingsState.ui_percent
	
	master_value_label.text = str(int(master_slider.value)) + "%"
	music_value_label.text = str(int(music_slider.value)) + "%"
	sfx_value_label.text = str(int(sfx_slider.value)) + "%"
	ui_value_label.text = str(int(ui_slider.value)) + "%"

	SettingsState.apply_all_buses()

func _on_master_slider_changed(value: float) -> void:
	SettingsState.set_master_percent(value)
	master_value_label.text = str(int(value)) + "%"
	UISfx.play_slider_tick()

func _on_music_slider_changed(value: float) -> void:
	SettingsState.set_music_percent(value)
	music_value_label.text = str(int(value)) + "%"
	UISfx.play_slider_tick()

func _on_sfx_slider_changed(value: float) -> void:
	SettingsState.set_sfx_percent(value)
	sfx_value_label.text = str(int(value)) + "%"
	UISfx.play_slider_tick()

func _on_ui_slider_changed(value: float) -> void:
	SettingsState.set_ui_percent(value)
	ui_value_label.text = str(int(value)) + "%"
	UISfx.play_slider_tick()

func _on_back_button_pressed() -> void:
	get_tree().change_scene_to_file(main_menu_scene)
	
func _on_slider_drag_ended(_value_changed: bool, slider: HSlider) -> void:
	slider.release_focus()
