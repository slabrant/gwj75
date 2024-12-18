extends "res://scenes/menus/menu_page.gd"


func _on_close_button_pressed() -> void:
	close()

func close() -> void:
	if 'open_menu' in level and level.open_menu:
		queue_free()
		level.open_menu = null
	else:
		world.scene_path = "res://scenes/menus/start_menu.tscn"
