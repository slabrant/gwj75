extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene


func close() -> void:
	level.open_menu = null
	queue_free()


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"


func _on_close_button_pressed() -> void:
	close()
