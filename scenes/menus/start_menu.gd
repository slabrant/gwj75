extends Control

@onready var world: Node = get_tree().root.get_child(0)
var level_resources = load("res://scenes/level_list.tres")


func _on_play_button_pressed() -> void:
	world.scene_path = level_resources.level_paths[world.level_id]


func _on_level_select_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/level_select_menu.tscn"
