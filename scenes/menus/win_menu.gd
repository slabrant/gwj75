extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
@onready var win_label: Label = $WinLabel
var level_resources = load("res://scenes/level_list.tres")


func _ready() -> void:
	level.open_menu = self
	#position = Vector2(-size.x/2, -size.y/2)
	win_label.text = "Good job! You did it with " + str(level.mirror_count) + " mirrors and " + str(level.shot_count) + " shots.\n" + str(world.level_score) + " / 3"


func close() -> void:
	level.open_menu = null
	queue_free()


func _on_next_level_button_pressed() -> void:
	close()
	world.level_id += 1
	if world.level_id < len(level_resources.level_paths):
		world.scene_path = level_resources.level_paths[world.level_id]
	else:
		world.scene_path = "res://scenes/menus/credit_menu.tscn"


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"
