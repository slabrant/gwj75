extends Control

@onready var world: Node = get_tree().root.find_child("World")
#@onready var level: world.scene


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	#level.open_menu = self
	position = Vector2(-size.x/2, -size.y/2)


func close() -> void:
	#level.open_menu = null
	queue_free()


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"


func _on_close_button_pressed() -> void:
	close()
