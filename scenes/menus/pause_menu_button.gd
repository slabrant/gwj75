extends TextureButton

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
const PAUSE_MENU = preload("res://scenes/menus/pause_menu.tscn")


func _on_pressed() -> void:
	if level.open_menu:
		level.open_menu.close()
	else:
		var menu = PAUSE_MENU.instantiate()
		get_tree().root.add_child(menu)
