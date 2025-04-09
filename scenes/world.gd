extends Node

const WorldData = preload("res://scenes/world_data.gd")
var level_dir = DirAccess.open("res://scenes/levels")
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
@export var build_time: String = "":
	set(value):
		label.text = value
		build_time = value
@export var level_paths: Array = []
var world_data = WorldData.new():
	set(value):
		level_paths = value.level_paths
		build_time = value.build_time
		world_data = value
@export var beams : Array = []


func _ready() -> void:
	scene_path = "res://scenes/menus/start_menu.tscn"
	load_world_data()


func toggle_input(enable: bool):
	disable_input_recursive(get_tree().root, enable)


func disable_input_recursive(node: Node, enable):
	node.set_process(enable)
	node.set_physics_process(enable)
	for child in node.get_children():
		disable_input_recursive(child, enable)


func load_world_data():
	world_data = load("res://scenes/world_data.tres")
	if OS.has_feature("editor"):
		populate_level_paths()
		populate_build_time()
		ResourceSaver.save(world_data, "res://scenes/world_data.tres")


func populate_level_paths():
	if !level_dir:
		return
	var popultate_level_paths = []
	for file in level_dir.get_files():
		if file.get_extension() != "tscn" and file.get_extension() != "gd":
			return false
		popultate_level_paths.append("res://scenes/levels/" + file.get_file())
	
	level_paths = popultate_level_paths
	world_data.level_paths = level_paths


func populate_build_time():
	build_time = "v" + Time.get_datetime_string_from_system()
	world_data.build_time = build_time
