extends Control

@onready var world: Node = get_tree().root.get_child(0)

const LEVEL_BUTTON = preload("res://scenes/menus/level_button.tscn")


func _ready() -> void:
	var level_resources = load("res://scenes/level_list.tres")
	load_level_buttons(world.level_list_resource.level_paths)


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
