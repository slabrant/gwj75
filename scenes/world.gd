extends Node

@export var scene_path : String:
	set(value):
		scene = load(value).instantiate()
		scene_path = value
@export var scene : Node:
	set(value):
		if !!scene:
			scene.queue_free()
		scene = value
		add_child(value)
@export var level_id : int
@export var scores : Dictionary
@export var level_score : int = 0:
	set(value):
		scores[level_id] = value
		level_score = value


func _ready() -> void:
	scene_path = "res://scenes/menus/start_menu.tscn"


func toggle_input(enable: bool):
	disable_input_recursive(get_tree().root, enable)


func disable_input_recursive(node: Node, enable):
	node.set_process(enable)
	node.set_physics_process(enable)
	for child in node.get_children():
		disable_input_recursive(child, enable)
