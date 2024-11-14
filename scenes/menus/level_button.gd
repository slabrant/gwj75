extends Button

@onready var world: Node = get_tree().root.get_child(0)

@export var level_path : String = ""


func _on_pressed() -> void:
	world.scene_path = "res://scenes/levels/" + level_path
