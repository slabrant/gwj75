extends Control

@onready var world: Node = get_tree().root.get_child(0)


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	pass # Replace with function body.


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func _on_play_button_pressed() -> void:
	world.scene_path = "res://scenes/levels/level_1.tscn"
	#get_tree().change_scene_to_file("res://scenes/levels/level_1.tscn")


func _on_level_select_button_pressed() -> void:
	world.scene_path = "res://scenes/menus/level_select_menu.tscn"
	#get_tree().change_scene_to_file("res://scenes/menus/level_select_menu.tscn")
