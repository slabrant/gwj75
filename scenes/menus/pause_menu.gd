extends "res://scenes/menus/menu_overlay.gd"


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"


func _on_close_button_pressed() -> void:
	close()
