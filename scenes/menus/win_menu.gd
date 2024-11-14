extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene.find_child("Level")
@onready var win_label: Label = $WinLabel
var level_resources = load("res://scenes/level_list.tres")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.open_menu = self
	position = Vector2(-size.x/2, -size.y/2)
	win_label.text = "Good job! You did it with " + str(level.mirror_count) + " mirrors and " + str(level.shot_count) + " shots."


func close() -> void:
	level.open_menu = null
	queue_free()


func _on_next_level_button_pressed() -> void:
	close()
	world.scene_path = level_resources.level_paths[world.level_id + 1]


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"
