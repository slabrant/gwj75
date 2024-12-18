extends "res://scenes/menus/menu_page.gd"

var level_resources = load("res://scenes/level_list.tres")


func _on_play_button_pressed() -> void:
	world.scene_path = level_resources.level_paths[world.level_id]


func _on_level_select_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/level_select_menu.tscn"


func _on_controls_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/controls_menu.tscn"
