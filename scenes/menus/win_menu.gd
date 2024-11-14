extends Control

@onready var level: Node = get_tree().root.get_child(0).find_child("Level")
@onready var win_label: Label = $WinLabel

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	level.open_menu = self
	position = Vector2(-size.x/2, -size.y/2)
	win_label.text = "Good job! You did it with " + str(level.mirror_count) + " mirrors and " + str(level.shot_count) + " shots."


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass


func close() -> void:
	level.open_menu = null
	queue_free()


func _on_next_level_button_pressed() -> void:
	close()
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")


func _on_main_menu_button_pressed() -> void:
	close()
	get_tree().change_scene_to_file("res://scenes/menus/start_menu.tscn")
