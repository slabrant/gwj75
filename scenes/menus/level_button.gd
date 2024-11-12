extends Button

@export var level_path : String = ""


func _on_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/levels/" + level_path)
