extends Node

const LevelListResource = preload("res://scenes/level_list_resource.gd")
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
@export var bullet_speed_setting : int = 50:
	set(value):
		if 100 < value:
			value = 100
		elif value < 10:
			value = 10
		bullet_speed_setting = value 
@export var position_snapping_setting : bool = true
@export var rotation_snap_angle_setting : float = 15
@export var slow_rotation_setting : bool = false
@export var level_resources = LevelListResource.new()
@export var beams : Array = []


func _ready() -> void:
	scene_path = "res://scenes/menus/start_menu.tscn"
	if dir:
		populate_level_paths(level_paths)
		label.text = "v" + Time.get_datetime_string_from_system()
	level_resources = load("res://scenes/level_list.tres")


func toggle_input(enable: bool):
	disable_input_recursive(get_tree().root, enable)


func disable_input_recursive(node: Node, enable):
	node.set_process(enable)
	node.set_physics_process(enable)
	for child in node.get_children():
		disable_input_recursive(child, enable)


func populate_level_paths(popultate_level_paths):
	for file in dir.get_files():
		if file.get_extension() != "tscn" and file.get_extension() != "gd":
			return false
		
		popultate_level_paths.append("res://scenes/levels/" + file.get_file())
	
	var new_level_resources = LevelListResource.new()
	new_level_resources.level_paths = popultate_level_paths
	ResourceSaver.save(new_level_resources, "res://scenes/level_list.tres")
