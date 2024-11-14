extends Button

@onready var world: Node = get_tree().root.get_child(0)

@export var level_path : String = ""
@export var level_id : int


func _on_pressed() -> void:
	world.level_id = level_id
	world.scene_path = "res://scenes/levels/" + level_path
