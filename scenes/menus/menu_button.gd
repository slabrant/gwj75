extends TextureButton

@onready var world: Node = get_tree().root.get_child(0).find_child("World")
const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")


func _on_pressed() -> void:
	if world.open_menu:
		world.open_menu.close()
	else:
		var menu = PAUSE_MENU.instantiate()
		get_tree().root.add_child(menu)
