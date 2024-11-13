extends Control

@onready var world: Node = get_tree().root.get_child(0).find_child("World")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	world.open_menu = self
	position = Vector2(-size.x/2, -size.y/2)


func close() -> void:
	world.open_menu = null
	queue_free()


func _on_main_menu_button_pressed() -> void:
	close()
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_close_button_pressed() -> void:
	close()
