extends "res://scenes/menus/menu_overlay.gd"

@onready var win_label: Label = $WinLabel
@onready var score: AnimatedSprite2D = $Score


func _ready() -> void:
	super()
	win_label.text = "Good job! You did it with " + str(level.mirror_count) + " mirrors and " + str(level.shot_count) + " shots."
	score.frame = world.level_score


func close() -> void:
	level.open_menu = null
	queue_free()


func _on_next_level_button_pressed() -> void:
	close()
	world.level_id += 1
	if world.level_id < len(world.level_resources.level_paths):
		world.scene_path = world.level_resources.level_paths[world.level_id]
	else:
		world.scene_path = "res://scenes/menus/credit_menu.tscn"


func _on_main_menu_button_pressed() -> void:
	close()
	world.scene_path = "res://scenes/menus/start_menu.tscn"
