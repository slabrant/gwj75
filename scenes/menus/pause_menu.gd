extends Control

@onready var world: Node = get_tree().root.get_child(0).find_child("World")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_main_menu_button_pressed() -> void:
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_close_button_pressed() -> void:
	world.allow_input(true)
	queue_free()
