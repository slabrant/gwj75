extends Node

var dir = DirAccess.open("res://scenes/levels")
var level_paths = []
@onready var label: Label = $Label

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
@export var level_id : int = 0
@export var scores : Dictionary
@export var level_score : int = 0:
	set(value):
		scores[level_id] = value
		level_score = value
@export var bullet_speed_setting : int = 7
@export var position_snapping_setting : bool = true
@export var rotation_snap_angle_setting : float = 22.5
@export var slow_rotation_setting : bool = false
@export var level_resources = preload("res://scenes/level_list_resource.gd").new()



func _ready() -> void:
	scene_path = "res://scenes/menus/start_menu.tscn"
	if dir:
		populate_level_paths(level_paths)
	else:
		level_resources = load("res://scenes/level_list.tres")
	
	label.text += "# of level ths: " + str(level_resources) + "\n"
	label.text += "# of levels: " + str(len(level_resources.level_paths)) + "\n"



func toggle_input(enable: bool):
	disable_input_recursive(get_tree().root, enable)


func disable_input_recursive(node: Node, enable):
	node.set_process(enable)
	node.set_physics_process(enable)
	for child in node.get_children():
		disable_input_recursive(child, enable)


func populate_level_paths(popultate_level_paths):
	for file in dir.get_files():
		if file.get_extension() == "tscn":
			popultate_level_paths.append("res://scenes/levels/" + file.get_file())
	
	level_resources.level_paths = popultate_level_paths
	ResourceSaver.save(level_resources, "res://scenes/level_list.tres")
