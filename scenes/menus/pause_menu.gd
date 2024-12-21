extends "res://scenes/menus/menu_overlay.gd"

const SETTINGS_MENU = preload("res://scenes/menus/settings_menu.tscn")


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"


func _on_close_button_pressed() -> void:
	close()


func _on_settings_button_pressed() -> void:
	var menu = SETTINGS_MENU.instantiate()
	get_tree().root.add_child(menu)
