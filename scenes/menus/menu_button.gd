extends TextureButton

const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")

var open_pause_menu: Control


func _on_pressed() -> void:
	if open_pause_menu:
		open_pause_menu.close()
	else:
		var pause_menu = PAUSE_MENU.instantiate()
		pause_menu.menu_button = self
		get_tree().root.add_child(pause_menu)
		open_pause_menu = pause_menu
