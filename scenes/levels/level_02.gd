extends "res://scenes/level.gd"
@onready var label: Label = $Label
@onready var label_2: Label = $Label2


func _on_build_mode_button_pressed() -> void:
	super()
	if is_build_mode:
		label.hide()
		label_2.show()
	else:
		label.show()
		label_2.hide()
