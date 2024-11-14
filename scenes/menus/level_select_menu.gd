extends Control

@onready var world: Node = get_tree().root.get_child(0)

const LevelListResource = preload("res://scenes/level_list_resource.gd")
var dir = DirAccess.open("res://scenes/levels")
var level_resources = load("res://scenes/level_list.tres")
var level_paths = []

const LEVEL_BUTTON = preload("res://scenes/menus/level_button.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	if dir:
		populate_level_paths(level_paths)
	load_level_paths(level_resources)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func populate_level_paths(levels):
	for file in dir.get_files():
		levels.append("res://scenes/levels/" + file.get_file())
	save_level_paths(levels)


func save_level_paths(save_levels: Array):
	var level_list_resource = LevelListResource.new()
	level_list_resource.level_paths = save_levels
	
	ResourceSaver.save(level_list_resource, "res://scenes/level_list.tres")


func load_level_paths(levels):
	var file_count: int = 0
	for level in levels.level_paths:
		var level_button = LEVEL_BUTTON.instantiate()
		level_button.position = Vector2((file_count % 4 + 1) * 150 - 125, (floor(file_count/4) + 1) * 64)
		level_button.level_path = level.get_file()
		file_count += 1
		level_button.text = "Level " + str(file_count)
		add_child(level_button)


func _on_main_menu_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/start_menu.tscn"
