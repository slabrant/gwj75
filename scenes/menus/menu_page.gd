extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene


func close() -> void:
	if 'open_menu' in level and level.open_menu:
		queue_free()
		level.open_menu = null
	else:
		world.scene_path = "res://scenes/menus/start_menu.tscn"
