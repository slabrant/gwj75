extends Control

@onready var world: Node = get_tree().root.get_child(0)
@onready var level: Node = world.scene
@onready var label: Label = $Label

var level_resources = load("res://scenes/level_list.tres")


func _ready() -> void:
	label.text += "# of level ths: " + str(level_resources) + "\n"
	label.text += "# of levels: " + str(len(level_resources.level_paths)) + "\n"


func _on_play_button_pressed() -> void:
	world.scene_path = level_resources.level_paths[world.level_id]


func _on_level_select_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/level_select_menu.tscn"


func _on_controls_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/controls_menu.tscn"
