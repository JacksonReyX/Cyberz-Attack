extends CanvasLayer
@onready var textboxContainer = $TextboxContainer
@onready var chat = $TextboxContainer/MarginContainer/Panel/HBoxContainer/chat

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	addText("I WANT TO HACK YOU")


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass
	
func hideTextbox():
	chat.text = ""
	textboxContainer.hide()
	
func showTextbox():
	textboxContainer.show()
	
func addText(newText):
	chat.text = newText
	


func _on_visibility_changed() -> void:
	
	chat.visible_ratio = 0.0
	var tween = create_tween()
	tween.tween_property(chat, "visible_ratio", 1.0, 2)
