extends Control

@onready var world: Node = get_tree().root.get_child(0)

const LevelListResource = preload("res://scenes/level_list_resource.gd")
var dir = DirAccess.open("res://scenes/levels")
var level_resources = load("res://scenes/level_list.tres")
var level_paths = []

const LEVEL_BUTTON = preload("res://scenes/menus/level_button.tscn")


func _ready() -> void:
	if dir:
		populate_level_paths(level_paths)
	load_level_buttons(level_resources.level_paths)


func populate_level_paths(levels):
	for file in dir.get_files():
		levels.append("res://scenes/levels/" + file.get_file())
	save_level_paths(levels)


func save_level_paths(save_levels: Array):
	var level_list_resource = LevelListResource.new()
	level_list_resource.level_paths = save_levels
	
	ResourceSaver.save(level_list_resource, "res://scenes/level_list.tres")


func load_level_buttons(levels):
	var level_id: int = 0
	for level in levels:
		var level_button = LEVEL_BUTTON.instantiate()
		if level_id in world.scores:
			level_button.level_score = world.scores[level_id]
		
		level_button.level_path = level.get_file()
		level_button.level_id = level_id
		add_child(level_button)
		level_id += 1


func _on_main_menu_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/start_menu.tscn"
