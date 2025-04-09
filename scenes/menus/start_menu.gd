extends "res://scenes/menus/menu_page.gd"


func _on_play_button_pressed() -> void:
	world.scene_path = world.level_paths[world.level_id]


func _on_level_select_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/level_select_menu.tscn"


func _on_controls_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/controls_menu.tscn"
